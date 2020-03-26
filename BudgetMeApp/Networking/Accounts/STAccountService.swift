//
//  STAccountService.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya


public enum STAccountService {
    case browseAccounts
    case getIdentifiers(accountId: String)
    case getBalance(accountId: String)
}

extension STAccountService: AuthorizedTargetType {
    var needsAuth: Bool {
        return true
    }
}

extension STAccountService: TargetType {

    public var baseURL: URL {
        return STEnvironment.environment
    }

    public var path: String {
        switch self {
        case .browseAccounts:
            return "/accounts"
        case .getIdentifiers(let accountId):
            return "/accounts/\(accountId)/identifiers"
        case .getBalance(let accountId):
            return "/accounts/\(accountId)/balance"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        return .requestPlain
    }

    public var headers: [String: String]? {
        return ["Accept": "application/json",
                "User-agent": "Christian Ray Leovido"]
    }

    public var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
