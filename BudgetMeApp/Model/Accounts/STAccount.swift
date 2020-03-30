//
//  STAccount.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

typealias DateTime = String

struct STAccount: Decodable, Equatable {
    let accountUid: String
    let defaultCategory: String
    let currency: STCurrency
    let createdAt: DateTime
}

struct STBalance: Decodable, Equatable {
    let clearedBalance: CurrencyAndAmount
    let effectiveBalance: CurrencyAndAmount
    let pendingTransactions: CurrencyAndAmount
    let acceptedOverdraft: CurrencyAndAmount
    let amount: CurrencyAndAmount
}

struct STAccountIdentifiers: Decodable, Equatable {
    let accountIdentifier: String
    let bankIdentifier: String
    let iban: String
    let bic: String
    let accountIdentifiers: [STAccountIdentifier]
}

enum STIdentifierType: String, Codable {
    case SORT_CODE
    case IBAN_BIC
    case ABA_ACH
}

struct STAccountIdentifier: Decodable, Equatable {
    let identifierType: STIdentifierType
    let bankIdentifier: String
    let accountIdentifier: String
}

struct ConfirmationOfFundsResponse: Decodable, Equatable {
    var requestedAmountAvailableToSpend: Bool
    var accountWouldBeInOverdraftIfRequestedAmountSpent: Bool
}

struct AccountStatementPeriods: Decodable, Equatable {
    var period: String
    var partial: Bool
    var endsAt: DateTime
}
