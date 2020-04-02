//
//  AccountsViewController.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController {
    func displayErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Something happened..", message: error.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}

class AccountsViewController: UIViewController {

    @IBOutlet weak var accountsTableView: UITableView!
    @IBOutlet weak var downloadStatementButton: UIButton!

    var selectedAccount: AccountComposite!

    let disposeBag: DisposeBag = DisposeBag()
    let viewModel: AccountsViewModel = AccountsViewModel()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.refreshData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBinding()
        setupErrorBindings()
        setupButtonDownload()
        setupActivityIndicator()

        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.title = "Welcome to BudgetMe"

    }

    func setupButtonDownload() {
        downloadStatementButton.rx.tap
        .asObservable()
            .subscribe { _ in
                self.presentDownloadAlert()
            }
        .disposed(by: disposeBag)
    }

    func setupErrorBindings() {
        viewModel.errorPublisher
            .subscribe(onNext: { error in
                self.displayErrorAlert(error: error)
            })
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

        viewModel.dataSource
        .asDriver()
            .drive(accountsTableView.rx
                .items(cellIdentifier: AccountsCell.identifier,
                       cellType: AccountsCell.self)) { row, element, cell in

                        cell.configure(value: element)

        }
        .disposed(by: disposeBag)

        accountsTableView
            .rx
            .modelSelected(AccountComposite.self)
            .subscribe(onNext: { accountsComposite in

                self.selectedAccount = accountsComposite
                Session.shared.accountId = accountsComposite.account.accountUid
                self.performSegue(withIdentifier: "TransactionSegue", sender: self)
            })
            .disposed(by: disposeBag)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TransactionSegue" {
            if let destinationVieController = segue.destination as? TransactionFeedViewController {
                destinationVieController.account = self.selectedAccount
            }
        }
    }

}
