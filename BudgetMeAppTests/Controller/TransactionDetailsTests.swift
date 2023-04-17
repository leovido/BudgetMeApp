//
//  TransactionDetailsTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

@testable import BudgetMeApp
import SwiftCheck
import XCTest

class TransactionDetailsTests: XCTestCase {
    var viewController: TransactionDetailsViewController!

    override func setUp() {
        let transaction = STTransactionFeed.arbitrary.generate

        viewController = sutNavigationSetup()
        viewController.transaction = transaction
    }

    override func tearDown() {
        viewController = nil
    }

    func testLifeCycle() {
        viewController.viewWillAppear(true)
        viewController.viewDidLoad()
        viewController.viewDidAppear(true)
        viewController.viewWillAppear(true)
    }

    func testTransactionIn() {
        let transaction = STTransactionFeed.arbitraryInDirection.generate
        viewController.transaction = transaction
        viewController.configureView()

        XCTAssertEqual(viewController.amountLabel.textColor, UIColor.systemGreen)
    }

    func testTransactionOut() {
        let transaction = STTransactionFeed.arbitraryOUTDirection.generate
        viewController.transaction = transaction
        viewController.configureView()

        XCTAssertEqual(viewController.amountLabel.textColor, UIColor.systemPink)
    }

    func testSourceTransactionAbbreviation() {
        let transaction = STTransactionFeed.arbitraryWithSources.generate
        let abbrev = viewController.sourceTransactionAbbreviation(transaction: transaction)

        XCTAssert(!abbrev.isEmpty)
    }

    func testMakeViewController() {
        let transaction = STTransactionFeed.arbitrary.generate

        _ = TransactionDetailsViewController.makeTransactionDetailsViewController(transaction: transaction)
    }

    func sutNavigationSetup<T>() -> T {
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionDetailsViewController") as? TransactionDetailsViewController

        let navigationController = UINavigationController()

        UIApplication.shared.windows.first!.rootViewController = navigationController
        navigationController.pushViewController(viewController, animated: false)

        viewController = navigationController.topViewController as? TransactionDetailsViewController
        viewController.loadView()

        return viewController as! T
    }
}
