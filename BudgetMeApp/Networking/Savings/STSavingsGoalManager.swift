////
////  STSavingsGoalManager.swift
////  BudgetMeApp
////
////  Created by Christian Leovido on 24/03/2020.
////  Copyright © 2020 Christian Leovido. All rights reserved.
////
//
// import Foundation
// import Moya
//
// struct STSavingsGoalManager: EntityComponent {
//
//    typealias Model = STSavingsGoal
//
//    private let decoder = JSONDecoder()
//    private let provider: MoyaProvider<STSavingsGoalService>
//
//    let accountId: String
//
//    init(accountId: String, provider: MoyaProvider<STSavingsGoalService> = MoyaNetworkManagerFactory.makeManager()) {
//        self.accountId = accountId
//        self.provider = provider
//    }
//
//    func browse(completion: @escaping (Result<[STSavingsGoal], Error>) -> Void) {
//
//        var savings: [STSavingsGoal] = []
//
//        provider.request(.browseSavings(accountId: accountId)) { result in
//            switch result {
//            case .success(let response):
//
//                do {
//
//                    savings = try response.map([STSavingsGoal].self,
//                                                atKeyPath: "savingsGoalList",
//                                                using: self.decoder,
//                                                failsOnEmptyData: true)
//
//                    completion(.success(savings))
//
//                } catch let error {
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//
//    }
//
//    func createNewSaving(name: String, completion: @escaping (Bool) -> Void) {
//        provider.request(.createSaving(name: name, accountId: accountId)) { result in
//            switch result {
//            case .success(let response):
//                completion(true)
//            case .failure(let error):
//                completion(false)
//            }
//        }
//    }
//
//    func addMoney(amount: MinorUnits, to savingsGoalId: String, completion: @escaping (Bool) -> Void) {
//        provider.request(.addMoney(amount: amount,
//                                   accountId: accountId,
//                                   savingsGoalId: savingsGoalId)) { result in
//            switch result {
//            case .success(let response):
//                completion(true)
//            case .failure(let error):
//                completion(false)
//            }
//        }
//    }
// }
