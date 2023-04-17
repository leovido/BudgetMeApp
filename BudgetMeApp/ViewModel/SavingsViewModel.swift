//
//  SavingsViewModel.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import RxMoya
import RxSwift

struct SavingsViewModel: ViewModelBlueprint {
    typealias Model = STSavingsGoal

    let isLoading: PublishSubject<Bool>
    let dataSource: BehaviorRelay<[STSavingsGoal]>

    let provider: MoyaProvider<STSavingsGoalService>
    let errorPublisher: PublishSubject<Error>
    let disposeBag: DisposeBag

    init(provider: MoyaProvider<STSavingsGoalService> = MoyaNetworkManagerFactory.makeManager()) {
        isLoading = PublishSubject()
        dataSource = BehaviorRelay(value: [])
        self.provider = provider
        errorPublisher = PublishSubject()
        disposeBag = DisposeBag()
    }

    func refreshData() {
        isLoading.onNext(true)
        provider.rx.request(.browseSavings)
            .filterSuccessfulStatusCodes()
            .map([STSavingsGoal].self, atKeyPath: "savingsGoalList")
            .retry(2)
            .subscribe { event in
                switch event {
                case let .success(savings):
                    self.isLoading.onNext(false)
                    self.dataSource.accept(savings)
                case let .error(error):
                    self.errorPublisher.onNext(error)
                }
            }
            .disposed(by: disposeBag)
    }

    func createNewSaving(name: String) {
        isLoading.onNext(true)
        provider.rx.request(.createSaving(name: name))
            .filterSuccessfulStatusCodes()
            .map(Bool.self)
            .subscribe { event in
                switch event {
                case let .success(success):
                    if success {
                        self.isLoading.onNext(false)
                        self.refreshData()
                    }
                case let .error(error):
                    self.errorPublisher.onNext(error)
                    self.isLoading.onNext(false)
                }
            }
            .disposed(by: disposeBag)
    }
}
