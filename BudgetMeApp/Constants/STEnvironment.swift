//
//  STEnvironment.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

/// Environment to be used for testing/debugging and production
enum STEnvironment {
    #if DEBUG
    static let environment = STEnvironment.sandbox
    #else
    static let environment = STEnvironment.production
    #endif

    static let sandbox = URL(string: "https://api-sandbox.starlingbank.com/api/v2")!
    static let production = URL(string: "https://api.starlingbank.com/api/v2")!
}

enum Constants {
    static let auth = URL(string: "https://api-sandbox.starlingbank.com/oauth/access-token")!
}
