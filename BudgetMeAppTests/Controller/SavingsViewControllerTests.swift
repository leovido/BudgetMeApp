//
//  SavingsViewControllerTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest
@testable import BudgetMeApp

class SavingsViewControllerTests: XCTestCase, SavingsStubProtocol {

    var viewController: SavingsViewController!

    override func setUp() {
        viewController = sutNavigationSetup()
        viewController.viewModel = SavingsViewModel(provider: makeMoyaSuccessStub(type: .browse))
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

    func testAlert() {

        let expectation = XCTestExpectation(description: "show alert")

        viewController.presentAlert()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {

            let alert = UIApplication.shared.windows.first!.rootViewController?.presentedViewController as! UIAlertController

            let actionTitles = alert.actions.compactMap({ $0.title })

            XCTAssert(alert.title == "Saving goal name")

            XCTAssert(actionTitles[0] == "Yes")
            XCTAssert(actionTitles[1] == "Cancel")

            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.5)

    }

    func sutNavigationSetup<T>() -> T {

        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SavingsViewController") as? SavingsViewController

        let navigationController = UINavigationController()

        UIApplication.shared.windows.first!.rootViewController = navigationController
        navigationController.pushViewController(viewController, animated: false)

        viewController = navigationController.topViewController as? SavingsViewController
        viewController.loadView()

        return viewController as! T
    }

}
