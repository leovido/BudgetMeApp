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
    case downloadStatementPDF(accountId: String, yearMonth: String)
    case downloadStatementCSV(accountId: String, yearMonth: String)
    case downloadStatementPDFForDateRange(accountId: String, start: DateTime, end: DateTime)
    case downloadStatementCSVForDateRange(accountId: String, start: DateTime, end: DateTime)
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
        case let .getIdentifiers(accountId):
            return "/accounts/\(accountId)/identifiers"
        case let .getBalance(accountId):
            return "/accounts/\(accountId)/balance"
        case let .getConfirmationOfFunds(accountId):
            return "/accounts/\(accountId)/confirmation-of-funds"
        case let .getAvailableStatementPeriods(accountId):
            return "/accounts/\(accountId)/available-periods"
        case let .downloadStatementPDF(accountId, _),
             let .downloadStatementCSV(accountId, _):
            return "/accounts/\(accountId)/statement/download"
        case let .downloadStatementPDFForDateRange(accountId),
             let .downloadStatementCSVForDateRange(accountId):
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
        switch self {
        case let .downloadStatementPDF(_, yearMonth),
             let .downloadStatementCSV(_, yearMonth):

            return .downloadParameters(parameters: ["yearMonth": yearMonth],
                                       encoding: URLEncoding.default,
                                       destination: DefaultDownloadDestination)

        case let .downloadStatementPDFForDateRange(_, start, end),
             let .downloadStatementCSVForDateRange(_, start, end):

            return .downloadParameters(parameters: ["start": start, "end": end],
                                       encoding: URLEncoding.default,
                                       destination: DefaultDownloadDestination)

        default:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .downloadStatementPDF, .downloadStatementPDFForDateRange:
            return ["Accept": "application/pdf",
                    "User-agent": "Christian Ray Leovido"]
        case .downloadStatementCSV, .downloadStatementCSVForDateRange:
            return ["Accept": "text/csv",
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

private let DefaultDownloadDestination: DownloadDestination = { _, response in

    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
}
