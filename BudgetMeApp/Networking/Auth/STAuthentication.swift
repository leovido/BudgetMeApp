//
//  STAuthentication.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya

typealias RefreshToken = String

enum STAuthentication {
    case authenticate(refreshToken: RefreshToken, clientId: String, clientSecret: String)
}

extension STAuthentication: TargetType {

    public var baseURL: URL {
        return Constants.auth
    }

    public var path: String {
        switch self {
        case .authenticate:
            return ""
        }
    }

    public var method: Moya.Method {
        return .post
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .authenticate(let refreshToken, let clientId, let clientSecret):
            return .requestParameters(parameters: ["refreshToken": refreshToken,
                                                   "client_id": clientId,
                                                   "client_secret": clientSecret,
                                                   "granty_type": "refresh_token"],
                                      encoding: JSONEncoding.default)
        }
    }

    public var headers: [String: String]? {
        switch self {
        default:
            return ["Accept": "application/x-www-form-urlencoded"]
        }

    }

    public var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
