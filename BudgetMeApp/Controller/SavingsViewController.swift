//
//  SomeViewController.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SavingsViewController: UIViewController {

    @IBOutlet weak var savingsTableView: UITableView!
    @IBOutlet weak var totalSavingsLabel: UILabel!
    @IBOutlet weak var createNewSavingGoal: UIButton!

    let disposeBag: DisposeBag = DisposeBag()
    var viewModel: SavingsViewModel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if Session.shared.accountId.isEmpty {
            presentAlert()
        } else {
            viewModel.refreshData {

            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = SavingsViewModel()

        setupBinding()
        setupButton()

        self.parent?.title = "Savings"

    }

    func setupButton() {

        createNewSavingGoal.rx.tap
            .asObservable()
            .subscribe(onNext: { _ in

                self.presentAlert()

            })
        .disposed(by: disposeBag)

    }

    func setupBinding() {

        viewModel.dataSource
            .debug()
            .bind(to: savingsTableView
                .rx
                .items(cellIdentifier: SavingsCell.identifier,
                       cellType: SavingsCell.self)) { row, element, cell in

                        cell.configureSavings(savings: element)


            }
            .disposed(by: disposeBag)

    }

}

extension SavingsViewController {
    private func presentAlert() {

        let alert = UIAlertController(title: "Saving goal name", message: "", preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { _ in

            let sampleName = alert.textFields?[0].text

            self.viewModel.createNewSaving(name: sampleName ?? "Saving sample")

        })

        let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "e.g. Summer holiday 2025"
        })

        alert.addAction(yesAction)
        alert.addAction(noAction)

        self.present(alert, animated: true, completion: nil)

    }
}
