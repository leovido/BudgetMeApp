//
//  Session.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

final class Session {
  private init() {}

  private static var _shared = Session()

  static var shared: Session {
    _shared
  }

  var accountId: String = ""

  var token: String {
    UserDefaultsConfig.token
  }

  var refreshToken: String {
    UserDefaultsConfig.refreshToken
  }
}
