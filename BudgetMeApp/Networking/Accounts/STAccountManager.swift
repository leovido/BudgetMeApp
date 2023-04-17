//
//  STAccountManager.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya

struct STAccountManager: EntityComponent {
    typealias Model = STAccount

    private var decoder = JSONDecoder()
    private var provider: MoyaProvider<STAccountService>

    init(provider: MoyaProvider<STAccountService> = MoyaNetworkManagerFactory.makeManager()) {
        self.provider = provider
    }

    func browse(completion: @escaping (Result<[STAccount], Error>) -> Void) {
        var accounts: [STAccount] = []

        provider.request(.browseAccounts) { result in
            switch result {
            case let .success(response):

                do {
                    accounts = try response.map([STAccount].self,
                                                atKeyPath: "accounts",
                                                using: self.decoder,
                                                failsOnEmptyData: true)

                    completion(.success(accounts))

                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
