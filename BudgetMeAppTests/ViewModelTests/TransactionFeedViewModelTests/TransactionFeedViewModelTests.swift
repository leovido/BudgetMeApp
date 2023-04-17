//
//  TransactionFeedViewModelTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 27/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import RxCocoa
import RxSwift
import RxTest
import XCTest
@testable import BudgetMeApp

class TransactionFeedViewModelTests: XCTestCase {
  var txsViewModel: TransactionsViewModel!

  var disposeBag: DisposeBag!
  var scheduler: TestScheduler!

  override func setUp() {
    disposeBag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
  }

  override func tearDown() {
    txsViewModel = nil
  }

  func testDataSource() {
    txsViewModel = TransactionsViewModel(provider: makeMoyaSuccessStub(type: .browse), accountId: "")

    let dataSourceMock = scheduler.createObserver([TransactionSectionData].self)
    txsViewModel.dataSource
      .bind(to: dataSourceMock)
      .disposed(by: disposeBag)

    let txs = [TransactionSectionData(header: "Income", items: [])]

    scheduler.createColdObservable([.next(15, txs)])
      .bind(to: txsViewModel.dataSource)
      .disposed(by: disposeBag)

    scheduler.start()

    XCTAssertEqual(dataSourceMock.events, [.next(0, []),
                                           .next(15, txs)])
  }

  func testRefreshData() {
    txsViewModel = TransactionsViewModel(provider: makeMoyaSuccessStub(type: .browse), accountId: "")
    txsViewModel.refreshData()
  }

  func testUpdateDateSource() {
    txsViewModel = TransactionsViewModel(provider: makeMoyaSuccessStub(type: .browse), accountId: "")
    txsViewModel.updateDateRange(dateTime: Date().toStringDateFormat())
  }

  func testRefreshDataRange() {
    txsViewModel = TransactionsViewModel(provider: makeMoyaSuccessStub(type: .dateRange), accountId: "")
    txsViewModel.refreshData(with: Date().toStringDateFormat())
  }

  func testCurrency() {
    let currency = CurrencyAndAmount.arbitrary.generate.description

    XCTAssert(!currency.isEmpty)
  }
}
