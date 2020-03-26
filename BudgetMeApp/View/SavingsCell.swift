//
//  SavingsCell.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit

extension SavingsCell: CurrencyFormattable {}

final class SavingsCell: UITableViewCell {

    @IBOutlet weak var savingNameLabel: UILabel!
    @IBOutlet weak var targetAmountLabel: UILabel!
    @IBOutlet weak var totalSavedLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!

    static var identifier: String {
        return "SavingsCell"
    }

    func configureSavings(savings: STSavingsGoal) {
        savingNameLabel.text = savings.name
        targetAmountLabel.text = savings.target != nil ? currencyFormatter(value: savings.target!) : "n/a"
        totalSavedLabel.text = currencyFormatter(value: savings.totalSaved)
        percentageLabel.text = "\(savings.savedPercentage?.description ?? "0")%"
    }

}
