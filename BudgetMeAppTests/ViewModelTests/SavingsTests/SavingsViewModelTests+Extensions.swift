//
//  SavingsViewModelTests+Extensions.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 02/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya
@testable import BudgetMeApp

protocol SavingsStubProtocol {}

internal enum STSavingsGoalsSuccessTestCases: String {
  case browse
}

extension SavingsStubProtocol {
  var bundle: Bundle {
    Bundle(for: type(of: self) as! AnyClass)
  }

  func makeMoyaSuccessStub<T: TargetType>(type: STSavingsGoalsSuccessTestCases) -> MoyaProvider<T> {
    #if DEBUG
      let url = bundle.url(forResource: "saving_success_" + type.rawValue, withExtension: "json")!
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
}
