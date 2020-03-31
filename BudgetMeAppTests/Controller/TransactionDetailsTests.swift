//
//  TransactionDetailsTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest
import SwiftCheck
@testable import BudgetMeApp

class TransactionDetailsTests: XCTestCase {

    var viewController: TransactionDetailsViewController!

    override func setUp() {

        let transaction = STTransactionFeed.arbitrary.generate

        viewController = TransactionDetailsViewController
            .makeTransactionDetailsViewController(transaction: transaction)

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
