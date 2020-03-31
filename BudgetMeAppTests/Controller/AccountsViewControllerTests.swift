//
//  AccountsViewControllerTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest
@testable import BudgetMeApp

class AccountsViewControllerTests: XCTestCase {

    var viewController: AccountsViewController!

    override func setUp() {
        viewController = sutNavigationSetup()
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

    func testButtonDownload() {
        viewController.downloadStatementButton.sendActions(for: .touchUpInside)
    }

    func sutNavigationSetup<T>() -> T {

        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountsViewController") as? AccountsViewController

        let navigationController = UINavigationController()

        UIApplication.shared.keyWindow!.rootViewController = navigationController
        navigationController.pushViewController(viewController, animated: false)

        viewController = navigationController.topViewController as? AccountsViewController
        viewController.loadView()

        return viewController as! T
    }

}
