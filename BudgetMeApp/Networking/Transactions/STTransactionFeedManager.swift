//
//  STTransactionFeedManager.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya

struct STTransactionFeedManager: EntityComponent {

    typealias Model = STTransactionFeed

    let accountId: String

    private var decoder = JSONDecoder()
    private var provider: MoyaProvider<STTransactionFeedService>

    init(accountId: String,
         provider: MoyaProvider<STTransactionFeedService> = MoyaNetworkManagerFactory.makeManager()) {
        self.accountId = accountId
        self.provider = provider
    }

    func browse(completion: @escaping (Result<[STTransactionFeed], Error>) -> Void) {

        var accounts: [STTransactionFeed] = []

        provider.request(.browseTransactions(accountId: accountId,
                                             categoryId: "c4ed84e4-8cc9-4a3b-8df5-85996f67f2db", changesSince: "2020-03-01T11:19:25.581Z")) { result in
            switch result {
            case .success(let response):

                do {

                    accounts = try response.map([STTransactionFeed].self,
                                                atKeyPath: "feedItems",
                                                using: self.decoder,
                                                failsOnEmptyData: true)

                    completion(.success(accounts))

                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }

    func getWeeklyTransactions(startDate: DateTime, completion: @escaping (Result<[STTransactionFeed], Error>) -> Void) {

        var transactions: [STTransactionFeed] = []

        guard let endDate = calculateNextWeek(startDate: startDate) else { return }

        provider.request(.getWeeklyTransactions(accountId: accountId,
                                                categoryId: "c4ed84e4-8cc9-4a3b-8df5-85996f67f2db",
                                                startDate: startDate, endDate: endDate)) { result in
            switch result {
            case .success(let response):

                do {

                    transactions = try response.map([STTransactionFeed].self,
                                                atKeyPath: "feedItems",
                                                using: self.decoder,
                                                failsOnEmptyData: true)

                    completion(.success(transactions))

                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
                                                    }
        }

    }

    private func calculateNextWeek(startDate: String) -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        guard let newDate = dateFormatter.date(from: startDate) else { return nil }
        guard let endDate = Calendar.current.date(byAdding: .day, value: 7, to: newDate) else { return nil }

        let endDateString = dateFormatter.string(from: endDate)

        return endDateString

    }

}
