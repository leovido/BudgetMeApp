//
//  STAccountService.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya

enum STAccountService {
    case browseAccounts
    case getIdentifiers(accountId: String)
    case getBalance(accountId: String)
    case getConfirmationOfFunds(accountId: String)
    case getAvailableStatementPeriods(accountId: String)
    case downloadStatement(accountId: String)
    case downloadStatementForDateRange(accountId: String, start: DateTime, end: DateTime)
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
        case .getConfirmationOfFunds(let accountId):
            return "/accounts/\(accountId)/confirmation-of-funds"
        case .getAvailableStatementPeriods(let accountId):
            return "/accounts/\(accountId)/available-periods"
        case .downloadStatement(let accountId):
            return "/accounts/\(accountId)/statement/download"
        case .downloadStatementForDateRange(let accountId):
            return "/accounts/\(accountId)/statement/downloadForDateRange"
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
        switch self {
        case .downloadStatement, .downloadStatementForDateRange:
            return ["Accept": "application/pdf",
                    "User-agent": "Christian Ray Leovido"]
        default:
            return ["Accept": "application/json",
                    "User-agent": "Christian Ray Leovido"]
        }

    }

    public var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
