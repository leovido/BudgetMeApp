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
  @IBOutlet var savingNameLabel: UILabel!
  @IBOutlet var targetAmountLabel: UILabel!
  @IBOutlet var totalSavedLabel: UILabel!
  @IBOutlet var percentageLabel: UILabel!

  static var identifier: String {
    "SavingsCell"
  }

  func configureSavings(savings: STSavingsGoal) {
    savingNameLabel.text = savings.name
    targetAmountLabel.text = savings.target != nil ? currencyFormatter(value: savings.target!) : "n/a"
    totalSavedLabel.text = currencyFormatter(value: savings.totalSaved)
    percentageLabel.text = "\(savings.savedPercentage?.description ?? "0")%"
  }
}
