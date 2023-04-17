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
    @IBOutlet var referenceLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!

    @IBOutlet var spendingCategoryImage: UIImageView!

    override func awakeFromNib() {
        referenceLabel.isOpaque = true
        referenceLabel.backgroundColor = .white

        dateLabel.isOpaque = true
        dateLabel.backgroundColor = .white

        priceLabel.isOpaque = true
        priceLabel.backgroundColor = .white

        spendingCategoryImage.isOpaque = true
        spendingCategoryImage.backgroundColor = .white
        spendingCategoryImage.layer.backgroundColor = UIColor.white.cgColor

        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    static var identifier: String {
        return "TransactionCell"
    }

    func positiveAmountDisplay(transaction: STTransactionFeed) {
        priceLabel.text = "+" + transaction.sourceAmount!.description
        priceLabel.textColor = UIColor.systemGreen
    }

    func negativeAmountDisplay(transaction: STTransactionFeed) {
        priceLabel.text = "-" + transaction.sourceAmount!.description
        priceLabel.textColor = UIColor.systemRed
    }

    func configure(transaction: STTransactionFeed) {
        referenceLabel.text = transaction.reference
        dateLabel.text = Date.dateFormatter(dateString: transaction.transactionTime!)

        transaction.direction == .IN ? positiveAmountDisplay(transaction: transaction) : negativeAmountDisplay(transaction: transaction)

        let imageName = SpendingCategoryFactory.makeSpendingCategory(spendingCategory: transaction.spendingCategory!)
            .categoryImage

        spendingCategoryImage.image = UIImage(named: imageName)
    }

    override func setSelected(_ selected: Bool, animated _: Bool) {
        if selected {
            let color = #colorLiteral(red: 0.4549019608, green: 0.2, blue: 1, alpha: 1)

            backgroundColor = color

            referenceLabel.backgroundColor = color

            dateLabel.backgroundColor = color

            priceLabel.backgroundColor = color
            spendingCategoryImage.backgroundColor = color
            spendingCategoryImage.layer.backgroundColor = color.cgColor

        } else {
            backgroundColor = .white

            referenceLabel.backgroundColor = .white
            dateLabel.backgroundColor = .white
            priceLabel.backgroundColor = .white

            spendingCategoryImage.backgroundColor = .white
            spendingCategoryImage.layer.backgroundColor = UIColor.white.cgColor
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
