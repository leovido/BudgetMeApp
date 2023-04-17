//
//  SomeViewController.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class SavingsViewController: UIViewController {
  @IBOutlet var savingsTableView: UITableView!
  @IBOutlet var totalSavingsLabel: UILabel!
  @IBOutlet var createNewSavingGoal: UIButton!

  let disposeBag: DisposeBag = .init()
  var viewModel: SavingsViewModel!

  override func viewDidAppear(_: Bool) {
    super.viewDidAppear(true)

    parent?.title = "Savings"
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel = SavingsViewModel()

    setupBinding()
    setupButton()

    viewModel.refreshData()
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
      .asDriver()
      .drive(savingsTableView
        .rx
        .items(cellIdentifier: SavingsCell.identifier,
               cellType: SavingsCell.self))
      { _, element, cell in

        cell.configureSavings(savings: element)
      }
      .disposed(by: disposeBag)
  }
}

extension SavingsViewController {
  func presentAlert() {
    let alert = UIAlertController(title: "Saving goal name", message: "", preferredStyle: .alert)

    let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { _ in

      let sampleName = alert.textFields?[0].text
//            let targetAmount = alert.textFields?[1].text

      self.viewModel.createNewSaving(name: sampleName ?? "Saving sample")

    })

    let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

    alert.addTextField(configurationHandler: { textField in
      textField.placeholder = "e.g. Summer holiday 2025"
    })

    alert.addTextField(configurationHandler: { textField in
      textField.placeholder = "e.g. target amount 2000"
    })

    alert.addAction(yesAction)
    alert.addAction(noAction)

    present(alert, animated: true, completion: nil)
  }
}
