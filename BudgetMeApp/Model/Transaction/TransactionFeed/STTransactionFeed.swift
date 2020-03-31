//
//  STTransactionFeed.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

struct STTransactionFeed: Decodable, Equatable {
    let feedItemUid: String?
    let categoryUid: String?
    let amount: CurrencyAndAmount?
    let sourceAmount: CurrencyAndAmount?
    let direction: Direction?
    let updatedAt: DateTime?
    let transactionTime: DateTime?
    let settlementTime: DateTime?
    let retryAllocationUntilTime: DateTime?
    let source: Source?
    let sourceSubType: SourceSubType?
    let status: Status?
    let counterPartyType: CountryPartyType?
    let counterPartyUid: String?
    let counterPartyName: String?
    let counterPartySubEntityUid: String?
    let counterPartySubEntityName: String?
    let counterPartySubEntityIdentifier: String?
    let counterPartySubEntitySubIdentifier: String?
    let exchangeRate: Int?
    let totalFees: Int?
    let reference: String?
    let country: Country?
    let spendingCategory: SpendingCategory?
    let userNote: String?
    let roundUp: RoundUp?
}

enum Direction: String, Decodable, CaseIterable {
    case IN
    case OUT
}

enum Status: String, Decodable, CaseIterable {
    case UPCOMING, PENDING, REVERSED, SETTLED, DECLINED, REFUNDED, RETRYING, ACCOUNT_CHECK
}

enum SpendingCategory: String, Decodable, CaseIterable {
    case BILLS_AND_SERVICES, CHARITY, EATING_OUT, ENTERTAINMENT, EXPENSES, FAMILY, GENERAL, GIFTS, GROCERIES, HOME, INCOME, SAVING, SHOPPING, HOLIDAYS, PAYMENTS, PETS, TRANSPORT, LIFESTYLE, NONE, REVENUE, OTHER_INCOME, CLIENT_REFUNDS, INVENTORY, STAFF, TRAVEL, WORKPLACE, REPAIRS_AND_MAINTENANCE, ADMIN, MARKETING, BUSINESS_ENTERTAINMENT, INTEREST_PAYMENTS, BANK_CHARGES, OTHER, FOOD_AND_DRINK, EQUIPMENT, PROFESSIONAL_SERVICES, PHONE_AND_INTERNET, VEHICLES, DIRECTORS_WAGES, VAT, CORPORATION_TAX, SELF_ASSESSMENT_TAX, INVESTMENT_CAPITAL, TRANSFERS, LOAN_PRINCIPAL, PERSONAL, DIVIDENDS
}


