//
//  TransactionFeedViewController.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class TransactionFeedViewController: UIViewController {
    @IBOutlet var transactionsTableView: UITableView!

    @IBOutlet var popularCategoriesCollectionView: UICollectionView!

    @IBOutlet var searchResultsView: UIView!

    @IBOutlet var totalExpensesLabel: UILabel!
    @IBOutlet var totalIncomeLabel: UILabel!

    @IBOutlet var dateRangeLabel: UILabel!

    @IBOutlet var dateFilterButton: UIButton!

    var account: AccountComposite!

    let dataSource = RxTableViewSectionedReloadDataSource<TransactionSectionData>(
        configureCell: TransactionFeedViewController.tableViewDataSourceUI()
    )

    let disposeBag: DisposeBag = .init()
    var viewModel: TransactionsViewModel!

    static func tableViewDataSourceUI() -> (
        TableViewSectionedDataSource<TransactionSectionData>.ConfigureCell
    ) {
        return { _, tableView, _, element in

            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: TransactionCell.identifier
                ) as? TransactionCell
            else {
                fatalError("Transaction cell not implemented")
            }

            cell.configure(transaction: element)

            return cell
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TransactionsViewModel(accountId: Session.shared.accountId)

        // setup activity indicator
        setupActivityIndicator()

        setupBinding()
        setupLabels()
        setupHiddenSearchView()

        // setup date labels
        configureDateFilter()
        setupDateRangeLabel()

        // Popular Collection View Setup
        setupDataSourceCollectionView()

        viewModel.refreshData()
    }
}

// - MARK: Rx setup
extension TransactionFeedViewController {
    func setupHiddenSearchView() {
        viewModel.dataSource
            .map { transactions in

                let isEmpty = Set(transactions
                    .compactMap { !$0.items.isEmpty })

                return isEmpty.count == 1 ? isEmpty.first! : true
            }
            .asDriver(onErrorJustReturn: true)
            .do(onNext: { success in

                UIView.animate(withDuration: 0.25) {
                    if success {
                        self.searchResultsView.alpha = 0
                    } else {
                        self.searchResultsView.alpha = 1
                    }
                }

            })
            .drive(searchResultsView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.dataSource
            .map { transactions in

                transactions
                    .compactMap { $0.items }
                    .allSatisfy { $0.isEmpty }
            }
            .asDriver(onErrorJustReturn: true)
            .drive(transactionsTableView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    func setupLabels() {
        viewModel.dataSource
            .map { transactions -> String in

                let income = transactions
                    .filter { $0.header == TransactionType.income.rawValue.capitalized }
                    .flatMap { $0.items }
                    .filter { $0.direction == .IN }

                let minorUnitsAggregated = income
                    .compactMap { $0.amount?.minorUnits }
                    .reduce(0, +)

                let formattedAmount = self.currencyFormatter(value: minorUnitsAggregated)

                return "\(formattedAmount)"
            }
            .asDriver(onErrorJustReturn: "£0.00")
            .drive(totalIncomeLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.dataSource
            .map { transactions -> String in

                let expenses = transactions
                    .filter { $0.header == TransactionType.expense.rawValue.capitalized }
                    .flatMap { $0.items }
                    .filter { $0.direction == .OUT }

                let minorUnitsAggregated = expenses
                    .compactMap { $0.amount?.minorUnits }
                    .reduce(0, +)

                let formattedAmount = self.currencyFormatter(value: minorUnitsAggregated)

                return "\(formattedAmount)"
            }
            .asDriver(onErrorJustReturn: "£0.00")
            .drive(totalExpensesLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func setupActivityIndicator() {
        viewModel.isLoading
            .subscribe(onNext: { isLoading in
                if isLoading {
                    self.startAnimating(CGSize(width: 80, height: 80),
                                        message: "Loading accounts..",
                                        messageFont: UIFont(name: "Futura-Medium", size: 21),
                                        type: .ballBeat,
                                        color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),
                                        padding: 10,
                                        textColor: .white)
                } else {
                    self.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
    }

    func setupBinding() {
        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].header
        }

        dataSource.canMoveRowAtIndexPath = { _, _ in
            true
        }

        viewModel.dataSource
            .asDriver(onErrorJustReturn: [])
            .drive(transactionsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        transactionsTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        transactionsTableView.rx.modelSelected(STTransactionFeed.self)
            .subscribe { event in
                switch event {
                case let .next(transaction):

                    guard let vc = TransactionDetailsViewController
                        .makeTransactionDetailsViewController(transaction: transaction)
                    else {
                        return
                    }

                    self.present(vc,
                                 animated: true,
                                 completion: nil)

                case let .error(error):
                    self.displayErrorAlert(error: error)
                case .completed:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}

extension TransactionFeedViewController: CurrencyFormattable {}

// - MARK: Rx setup CollectionView
extension TransactionFeedViewController {
    func setupDataSourceCollectionView() {
        viewModel.dataSource
            .map { transactions -> Set<SpendingCategory> in

                let items = transactions.compactMap { $0.items }

                let allSpendingCategories = Set(items
                    .flatMap { $0 }
                    .compactMap { $0.spendingCategory })

                return allSpendingCategories
            }
            .bind(to: popularCategoriesCollectionView.rx
                .items(cellIdentifier: PopularCell.identifier,
                       cellType: PopularCell.self)) { _, element, cell in

                cell.configure(spendingCategory: element)
            }
            .disposed(by: disposeBag)
    }

    func configureDateFilter() {
        dateFilterButton.rx.tap.asObservable()
            .subscribe { _ in
                self.presentDateAlert()
            }
            .disposed(by: disposeBag)
    }

    func setupDateRangeLabel() {
        viewModel.dateRange
            .bind(to: dateRangeLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func presentDateAlert() {
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\nDate range",
                                                message: "This will filter one week from the input date",
                                                preferredStyle: .alert)

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)

        alertController.view.addSubview(datePicker)

        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.viewModel.refreshData(with: datePicker.date.toStringDateFormat())
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
