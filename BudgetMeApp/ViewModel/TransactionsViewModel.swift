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

extension TransactionsViewModel: Roundable {
    typealias NewElement = MinorUnits
}

final class TransactionsViewModel: ViewModelBlueprint {

    typealias T = Transaction

    var isLoading: PublishSubject<Bool> = PublishSubject()
    var dataSource: BehaviorRelay<[Transaction]> = BehaviorRelay(value: [])

    let provider: STTransactionFeedManager
    var errorPublisher: PublishSubject<Error>

    init(accountId: String) {
        self.provider = STTransactionFeedManager(accountId: accountId)
        self.errorPublisher = PublishSubject()
    }

    var savingsDisplayString: Currency {
        return convertToCurrency(value: savings)
    }

    var savings: Int {
        dataSource.value
            .compactMap({ $0.sourceAmount.minorUnits })
            .compactMap(roundUp)
            .reduce(0, +)
    }

    func refreshData(with dateTime: DateTime, completion: @escaping () -> Void) {
        self.isLoading.onNext(true)
        provider.getWeeklyTransactions(startDate: dateTime) { result in
            switch result {
            case .success(let transactions):
                let txs = transactions
                    .compactMap({ Transaction(tx: $0)
                    })

                self.dataSource.accept(txs)
                self.isLoading.onNext(false)

                completion()

            case .failure(let error):
                self.isLoading.onNext(false)
            }
        }
    }

    func refreshData(completion: @escaping () -> Void) {
        self.isLoading.onNext(true)
        provider.browse { result in
            switch result {
            case .success(let transactions):
                let txs = transactions
                    .compactMap({ Transaction(tx: $0)
                    })

                self.dataSource.accept(txs)
                self.isLoading.onNext(false)

                completion()

            case .failure(let error):
                self.isLoading.onNext(false)
            }
        }
    }

}
