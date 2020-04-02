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

    @IBOutlet weak var spendingCategoryImage: UIImageView!

    static var identifier: String {
        return "TransactionCell"
    }

    func configure(transaction: STTransactionFeed) {
        referenceLabel.text = transaction.reference
        dateLabel.text = Date.dateFormatter(dateString: transaction.transactionTime!)

        if transaction.direction == .IN {
            priceLabel.text = "+" + transaction.sourceAmount!.description
            priceLabel.textColor = UIColor.systemGreen
        } else {
            priceLabel.text = "-" + transaction.sourceAmount!.description
            priceLabel.textColor = UIColor.red
        }

        if #available(iOS 13.0, *) {
            switch transaction.spendingCategory {
            case .OTHER:
                self.spendingCategoryImage.image = UIImage(systemName: "pencil.and.ellipsis.rectangle")!
            case .REVENUE:
                self.spendingCategoryImage.image = UIImage(systemName: "sterlingsign.circle.fill")!
            case .TRAVEL:
                self.spendingCategoryImage.image = UIImage(systemName: "airplane")!
            default:
                self.spendingCategoryImage.image = UIImage(systemName: "bag")!
            }
        } else {
            // Fallback on earlier versions
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.backgroundColor = #colorLiteral(red: 0.4549019608, green: 0.2, blue: 1, alpha: 1)
        } else {
            self.backgroundColor = .white
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
