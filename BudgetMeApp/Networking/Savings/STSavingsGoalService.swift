//
//  STSavingsGoalService.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya

public enum STSavingsGoalService {
    case browseSavings
    case getSaving(savingsGoalId: String)
    case createSaving(name: String)
    case addMoney(amount: MinorUnits, savingsGoalId: String)
}

extension STSavingsGoalService: AuthorizedTargetType {
    var needsAuth: Bool {
        return true
    }
}

extension STSavingsGoalService: TargetType {

    public var baseURL: URL {
        return STEnvironment.environment
    }

    public var path: String {
        switch self {
        case .browseSavings,
             .createSaving:
            return "/account/\(Session.shared.accountId)/savings-goals"
        case .getSaving(let savingsGoalId):
            return "/account/\(Session.shared.accountId)/savings-goals/\(savingsGoalId)"
        case .addMoney(_, let savingsGoalId):
            return "/account/\(Session.shared.accountId)/savings-goals/\(savingsGoalId)/add-money/\(UUID().uuidString)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .browseSavings,
             .getSaving:
            return .get
        case .createSaving,
             .addMoney:
            return .put
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .browseSavings,
             .getSaving:
            return .requestPlain
        case .createSaving(let name):
            return .requestParameters(parameters: ["name": name, "currency": "GBP"],
                                      encoding: JSONEncoding.default)
        case .addMoney(let amount, _):
            return .requestParameters(parameters: ["amount": ["currency": "GBP",
                                                              "minorUnits": amount]],
                                      encoding: JSONEncoding.default)
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
