//
//  TransactionFeedViewController.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TransactionFeedViewController: UIViewController {

    var account: STAccount!

    @IBOutlet weak var transactionsTableView: UITableView!

	@IBOutlet weak var searchResultsView: UIView!

    @IBOutlet weak var datePickerFilter: UIDatePicker!

    @IBOutlet weak var totalExpensesLabel: UILabel!
    @IBOutlet weak var totalIncomeLabel: UILabel!

    let dataSource = RxTableViewSectionedReloadDataSource<TransactionSectionData>(configureCell: TransactionFeedViewController.tableViewDataSourceUI())

    let disposeBag: DisposeBag = DisposeBag()
    var viewModel: TransactionsViewModel!

    static func tableViewDataSourceUI() -> (
        TableViewSectionedDataSource<TransactionSectionData>.ConfigureCell
        ) {
        return { (_, tv, ip, i) in

                guard let cell = tv.dequeueReusableCell(withIdentifier: TransactionCell.identifier) as? TransactionCell else {
                    fatalError("Transaction cell not implemented")
                }

                cell.configure(value: i)
                return cell

        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        self.parent?.title = "Transaction Feed"

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TransactionsViewModel(accountId: Session.shared.accountId)

        setupBinding()
        setupDatePicker()
        setupLabels()
        setupHiddenSearchView()

        viewModel.refreshData()

        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

// - MARK: Rx setup
extension TransactionFeedViewController {

    func setupHiddenSearchView() {

        viewModel.dataSource
            .map({ transactions in

                let isEmpty = Set(transactions
                .compactMap({ !$0.items.isEmpty }))

                return isEmpty.count == 1 ? isEmpty.first! : true

            })
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
            .drive(self.searchResultsView.rx.isHidden)
        .disposed(by: disposeBag)

        viewModel.dataSource
            .map({ transactions in

                return transactions
                    .compactMap({ $0.items })
                    .allSatisfy({ $0.isEmpty })

            })
            .asDriver(onErrorJustReturn: true)
            .drive(self.transactionsTableView.rx.isHidden)
        .disposed(by: disposeBag)

    }

    func setupLabels() {

        viewModel.dataSource
            .map({ transactions -> String in

                let income = transactions
                    .filter({ $0.header == TransactionType.income.rawValue.capitalized })
                    .flatMap({ $0.items })
                    .filter({ $0.direction == .IN })

                let minorUnitsAggregated = income
                    .compactMap({ $0.amount?.minorUnits })
                    .reduce(0, +)

                let formattedAmount = self.currencyFormatter(value: minorUnitsAggregated)

                return "Total income: \(formattedAmount)"

            })
            .asDriver(onErrorJustReturn: "£0.00")
            .drive(self.totalIncomeLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.dataSource
            .map({ transactions -> String in

                let expenses = transactions
                    .filter({ $0.header == TransactionType.expense.rawValue.capitalized })
                    .flatMap({ $0.items })
                    .filter({ $0.direction == .OUT })

                let minorUnitsAggregated = expenses
                    .compactMap({ $0.amount?.minorUnits })
                    .reduce(0, +)

                let formattedAmount = self.currencyFormatter(value: minorUnitsAggregated)

                return "Total expenses: \(formattedAmount)"

            })
            .asDriver(onErrorJustReturn: "£0.00")
            .drive(self.totalExpensesLabel.rx.text)
            .disposed(by: disposeBag)

    }

    func setupBinding() {

        dataSource.titleForHeaderInSection = { dataSource, index in
          return dataSource.sectionModels[index].header
        }

        dataSource.canMoveRowAtIndexPath = { _, _ in
            return true
        }

        viewModel.dataSource
            .asDriver(onErrorJustReturn: [])
            .drive(transactionsTableView
                .rx.items(dataSource: self.dataSource))
        .disposed(by: disposeBag)

        transactionsTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        transactionsTableView.rx.modelSelected(STTransactionFeed.self)
            .subscribe { event in
                switch event {
                case .next(let transaction):

                    self.present(TransactionDetailsViewController
                        .makeTransactionDetailsViewController(transaction: transaction),
                                 animated: true,
                                 completion: nil)

                case .error(let error):
                    self.displayErrorAlert(error: error)
                case .completed:
                    break
                }
            }
        .disposed(by: disposeBag)

    }

    func setupDatePicker() {

        datePickerFilter.date = Date()

        datePickerFilter.rx
            .value
            .asObservable()
            .subscribe({ value in

                self.viewModel.refreshData(with: value.element!.toStringDateFormat())

            })
        .disposed(by: disposeBag)

    }
}

extension TransactionFeedViewController: CurrencyFormattable {}