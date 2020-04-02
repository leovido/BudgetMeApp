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
import RxDataSources

extension TransactionsViewModel: Roundable {
    typealias NewElement = MinorUnits
}

extension TransactionsViewModel: CurrencyFormattable {}

struct TransactionsViewModel: ViewModelBlueprint {

    typealias T = TransactionSectionData

    var isLoading: PublishSubject<Bool> = PublishSubject()
    var dataSource: BehaviorRelay<[TransactionSectionData]> = BehaviorRelay(value: [])

    let provider: MoyaProvider<STTransactionFeedService>
    let errorPublisher: PublishSubject<Error>

    // outputs
    let dateRange: PublishSubject<String>

    let disposeBag: DisposeBag

    init(provider: MoyaProvider<STTransactionFeedService> = MoyaNetworkManagerFactory.makeManager(),
         accountId: String) {
        self.provider = provider
        self.errorPublisher = PublishSubject()
        self.disposeBag = DisposeBag()
        self.dateRange = PublishSubject()
    }

    var savingsDisplayString: Currency {
        return convertToCurrency(value: savings)
    }

    var savings: Int {
        return 0
//        dataSource.value
//            .compactMap({ $0.sourceAmount?.minorUnits })
//            .compactMap(roundUp)
//            .reduce(0, +)
    }

    func makeTransactionRequest(start: DateTime, end: DateTime) -> Observable<[STTransactionFeed]> {
        return provider.rx.request(.getWeeklyTransactions(accountId: Session.shared.accountId,
                                                          categoryId: "c4ed84e4-8cc9-4a3b-8df5-85996f67f2db",
                                                          startDate: start, endDate: end))
            .do(onSubscribe: {
                self.isLoading.onNext(true)
            })
            .filterSuccessfulStatusCodes()
            .map([STTransactionFeed].self, atKeyPath: "feedItems")
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
    }

    func updateDataSource(startDate: DateTime, endDate: DateTime) {

        makeTransactionRequest(start: startDate, end: endDate)
            .map({ txs -> [TransactionSectionData] in

                let items = [TransactionSectionData(header: TransactionType.income.rawValue.capitalized,
                                                 items: txs
                                                    .filter({ $0.direction == .IN })),
                             TransactionSectionData(header: TransactionType.expense.rawValue.capitalized,
                                                 items: txs
                                                    .filter({ $0.direction == .OUT })
                            )]

                return items
            })
            .subscribe { event in
                switch event {
                case .next(let txs):
                    self.dataSource.accept(txs)
                case .error(let error):
                    self.errorPublisher.onNext(error)
                case .completed:
                    self.isLoading.onNext(false)
                }
        }
        .disposed(by: disposeBag)
    }

    func refreshData(with dateTime: DateTime) {
        let endDate = calculateNextWeek(startDate: dateTime)!
        updateDateRange(dateTime: dateTime)
        updateDataSource(startDate: dateTime, endDate: endDate)
    }

    func refreshData() {

        self.isLoading.onNext(true)

        provider.rx.request(.browseTransactions(accountId: Session.shared.accountId,
                                                categoryId: "c4ed84e4-8cc9-4a3b-8df5-85996f67f2db",
                                                changesSince: Date().description))
            .filterSuccessfulStatusCodes()
            .map([STTransactionFeed].self, atKeyPath: "feedItems")
            .map({ transactions -> [TransactionSectionData] in

                let expenses = transactions.filter({ $0.direction == .OUT })
                let income = transactions.filter({ $0.direction == .IN })

                let dataSource = [TransactionSectionData(header: "Income", items: income),
                                  TransactionSectionData(header: "Expenses", items: expenses)]

                return dataSource
            })
            .subscribe { event in
                switch event {
                case .success(let transactionSectionData):

                    self.dataSource.accept(transactionSectionData)
                    self.isLoading.onNext(false)

                case .error(let error):

                    self.errorPublisher.onNext(error)
                    self.isLoading.onNext(false)
            }
        }
        .disposed(by: disposeBag)
    }

}

extension TransactionsViewModel {

    private func calculateNextWeek(startDate: String) -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        guard let newDate = dateFormatter.date(from: startDate) else { return nil }
        guard let endDate = Calendar.current.date(byAdding: .day, value: 7, to: newDate) else { return nil }

        let endDateString = dateFormatter.string(from: endDate)

        return endDateString

    }

    func updateDateRange(dateTime: DateTime) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"

        guard let startDate = dateFormatter.date(from: dateTime) else { return }
        guard let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate) else { return }

        dateFormatter.dateFormat = "dd/MM"

        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)

        self.dateRange.onNext(startDateString + endDateString)
    }

}
