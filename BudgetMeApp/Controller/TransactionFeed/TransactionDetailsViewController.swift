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

    @IBOutlet var referenceLabel: UILabel!

    @IBOutlet var transactionTimeLabel: UILabel!
    @IBOutlet var transactionDateLabel: UILabel!
    @IBOutlet var counterPartyName: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var transactionSourceLabel: UILabel!
    @IBOutlet var spendingCategoryLabel: UILabel!
    @IBOutlet var transactionSubSourceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    func configureView() {
        referenceLabel.text = transaction.reference ?? "Default reference"
        transactionTimeLabel.text = Date.dateFormatterTime(dateString: transaction.settlementTime ?? "")
        transactionDateLabel.text = Date.dateFormatter(dateString: transaction.settlementTime ?? "")

        transactionSubSourceLabel.text = transaction.sourceSubType.map { $0.rawValue }
        counterPartyName.text = transaction.counterPartyName

        if transaction.direction == .IN {
            amountLabel.textColor = UIColor.systemGreen
            amountLabel.text = "+" + transaction.amount!.description
        } else {
            amountLabel.textColor = UIColor.systemPink
            amountLabel.text = "-" + transaction.amount!.description
        }

        transactionSourceLabel.text = sourceTransactionAbbreviation(transaction: transaction)
        spendingCategoryLabel.text = transaction.spendingCategory.map { $0.rawValue }
    }

    func sourceTransactionAbbreviation(transaction: STTransactionFeed) -> String {
        var abbrev = ""

        let sourceComponents = transaction.source.map { $0.rawValue }?.components(separatedBy: "_")

        sourceComponents?.forEach { word in
            guard let firstChar = word.first else {
                return
            }
            abbrev.append(firstChar)
        }

        return abbrev
    }

    static func makeTransactionDetailsViewController(transaction: STTransactionFeed) -> TransactionDetailsViewController? {
        guard let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(
                withIdentifier: "TransactionDetailsViewController"
            ) as? TransactionDetailsViewController
        else {
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
