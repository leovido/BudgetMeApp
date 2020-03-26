//
//  STTransactionFeedService.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya

enum STTransactionFeedService {
    case browseTransactions(accountId: String, categoryId: String, changesSince: DateTime)
    case getTransactions(accountId: String, categoryId: String, startDate: DateTime, endDate: DateTime)
    case getWeeklyTransactions(accountId: String, categoryId: String, startDate: DateTime, endDate: DateTime)
}

extension STTransactionFeedService: AuthorizedTargetType {
    var needsAuth: Bool {
        return true
    }
}

extension STTransactionFeedService: TargetType {

    public var baseURL: URL {
        return STEnvironment.environment
    }

    public var path: String {
        switch self {
        case .browseTransactions(let accountId, let categoryId, _):
            return "/feed/account/\(accountId)/category/\(categoryId)"
        case .getTransactions(let accountId, let categoryId, _, _),
             .getWeeklyTransactions(let accountId, let categoryId, _, _):
            return "/feed/account/\(accountId)/category/\(categoryId)/transactions-between"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .browseTransactions(_, _, let changesSince):

            return .requestParameters(parameters: ["changesSince": changesSince],
                                      encoding: URLEncoding.default)

        case .getTransactions(_, _, let startDate, let endDate),
             .getWeeklyTransactions(_, _, let startDate, let endDate):

            return .requestParameters(parameters: ["minTransactionTimestamp": startDate,
                                                   "maxTransactionTimestamp": endDate],
                                      encoding: URLEncoding.default)
        }
    }

    public var headers: [String: String]? {
        return ["Accept": "application/json",
                "User-agent": "Christian Ray Leovido"]
    }

    public var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
