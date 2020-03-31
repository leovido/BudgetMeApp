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
    func getIdentifiers(accountId: String) -> Observable<STAccountIdentifiers> {
        let observable = provider.rx.request(.getIdentifiers(accountId: accountId))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(STAccountIdentifiers.self)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)

        return observable
    }
    func getStatementPeriods(accountId: String) -> Observable<AccountStatementPeriods> {
        let observable = provider.rx.request(.getAvailableStatementPeriods(accountId: accountId))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(AccountStatementPeriods.self, atKeyPath: "periods")
            .asObservable()
            .share(replay: 1, scope: .whileConnected)

        return observable
    }
    func getConfirmationOfFunds(accountId: String) -> Observable<ConfirmationOfFundsResponse> {
        let observable = provider.rx.request(.getConfirmationOfFunds(accountId: accountId))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(ConfirmationOfFundsResponse.self)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)

        return observable
    }
    func downloadStatement(accountId: String, start: DateTime?, end: DateTime?) -> Observable<Data> {

        guard let start = start, let end = end else {

            let observable = provider.rx.request(.downloadStatement(accountId: accountId))
                .filterSuccessfulStatusAndRedirectCodes()
                .map { response in
                    response.data
            }
            .asObservable()

            return observable
        }

        let obs = provider.rx.request(.downloadStatementForDateRange(accountId: accountId,
                                                                     start: start,
                                                                     end: end))
            .filterSuccessfulStatusAndRedirectCodes()
            .map { response in
                response.data
        }
        .asObservable()

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
    func setupAccountComposite(account: STAccount) -> Observable<AccountComposite> {

        let obs = Observable.zip(getBalance(accountId: account.accountUid),
                       getIdentifiers(accountId: account.accountUid))
            .map { balance, identifiers in
                AccountComposite(account: account, balance: balance, identifiers: identifiers)
        }

        return obs

    }
}
