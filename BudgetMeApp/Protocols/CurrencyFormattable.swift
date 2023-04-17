//
//  CurrencyFormattable.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

protocol CurrencyFormattable {}

extension CurrencyFormattable {
    func currencyFormatter(value: CurrencyAndAmount) -> String {
        let currency = Float(value.minorUnits) / 100

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = value.currency == .GBP ? "£" : "€"

        let formattedValue = formatter.string(from: NSNumber(value: currency)) ?? "£\(currency)"

        return formattedValue
    }

    func currencyFormatter(value: MinorUnits) -> String {
        let currency = Float(value) / 100

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "£"

        let formattedValue = formatter.string(from: NSNumber(value: currency)) ?? "£\(currency)"

        return formattedValue
    }
}
