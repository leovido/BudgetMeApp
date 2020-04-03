//
//  AccountsViewController+Alerts.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 01/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit

extension AccountsViewController {

    func performDownloadPDF(yearMonth: String) {
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
    }

    func performDownloadCSV(yearMonth: String) {
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
    }

    func presentDownloadAlert() {

        let alert = UIAlertController(title: "Select file type for statement", message: "", preferredStyle: .alert)

        let pdfAction = UIAlertAction(title: "PDF", style: .default, handler: { _ in

            let yearMonth = alert.textFields![0].text!
            self.performDownloadPDF(yearMonth: yearMonth)

        })

        let csvAction = UIAlertAction(title: "CSV", style: .default, handler: { _ in

            let yearMonth = alert.textFields![0].text!
            self.performDownloadCSV(yearMonth: yearMonth)

        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(pdfAction)
        alert.addAction(csvAction)

        alert.addTextField { tf in
            tf.placeholder = "e.g. 2020-03"
        }

        self.present(alert, animated: true, completion: nil)

    }

    func showSuccessAlert() {

        let alert = UIAlertController(title: "Download success", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

}
