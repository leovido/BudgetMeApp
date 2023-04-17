//
//  AccountsViewController.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import RxSwift
import UIKit

extension UIViewController {
    func displayErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Something happened..",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}

class AccountsViewController: UIViewController {
    @IBOutlet var accountsTableView: UITableView!
    @IBOutlet var downloadStatementButton: UIButton!

    var selectedAccount: AccountComposite!

    let disposeBag: DisposeBag = .init()
    var viewModel: AccountsViewModel! = AccountsViewModel()

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
        navigationController?.title = "Welcome to BudgetMe"
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
                       cellType: AccountsCell.self)) { _, element, cell in

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

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        SegueManager(segue)?.performSegue(with: selectedAccount)
    }
}
