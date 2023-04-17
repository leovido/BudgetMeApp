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
    case refreshToken(refreshToken: RefreshToken, clientId: String, clientSecret: String)
    case authenticate(clientId: String, redirectURI: String)
}

extension STAuthentication: TargetType {
    public var baseURL: URL {
        return Constants.auth
    }

    public var path: String {
        switch self {
        case .refreshToken, .authenticate:
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
        case let .refreshToken(refreshToken, clientId, clientSecret):
            return .requestParameters(parameters: ["grant_type": "refresh_token",
                                                   "refresh_token": refreshToken,
                                                   "client_id": clientId,
                                                   "client_secret": clientSecret],
                                      encoding: URLEncoding.httpBody)
        case let .authenticate(clientId, redirectURI):
            return .requestParameters(parameters: ["clientId": clientId,
                                                   "responsetType": "code",
                                                   "state": UUID().uuidString,
                                                   "redirectURI": redirectURI],
                                      encoding: JSONEncoding.default)
        }
    }

    public var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "User-agent": "Christian Ray Leovido"]
        }
    }

    public var validationType: ValidationType {
        return .none
    }
}
