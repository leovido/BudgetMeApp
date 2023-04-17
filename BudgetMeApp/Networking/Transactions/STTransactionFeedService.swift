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
    true
  }
}

extension STTransactionFeedService: TargetType {
  public var baseURL: URL {
    STEnvironment.environment
  }

  public var path: String {
    switch self {
    case let .browseTransactions(accountId, categoryId, _):
      return "/feed/account/\(accountId)/category/\(categoryId)"
    case let .getTransactions(accountId, categoryId, _, _),
         let .getWeeklyTransactions(accountId, categoryId, _, _):
      return "/feed/account/\(accountId)/category/\(categoryId)/transactions-between"
    }
  }

  public var method: Moya.Method {
    .get
  }

  public var sampleData: Data {
    Data()
  }

  public var task: Task {
    switch self {
    case let .browseTransactions(_, _, changesSince):

      return .requestParameters(parameters: ["changesSince": changesSince],
                                encoding: URLEncoding.default)

    case let .getTransactions(_, _, startDate, endDate),
         let .getWeeklyTransactions(_, _, startDate, endDate):

      return .requestParameters(parameters: ["minTransactionTimestamp": startDate,
                                             "maxTransactionTimestamp": endDate],
                                encoding: URLEncoding.default)
    }
  }

  public var headers: [String: String]? {
    ["Accept": "application/json",
     "User-agent": "Christian Ray Leovido"]
  }

  public var validationType: ValidationType {
    .successAndRedirectCodes
  }
}
