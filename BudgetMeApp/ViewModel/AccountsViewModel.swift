//
//  AccountsViewModel.swift
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

struct AccountsViewModel: ViewModelBlueprint {

    typealias T = STAccount
    typealias Provider = MoyaProvider

    let provider: MoyaProvider<STAccountService>

    let isLoading: PublishSubject<Bool>
    let dataSource: BehaviorRelay<[STAccount]>
    let errorPublisher: PublishSubject<Error>
    let disposeBag: DisposeBag

    init(provider: MoyaProvider<STAccountService> = MoyaNetworkManagerFactory.makeManager()) {
        self.provider = provider
        self.isLoading = PublishSubject()
        self.dataSource = BehaviorRelay(value: [])
        self.errorPublisher = PublishSubject()
        self.disposeBag = DisposeBag()
    }


    func refreshData() {
        self.isLoading.onNext(true)
        provider.rx.request(.browseAccounts)
            .debug("refreshData @ AccountsViewModel")
            .filterSuccessfulStatusAndRedirectCodes()
            .map([STAccount].self, atKeyPath: "accounts")
    func getBalances(accountIds: [String]) -> Observable<[STBalance]> {


        let obs = Observable.from(accountIds)
            .flatMap({
                self.provider.rx.request(.getBalance(accountId: $0))
                           .filterSuccessfulStatusAndRedirectCodes()
                           .map(STBalance.self)
            })

        return obs
    }
            .subscribe { event in
                switch event {
                case .success(let accounts):
                    self.dataSource.accept(accounts)
                case .error(let error):
                    self.errorPublisher.onNext(error)
                }
            }.disposed(by: disposeBag)
    }
}
