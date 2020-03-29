//
//  TransactionDetailsTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest
@testable import BudgetMeApp

class TransactionDetailsTests: XCTestCase {

    var viewController: TransactionDetailsViewController!

    override func setUp() {

        let transaction = STTransactionFeed(feedItemUid: nil, categoryUid: nil, amount: nil, sourceAmount: nil, direction: nil, updatedAt: nil, transactionTime: nil, settlementTime: nil, retryAllocationUntilTime: nil, source: nil, sourceSubType: nil, status: nil, counterPartyType: nil, counterPartyUid: nil, counterPartyName: nil, counterPartySubEntityUid: nil, counterPartySubEntityName: nil, counterPartySubEntityIdentifier: nil, counterPartySubEntitySubIdentifier: nil, exchangeRate: nil, totalFees: nil, reference: "Test", country: nil, spendingCategory: nil, userNote: nil, roundUp: nil)

        viewController = TransactionDetailsViewController.makeTransactionDetailsViewController(transaction: transaction)


    }

    override func tearDown() {
        viewController = nil
    }

    func testLifeCycle() {
//        viewController.viewWillAppear(true)
//        viewController.viewDidLoad()
//        viewController.viewDidAppear(true)
//        viewController.viewWillAppear(true)
    }

}
