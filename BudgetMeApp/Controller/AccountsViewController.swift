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
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.title = "Welcome to BudgetMe"

    }

    func presentDownloadAlert() {

        let alert = UIAlertController(title: "Select file type for statement", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "PDF", style: .default, handler: { _ in

            let yearMonth = alert.textFields![0].text!

            self.viewModel.downloadPDFStatement(accountId: Session.shared.accountId, yearMonth: yearMonth)
                .asSingle()
                .subscribe { event in
                    switch event {
                        case .success:
                            self.showSuccessAlert()
                        case .error(let error):
                            self.viewModel.errorPublisher.onNext(error)
                    }
            }
            .disposed(by: self.disposeBag)

        }))

        alert.addAction(UIAlertAction(title: "CSV", style: .default, handler: { _ in

            let yearMonth = alert.textFields![1].text!

            self.viewModel.downloadCSVStatement(accountId: Session.shared.accountId, yearMonth: yearMonth)
                .asSingle()
                .subscribe { event in
                    switch event {
                        case .success:
                            self.showSuccessAlert()
                        case .error(let error):
                            self.viewModel.errorPublisher.onNext(error)
                    }
            }
            .disposed(by: self.disposeBag)

        }))

        alert.addTextField { tf in
            tf.placeholder = "e.g. 2020-03 PDF"
        }

        alert.addTextField { tf in
            tf.placeholder = "e.g. 2020-03 CSV"
        }

        self.present(alert, animated: true, completion: nil)

    }

    func showSuccessAlert() {

        let alert = UIAlertController(title: "Download success", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
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
                Session.shared.accountId = accountsComposite.account.accountUid

                self.performSegue(withIdentifier: "TabSegue", sender: nil)

            })
            .disposed(by: disposeBag)

    }

}
