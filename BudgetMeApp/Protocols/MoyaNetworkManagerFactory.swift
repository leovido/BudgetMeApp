//
//  MoyaNetworkManagerFactory.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Moya

/// Factory used for mocking and unit testing
enum MoyaNetworkManagerFactory {
  static func makeManager<T>() -> MoyaProvider<T> {
    #if DEBUG
      return MoyaProvider<T>(plugins: [
        AuthPlugin(tokenClosure: { Session.shared.token }),
        NetworkLoggerPlugin(),
      ])
    #else
      return MoyaProvider<T>(plugins: [
        AuthPlugin(tokenClosure: { Session.shared.token }),
      ])
    #endif
  }
}
