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

    static var identifier: String {
        return "AccountsCell"
    }

    func configure(value: STAccount, row: Int) {
        accountLabel.text = "Account #\(row)"
    }

}
