//
//  STAccountTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Moya
import XCTest
@testable import BudgetMeApp

class STAccountTests: XCTestCase {
  var sut: STAccountManager!

  override func setUp() {}

  override func tearDown() {
    sut = nil
  }

  func testBrowseAccounts() {
    let exp = expectation(description: "Fetch all accounts")

    sut = STAccountManager(provider: makeMoyaSuccessStub(type: .browse))

    sut.browse { result in
      if case let .success(accounts) = result {
        XCTAssertEqual(accounts.count, 1)
        exp.fulfill()
      }
    }

    waitForExpectations(timeout: 5, handler: nil)
  }
}

extension STAccountTests {
  private func makeMoyaSuccessStub<T: TargetType>(type: STAccountSuccessTestCases) -> MoyaProvider<T> {
    #if DEBUG
      let url = bundle.url(forResource: "account_success_" + type.rawValue, withExtension: "json")!
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

    #elseif STAGING
      return MoyaNetworkManagerFactory.makeManager()
    #endif
  }

  private func makeMoyaFailureStub<T: TargetType>(type _: STAccountFailureTestCases) -> MoyaProvider<T> {
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
}

protocol TestableCase {}

enum STAccountSuccessTestCases: String, TestableCase {
  case browse
  case downloadStatement
  case downloadStatementRange
  case identifiers
  case balance
  case availableFunds
  case statementPeriods
}

enum STAccountFailureTestCases: String, TestableCase {
  case browse
}
