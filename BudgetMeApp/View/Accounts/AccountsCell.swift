//
//  AccountsCell.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit

class AccountsCell: UITableViewCell {
  @IBOutlet var accountLabel: UILabel!
  @IBOutlet var balanceLabel: UILabel!

  @IBOutlet var accountIdLabel: UILabel!

  @IBOutlet var IBANLabel: UILabel!
  @IBOutlet var BICLabel: UILabel!

  static var identifier: String {
    "AccountsCell"
  }

  func configure(value: AccountComposite) {
    accountLabel.text = "Account #\(1)"
    balanceLabel.text = value.balance.clearedBalance.description
    accountIdLabel.text = value.identifiers.accountIdentifier
    IBANLabel.text = value.identifiers.iban
    BICLabel.text = value.identifiers.bic
  }
}
