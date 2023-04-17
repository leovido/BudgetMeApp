//
//  AccountsViewControllerTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest
@testable import BudgetMeApp

class AccountsViewControllerTests: XCTestCase, StubAccounts {
  var viewController: AccountsViewController!

  override func setUp() {
    viewController = sutNavigationSetup()
    viewController.viewModel = AccountsViewModel(provider: makeMoyaSuccessStub(type: .browse))
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

  func testPresentDownloadAlert() {
    let expectation = XCTestExpectation(description: "show download alert")

    viewController.presentDownloadAlert()

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      XCTAssertTrue(UIApplication.shared.windows.first!.rootViewController?.presentedViewController is UIAlertController)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.5)
  }

  func testShowSuccessAlert() {
    let expectation = XCTestExpectation(description: "show success alert")

    viewController.showSuccessAlert()

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      XCTAssertTrue(UIApplication.shared.windows.first!.rootViewController?.presentedViewController is UIAlertController)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 1.5)
  }

  func testButtonDownload() {
    viewController.downloadStatementButton.sendActions(for: .touchUpInside)
  }

  func testDownloadPDF() {
    viewController.performDownloadPDF(yearMonth: "2020-03")
  }

  func testDownloadCSV() {
    viewController.performDownloadCSV(yearMonth: "2020-03")
  }

  func sutNavigationSetup<T>() -> T {
    viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountsViewController") as? AccountsViewController

    let navigationController = UINavigationController()

    UIApplication.shared.windows.first!.rootViewController = navigationController
    navigationController.pushViewController(viewController, animated: false)

    viewController = navigationController.topViewController as? AccountsViewController
    viewController.loadView()

    return viewController as! T
  }
}
