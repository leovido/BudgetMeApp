//
//  SavingsViewModel.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxMoya
import Moya

struct SavingsViewModel: ViewModelBlueprint {

    typealias Model = STSavingsGoal

    let isLoading: PublishSubject<Bool>
    let dataSource: BehaviorRelay<[STSavingsGoal]>

    let provider: MoyaProvider<STSavingsGoalService>
    let errorPublisher: PublishSubject<Error>
    let disposeBag: DisposeBag

    init(provider: MoyaProvider<STSavingsGoalService> = MoyaNetworkManagerFactory.makeManager()) {
        self.isLoading = PublishSubject()
        self.dataSource = BehaviorRelay(value: [])
        self.provider = provider
        self.errorPublisher = PublishSubject()
        self.disposeBag = DisposeBag()
    }

    func refreshData() {

    }

    func refreshData(completion: @escaping () -> Void) {
        self.isLoading.onNext(true)
        provider.rx.request(.browseSavings)
            .debug(#function, trimOutput: true)
            .filterSuccessfulStatusCodes()
            .map([STSavingsGoal].self, atKeyPath: "savingsGoalList")
            .retry(2)
            .subscribe { event in
                switch event {
                case .success(let savings):
                    completion()
                    self.dataSource.accept(savings)
                case .error(let error):
                    self.errorPublisher.onNext(error)
                }
        }
        .disposed(by: disposeBag)
    }

    func createNewSaving(name: String) {
        self.isLoading.onNext(true)
        provider.rx.request(.createSaving(name: name))
            .filterSuccessfulStatusCodes()
            .map(Bool.self)
            .subscribe { event in
                switch event {
                case .success(let success):
                    if success {
                        self.refreshData {
                            self.isLoading.onNext(false)
                        }
                    }
                case .error(let error):
                    self.errorPublisher.onNext(error)
                    self.isLoading.onNext(false)
                }
        }
        .disposed(by: disposeBag)
    }

}
