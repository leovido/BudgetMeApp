//
//  TransactionsViewModel.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxMoya
import Moya

extension TransactionsViewModel: Roundable {
    typealias NewElement = MinorUnits
}

struct TransactionsViewModel: ViewModelBlueprint {

    typealias T = TransactionSectionData

    var isLoading: PublishSubject<Bool> = PublishSubject()
    var dataSource: BehaviorRelay<[TransactionSectionData]> = BehaviorRelay(value: [])

    let provider: MoyaProvider<STTransactionFeedService>
    let errorPublisher: PublishSubject<Error>

    let disposeBag: DisposeBag

    init(provider: MoyaProvider<STTransactionFeedService> = MoyaNetworkManagerFactory.makeManager(),
         accountId: String) {
        self.provider = provider
        self.errorPublisher = PublishSubject()
        self.disposeBag = DisposeBag()
    }

    var savingsDisplayString: Currency {
        return convertToCurrency(value: savings)
    }

    var savings: Int {
        dataSource.value
            .compactMap({ $0.sourceAmount?.minorUnits })
            .compactMap(roundUp)
            .reduce(0, +)
    }

    private func calculateNextWeek(startDate: String) -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        guard let newDate = dateFormatter.date(from: startDate) else { return nil }
        guard let endDate = Calendar.current.date(byAdding: .day, value: 7, to: newDate) else { return nil }

        let endDateString = dateFormatter.string(from: endDate)

        return endDateString

    }

    func refreshData(with dateTime: DateTime) {

        let endDate = calculateNextWeek(startDate: dateTime)!

        self.isLoading.onNext(true)
        provider.rx.request(.getWeeklyTransactions(accountId: Session.shared.accountId,
                                                   categoryId: "c4ed84e4-8cc9-4a3b-8df5-85996f67f2db",
                                                   startDate: dateTime,
                                                   endDate: endDate))
        .filterSuccessfulStatusCodes()
            .map([STTransactionFeed].self, atKeyPath: "feedItems")
            .subscribe { event in
                switch event {
                    case .success(let transactions):

                        self.dataSource.accept(transactions)
                        self.isLoading.onNext(false)

                    case .error(let error):
                        self.errorPublisher.onNext(error)
                        self.isLoading.onNext(false)
                }
            }
        .disposed(by: disposeBag)


    }

    func refreshData() {
        self.isLoading.onNext(true)
        provider.rx.request(.browseTransactions(accountId: Session.shared.accountId, categoryId: "c4ed84e4-8cc9-4a3b-8df5-85996f67f2db", changesSince: Date().description))
            .filterSuccessfulStatusCodes()
            .map([STTransactionFeed].self, atKeyPath: "feedItems")
            .subscribe { event in
                switch event {
                    case .success(let transactions):

                        self.dataSource.accept(transactions)
                        self.isLoading.onNext(false)

                    case .error(let error):
                        self.errorPublisher.onNext(error)
                        self.isLoading.onNext(false)
                }
            }
        .disposed(by: disposeBag)
    }

}
