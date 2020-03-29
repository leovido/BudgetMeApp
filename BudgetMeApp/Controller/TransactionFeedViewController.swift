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

class TransactionFeedViewController: UIViewController {

    @IBOutlet weak var transactionsTableView: UITableView!

    @IBOutlet weak var datePickerFilter: UIDatePicker!

    @IBOutlet weak var totalExpensesLabel: UILabel!
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var tranferButton: UIButton!

    let disposeBag: DisposeBag = DisposeBag()
    var viewModel: TransactionsViewModel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if Session.shared.accountId.isEmpty {
            presentAlert()
        } else {
            viewModel.refreshData()
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TransactionsViewModel(accountId: Session.shared.accountId)

        setupTransferButton()
        setupBinding()
        setupButton()
        setupDatePicker()

        navigationController?.navigationBar.prefersLargeTitles = true
        self.parent?.title = "Transaction Feed"
    }

}

// - MARK: Rx setup
extension TransactionFeedViewController {

    private func performTransfer(viewModel: SavingsViewModel, amount: MinorUnits, savingsGoalUid: String) {
        viewModel.addAmount(amount: amount, to: savingsGoalUid)
    }

    func presentAlert() {

        let alert = UIAlertController(title: "Account not selected",
                                      message: "Please select account to fetch the transactions",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)

    }

    func presentAlert(roundUpAmount: MinorUnits) {

        let alert = UIAlertController(title: "Transfer \(viewModel.savingsDisplayString)",
            message: "Please select account to transfer round up savings",
            preferredStyle: .alert)

        let viewModel = SavingsViewModel()

        viewModel.refreshData {

            let savings = viewModel.dataSource.value

            savings.forEach { saving in
                let action = UIAlertAction(title: saving.name, style: .default) { action in

                    self.performTransfer(viewModel: viewModel,
                                         amount: roundUpAmount,
                                         savingsGoalUid: saving.savingsGoalUid)

                }

                alert.addAction(action)

            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)

            self.present(alert, animated: true, completion: nil)

        }


    }

    func setupTransferButton() {
        tranferButton.rx.tap
        .asObservable()
        .subscribe { event in

            self.presentAlert(roundUpAmount: self.viewModel.savings)
        }
        .disposed(by: disposeBag)
    }

    func setupButton() {

        viewModel.isLoading
        .asObserver()
        .subscribe(onNext: { value in
            value == true ? self.fetchButton.setTitle("Loading..", for: .normal) : self.fetchButton.setTitle("Fetch", for: .normal)
        })
        .disposed(by: disposeBag)

        fetchButton.rx.tap
            .asObservable()
            .subscribe { event in
                self.viewModel.refreshData()
            }
            .disposed(by: disposeBag)

    }

    func setupBinding() {

        viewModel.dataSource
            .debug()
            .bind(to: transactionsTableView
                .rx
                .items(cellIdentifier: TransactionCell.identifier,
                       cellType: TransactionCell.self)) { row, element, cell in

                        cell.configure(value: element)

            }
            .disposed(by: disposeBag)

        viewModel.dataSource
            .asDriver(onErrorJustReturn: [])
            .drive(transactionsTableView
                .rx.items(dataSource: self.dataSource))
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
