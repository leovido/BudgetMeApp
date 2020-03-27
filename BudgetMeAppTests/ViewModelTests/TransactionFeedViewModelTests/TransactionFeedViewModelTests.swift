//
//  TransactionFeedViewModelTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 27/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import BudgetMeApp

class TransactionFeedViewModelTests: XCTestCase {

    var txsViewModel: TransactionsViewModel!

    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUp() {

        disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        txsViewModel = nil
    }

    func testDataSource() {

        txsViewModel = TransactionsViewModel(accountId: "")

        let dataSourceMock = scheduler.createObserver([STTransactionFeed].self)
        txsViewModel.dataSource
            .bind(to: dataSourceMock)
            .disposed(by: disposeBag)

        let tx = STTransactionFeed(feedItemUid: "", categoryUid: "", amount: nil, sourceAmount: nil, direction: nil, updatedAt: nil, transactionTime: nil, settlementTime: nil, retryAllocationUntilTime: nil, source: nil, sourceSubType: nil, status: nil, counterPartyType: nil, counterPartyUid: nil, counterPartyName: nil, counterPartySubEntityUid: nil, counterPartySubEntityName: nil, counterPartySubEntityIdentifier: nil, counterPartySubEntitySubIdentifier: nil, exchangeRate: nil, totalFees: nil, reference: nil, country: nil, spendingCategory: nil, userNote: nil, roundUp: nil)

        let randomTransactions = [tx]

        scheduler.createColdObservable([.next(15, randomTransactions)])
            .bind(to: txsViewModel.dataSource)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(dataSourceMock.events, [.next(0, []),
                                               .next(15, randomTransactions)])

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
