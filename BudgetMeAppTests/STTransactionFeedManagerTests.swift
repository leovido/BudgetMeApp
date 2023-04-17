//
//  STTransactionFeedManagerTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Moya
import XCTest
@testable import BudgetMeApp

class STTransactionFeedManagerTests: XCTestCase {
  var sut: STTransactionFeedManager!

  override func setUp() {}

  override func tearDown() {
    sut = nil
  }

  func testBrowseTransactions() {
    let exp = expectation(description: "Fetch all accounts")

    sut = STTransactionFeedManager(accountId: "someAccountId",
                                   provider: makeMoyaSuccessStub(type: .browse))

    sut.browse { result in
      if case let .success(transactions) = result {
        XCTAssertEqual(transactions.count, 16)
        exp.fulfill()
      }
    }

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testGetWeeklyTransactions() {
    let exp = expectation(description: "Fetch weekly transactions from a given date")

    sut = STTransactionFeedManager(accountId: "someAccountId",
                                   provider: makeMoyaSuccessStub(type: .dateRange))

    sut.getWeeklyTransactions(startDate: "2020-03-20T11:19:25.581Z") { result in
      if case let .success(transactions) = result {
        XCTAssertEqual(transactions.count, 16)
        exp.fulfill()
      } else if case let .failure(error) = result {
        XCTFail(error.localizedDescription)
      }
    }

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testGetWeeklyTransactions_2() {
    let exp = expectation(description: "Fetch weekly transactions from a given date")

    sut = STTransactionFeedManager(accountId: "someAccountId",
                                   provider: makeMoyaSuccessStub(type: .dateRange))

    sut.getWeeklyTransactions(startDate: "2020-03-23T11:19:25.581Z") { result in
      if case let .success(transactions) = result {
        XCTAssertEqual(transactions.count, 16)
        exp.fulfill()
      } else if case let .failure(error) = result {
        XCTFail(error.localizedDescription)
      }
    }

    waitForExpectations(timeout: 5, handler: nil)
  }
}

extension STTransactionFeedManagerTests {
  private func makeMoyaSuccessStub<T: TargetType>(type: STAccountSuccessTestCases) -> MoyaProvider<T> {
    #if DEBUG
      let url = bundle.url(forResource: "transactions_success_" + type.rawValue, withExtension: "json")!
      let data = try! Data(contentsOf: url)

      let serverEndpointSuccess = { (target: T) -> Endpoint in
        Endpoint(url: URL(target: target).absoluteString,
                 sampleResponseClosure: { .networkResponse(200, data) },
                 method: target.method,
                 task: target.task,
                 httpHeaderFields: target.headers)
      }

      let serverStubSuccess = MoyaProvider<T>(
        endpointClosure: serverEndpointSuccess,
        stubClosure: MoyaProvider.immediatelyStub,
        plugins: [
          AuthPlugin(tokenClosure: { Session.shared.token }),
        ]
      )

      return serverStubSuccess

    #endif
  }

  private func makeMoyaFailureStub<T: TargetType>(type _: BookingFailureTestCases) -> MoyaProvider<T> {
    let serverEndpointFailure = { (target: T) -> Endpoint in
      Endpoint(url: URL(target: target).absoluteString,
               sampleResponseClosure: { .networkResponse(400, target.sampleData) },
               method: target.method,
               task: target.task,
               httpHeaderFields: target.headers)
    }

    let serverStubFailure = MoyaProvider<T>(
      endpointClosure: serverEndpointFailure,
      stubClosure: MoyaProvider.immediatelyStub,
      plugins: [
        AuthPlugin(tokenClosure: { "Some token" }),
      ]
    )

    return serverStubFailure
  }

  private var bundle: Bundle {
    Bundle(for: type(of: self) as! AnyClass)
  }

  private enum STAccountSuccessTestCases: String, TestableCase {
    case browse
    case dateRange
  }

  private enum BookingFailureTestCases: String, TestableCase {
    case browse
    case dateRange
  }
}
