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

        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.title = "Welcome to BudgetMe"

    }

    func setupErrorBindings() {
        viewModel.errorPublisher
            .subscribe(onNext: { error in
                self.displayErrorAlert(error: error)
            })
        .disposed(by: disposeBag)
    }

    func setupBinding() {

        viewModel.dataSource
            .debug()
            .bind(to: accountsTableView.rx
                .items(cellIdentifier: AccountsCell.identifier,
                       cellType: AccountsCell.self)) { row, element, cell in

                        cell.configure(value: element)

        }
        .disposed(by: disposeBag)

        accountsTableView
            .rx
            .modelSelected(AccountComposite.self)
            .subscribe(onNext: { accountsComposite in
                Session.shared.accountId = accountsComposite.account.accountUid

                self.performSegue(withIdentifier: "TabSegue", sender: nil)

            })
            .disposed(by: disposeBag)

    }

}
