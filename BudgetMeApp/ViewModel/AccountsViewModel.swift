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

    typealias T = AccountComposite

    let provider: MoyaProvider<STAccountService>

    let isLoading: PublishSubject<Bool>
    let dataSource: BehaviorRelay<[AccountComposite]>
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
        getAllAccounts()
            .do(onNext: { _ in
                self.isLoading.onNext(true)
            })
            .flatMap({ value in
                self.setupAccountComposite(account: value.first!)
            })
            .subscribe { event in
                switch event {
                case .next(let accountComposite):
                    self.dataSource.accept([accountComposite])
                case .error(let error):
                    self.errorPublisher.onNext(error)
                case .completed:
                    self.isLoading.onNext(false)
                }
        }
        .disposed(by: disposeBag)

    }

    func setupAccountComposite(account: STAccount) -> Observable<AccountComposite> {

        let obs = Observable.zip(getBalance(accountId: account.accountUid),
                                 getIdentifiers(accountId: account.accountUid))
            .map { balance, identifiers in
                AccountComposite(account: account, balance: balance, identifiers: identifiers)
        }

        return obs

    }
}

extension AccountsViewModel {

    func getAllAccounts() -> Observable<[STAccount]> {
        let obs = provider.rx.request(.browseAccounts)
            .filterSuccessfulStatusAndRedirectCodes()
            .map([STAccount].self, atKeyPath: "accounts")
            .asObservable()
            .share(replay: 1, scope: .whileConnected)

        return obs
    }

    func getBalance(accountId: String) -> Observable<STBalance> {
        let obs = self.provider.rx.request(.getBalance(accountId: accountId))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(STBalance.self)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)

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

}

extension AccountsViewModel {

    func downloadPDFStatement(accountId: String, yearMonth: String) -> Observable<Response> {
        let observable = provider.rx.request(.downloadStatementPDF(accountId: accountId,
                                                                   yearMonth: yearMonth))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()

        return observable
    }

    func downloadStatementPDF(accountId: String, start: DateTime, end: DateTime) -> Observable<Response> {
        let obs = provider.rx.request(.downloadStatementPDFForDateRange(accountId: accountId,
                                                                        start: start,
                                                                        end: end))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()

        return obs
    }

    func downloadCSVStatement(accountId: String, yearMonth: String) -> Observable<Response> {
        let observable = provider.rx.request(.downloadStatementCSV(accountId: accountId,
                                                                   yearMonth: yearMonth))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()

        return observable
    }

    func downloadStatementCSV(accountId: String, start: DateTime, end: DateTime) -> Observable<Response> {
        let obs = provider.rx.request(.downloadStatementCSVForDateRange(accountId: accountId,
                                                                        start: start,
                                                                        end: end))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()

        return obs
    }

}
