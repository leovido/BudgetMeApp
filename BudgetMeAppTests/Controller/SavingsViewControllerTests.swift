//
//  SavingsViewControllerTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest
@testable import BudgetMeApp

class SavingsViewControllerTests: XCTestCase {

    var viewController: SavingsViewController!

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

    func sutNavigationSetup<T>() -> T {

        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SavingsViewController") as? SavingsViewController

        let navigationController = UINavigationController()

        UIApplication.shared.keyWindow!.rootViewController = navigationController
        navigationController.pushViewController(viewController, animated: false)

        viewController = navigationController.topViewController as? SavingsViewController
        viewController.loadView()

        return viewController as! T
    }

}
