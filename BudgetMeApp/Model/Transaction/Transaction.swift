//
//  Transaction.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

protocol TransactionBlueprint {
    var reference: String { get }
    var transactionDate: String { get }
    var direction: Direction { get }
    var sourceAmount: CurrencyAndAmount { get }
}

struct Transaction: Decodable, TransactionBlueprint, Equatable {
    var reference: String
    var transactionDate: String
    var direction: Direction
    var sourceAmount: CurrencyAndAmount

    init(tx: STTransactionFeed) {
        self.reference = tx.reference ?? "Reference"
        self.transactionDate = tx.transactionTime!
        self.direction = tx.direction!
        self.sourceAmount = tx.sourceAmount!
    }
}
