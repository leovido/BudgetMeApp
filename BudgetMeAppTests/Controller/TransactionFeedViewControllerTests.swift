//
//  TransactionFeedViewControllerTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest

@testable import BudgetMeApp

class TransactionFeedViewControllerTests: XCTestCase {
    var viewController: TransactionFeedViewController!

    override func setUp() {
        viewController = sutNavigationSetup()
    }

    override func tearDown() {
        viewController = nil
    }

    func testLifecycle() {
        viewController.viewWillAppear(true)
        viewController.viewDidLoad()
        viewController.viewDidAppear(true)
        viewController.viewWillDisappear(true)
    }

    func sutNavigationSetup<T>() -> T {
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionFeedViewController") as? TransactionFeedViewController

        let navigationController = UINavigationController()

        UIApplication.shared.windows.first!.rootViewController = navigationController
        navigationController.pushViewController(viewController, animated: false)

        viewController = navigationController.topViewController as? TransactionFeedViewController
        viewController.loadView()

        return viewController as! T
    }
}
