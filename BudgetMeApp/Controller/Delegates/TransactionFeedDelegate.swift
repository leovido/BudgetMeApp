//
//  TransactionFeedDelegate.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import UIKit

extension TransactionFeedViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if dataSource[section].items.isEmpty {
            return 0
        } else {
            return 40
        }
    }

    func tableView(_: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header: UITableViewHeaderFooterView = view as? UITableViewHeaderFooterView else {
            return
        }

        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont(name: "Futura", size: 21)
        header.textLabel?.textAlignment = .left
        header.backgroundColor = .clear
        header.backgroundView?.backgroundColor = .red
        header.contentView.backgroundColor = .clear

        let headerTitle = dataSource[section].header

        header.textLabel?.text = headerTitle
    }
}
