//
//  TransactionDetailsViewController.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit

class TransactionDetailsViewController: UIViewController {

    var transaction: STTransactionFeed!

    @IBOutlet weak var referenceLabel: UILabel!

    @IBOutlet weak var transactionTimeLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var counterPartyName: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var transactionSourceLabel: UILabel!
    @IBOutlet weak var spendingCategoryLabel: UILabel!
    @IBOutlet weak var transactionSubSourceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()

    }

    func configureView() {
        self.referenceLabel.text = transaction.reference ?? "Default reference"
        self.transactionTimeLabel.text = Date.dateFormatterTime(dateString: transaction.settlementTime ?? "")
        self.transactionDateLabel.text = Date.dateFormatter(dateString: transaction.settlementTime ?? "")

        self.transactionSubSourceLabel.text = transaction.sourceSubType.map { $0.rawValue }
        self.counterPartyName.text = transaction.counterPartyName

        if transaction.direction == .IN {
            self.amountLabel.textColor = UIColor.systemGreen
            self.amountLabel.text = "+" + transaction.amount!.description
        } else {
            self.amountLabel.textColor = UIColor.systemPink
            self.amountLabel.text = "-" + transaction.amount!.description
        }

        self.transactionSourceLabel.text = sourceTransactionAbbreviation(transaction: transaction)
        self.spendingCategoryLabel.text = transaction.spendingCategory.map { $0.rawValue }
    }

    func sourceTransactionAbbreviation(transaction: STTransactionFeed) -> String {

        var abbrev = ""

        let sourceComponents = transaction.source.map { $0.rawValue }?.components(separatedBy: "_")

        sourceComponents?.forEach({ word in
            guard let firstChar = word.first else {
                return
            }
            abbrev.append(firstChar)
        })

        return abbrev
    }

    static func makeTransactionDetailsViewController(transaction: STTransactionFeed) -> TransactionDetailsViewController? {

        guard let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(
                withIdentifier: "TransactionDetailsViewController"
            ) as? TransactionDetailsViewController else {
                return nil
        }

        vc.transaction = transaction

        return vc
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
