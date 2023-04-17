//
//  SavingsViewModelTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 02/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest
@testable import BudgetMeApp

class SavingsViewModelTests: XCTestCase, SavingsStubProtocol {
  var savingsViewModel: SavingsViewModel!

  override func setUp() {}

  override func tearDown() {
    savingsViewModel = nil
  }

  func testRefreshData() {
    savingsViewModel = SavingsViewModel(provider: makeMoyaSuccessStub(type: .browse))

    savingsViewModel.refreshData()
  }

  func testCreateNewSaving() {
    savingsViewModel = SavingsViewModel(provider: makeMoyaSuccessStub(type: .browse))

    savingsViewModel.createNewSaving(name: "Some saving")
  }
}
