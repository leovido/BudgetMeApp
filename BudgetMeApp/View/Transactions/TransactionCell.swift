//
//  TransactionCell.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit

extension TransactionCell: CurrencyFormattable {}

final class TransactionCell: UITableViewCell {

    @IBOutlet weak var referenceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    static var identifier: String {
        return "TransactionCell"
    }

    func configure(value: STTransactionFeed) {
        referenceLabel.text = value.reference
        dateLabel.text = value.transactionTime

        if value.direction == .IN {
            priceLabel.text = "+\(currencyFormatter(value: value.sourceAmount!))"
            priceLabel.textColor = UIColor.green
        } else {
            priceLabel.text = "-\(currencyFormatter(value: value.sourceAmount!))"
            priceLabel.textColor = UIColor.red
        }

    }

}

extension Date {
    static func dateFormatter(dateString: DateTime) -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        guard let newDate = dateFormatter.date(from: dateString) else { return nil }

        dateFormatter.dateFormat = "dd-MM-yyyy"
        let endDateString = dateFormatter.string(from: newDate)

        return endDateString
    }

    static func dateFormatterTime(dateString: DateTime) -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        guard let newDate = dateFormatter.date(from: dateString) else { return nil }

        dateFormatter.dateFormat = "HH:mm"
        let endDateString = dateFormatter.string(from: newDate)

        return endDateString
    }
}
