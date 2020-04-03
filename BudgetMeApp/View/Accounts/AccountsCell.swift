//
//  AccountsCell.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit

class AccountsCell: UITableViewCell {

    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!

    @IBOutlet weak var accountIdLabel: UILabel!

    @IBOutlet weak var IBANLabel: UILabel!
    @IBOutlet weak var BICLabel: UILabel!

    static var identifier: String {
        return "AccountsCell"
    }

    func configure(value: AccountComposite) {
        accountLabel.text = "Account #\(1)"
        balanceLabel.text = value.balance.clearedBalance.description
        accountIdLabel.text = value.identifiers.accountIdentifier
        IBANLabel.text = value.identifiers.iban
        BICLabel.text = value.identifiers.bic
    }

}
