//
//  Roundable.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

/// Protocol to calculate the amount that can be saved up by rounding up
/// Currency symbol can be updated depending on the STCurrency.
/// Looking at the docs seems like the only values for STTransactionFeed are GBP and EUR. But for Accounts, STCurrency is used.
protocol Roundable {
    associatedtype NewElement: Hashable
}

extension Roundable {

    func roundUp(value: MinorUnits) -> MinorUnits {

        let cents = value % 100

        if cents > 0 {
            let saving = 100 - cents

            return saving
        } else {
            return cents
        }

    }

    func convertToCurrency(value: MinorUnits) -> Currency {

        let amount: Float = Float(value) / 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "£"
        formatter.maximumFractionDigits = 2
        let formattedAmount = formatter.string(from: amount as NSNumber)!

        return formattedAmount
    }

}
