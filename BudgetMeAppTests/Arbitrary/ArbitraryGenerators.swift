//
//  ArbitraryGenerators.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 31/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import SwiftCheck
@testable import BudgetMeApp

extension CurrencySymbol: Arbitrary {
  public static var arbitrary: Gen<CurrencySymbol> {
    Gen<CurrencySymbol>.pure(CurrencySymbol.allCases.randomElement()!)
  }
}

extension CurrencyAndAmount: Arbitrary {
  public static var arbitrary: Gen<CurrencyAndAmount> {
    Gen<CurrencyAndAmount>.compose { builder -> CurrencyAndAmount in
      CurrencyAndAmount(currency: builder.generate(),
                        minorUnits: Gen<Int>.choose((0, 10_000_000)).generate)
    }
  }
}

extension Country: Arbitrary {
  public static var arbitrary: Gen<Country> {
    Gen<Country>.fromElements(of: Country.allCases)
  }
}

extension CountryPartyType: Arbitrary {
  public static var arbitrary: Gen<CountryPartyType> {
    Gen<CountryPartyType>.fromElements(of: CountryPartyType.allCases)
  }
}

extension Direction: Arbitrary {
  public static var arbitrary: Gen<Direction> {
    Gen<Direction>.pure(Direction.allCases.randomElement()!)
  }
}

extension Source: Arbitrary {
  public static var arbitrary: Gen<Source> {
    Gen<Source>.pure(Source.allCases.randomElement()!)
  }
}

extension SourceSubType: Arbitrary {
  public static var arbitrary: Gen<SourceSubType> {
    Gen<SourceSubType>.pure(SourceSubType.allCases.randomElement()!)
  }
}

extension Status: Arbitrary {
  public static var arbitrary: Gen<Status> {
    Gen<Status>.pure(Status.allCases.randomElement()!)
  }
}

extension SpendingCategory: Arbitrary {
  public static var arbitrary: Gen<SpendingCategory> {
    Gen<SpendingCategory>.pure(SpendingCategory.allCases.randomElement()!)
  }
}

extension RoundUp: Arbitrary {
  public static var arbitrary: Gen<RoundUp> {
    Gen<RoundUp>.compose { c -> RoundUp in
      RoundUp(goalCategoryUid: c.generate(), amount: c.generate())
    }
  }
}

extension STTransactionFeed: Arbitrary {
  public static var arbitrary: Gen<STTransactionFeed> {
    Gen<STTransactionFeed>.compose { c in
      STTransactionFeed(feedItemUid: Gen<String>.pure(UUID().uuidString).generate,
                        categoryUid: Gen<String>.pure(UUID().uuidString).generate,
                        amount: CurrencyAndAmount(currency: .GBP, minorUnits: Int.random(in: 0 ..< 1_000_000)),
                        sourceAmount: c.generate(),
                        direction: c.generate(),
                        updatedAt: Date().description,
                        transactionTime: Date().description,
                        settlementTime: Date().description,
                        retryAllocationUntilTime: Date().description,
                        source: c.generate(),
                        sourceSubType: c.generate(),
                        status: c.generate(),
                        counterPartyType: c.generate(),
                        counterPartyUid: c.generate(),
                        counterPartyName: c.generate(),
                        counterPartySubEntityUid: c.generate(),
                        counterPartySubEntityName: c.generate(),
                        counterPartySubEntityIdentifier: c.generate(),
                        counterPartySubEntitySubIdentifier: c.generate(),
                        exchangeRate: c.generate(),
                        totalFees: c.generate(),
                        reference: c.generate(),
                        country: c.generate(),
                        spendingCategory: c.generate(),
                        userNote: c.generate(),
                        roundUp: c.generate())
    }
  }

  public static var arbitraryOUTDirection: Gen<STTransactionFeed> {
    Gen<STTransactionFeed>.compose { c in
      STTransactionFeed(feedItemUid: Gen<String>.pure(UUID().uuidString).generate,
                        categoryUid: Gen<String>.pure(UUID().uuidString).generate,
                        amount: CurrencyAndAmount(currency: .GBP,
                                                  minorUnits: Int.random(in: 0 ..< 1_000_000)),
                        sourceAmount: c.generate(),
                        direction: .OUT,
                        updatedAt: Date().description,
                        transactionTime: Date().description,
                        settlementTime: Date().description,
                        retryAllocationUntilTime: Date().description,
                        source: c.generate(),
                        sourceSubType: c.generate(),
                        status: c.generate(),
                        counterPartyType: c.generate(),
                        counterPartyUid: c.generate(),
                        counterPartyName: c.generate(),
                        counterPartySubEntityUid: c.generate(),
                        counterPartySubEntityName: c.generate(),
                        counterPartySubEntityIdentifier: c.generate(),
                        counterPartySubEntitySubIdentifier: c.generate(),
                        exchangeRate: c.generate(),
                        totalFees: c.generate(),
                        reference: c.generate(),
                        country: c.generate(),
                        spendingCategory: c.generate(),
                        userNote: c.generate(),
                        roundUp: c.generate())
    }
  }

  public static var arbitraryInDirection: Gen<STTransactionFeed> {
    Gen<STTransactionFeed>.compose { c in
      STTransactionFeed(feedItemUid: Gen<String>.pure(UUID().uuidString).generate,
                        categoryUid: Gen<String>.pure(UUID().uuidString).generate,
                        amount: CurrencyAndAmount(currency: .GBP, minorUnits: Int.random(in: 0 ..< 1_000_000)),
                        sourceAmount: c.generate(),
                        direction: .IN,
                        updatedAt: Date().description,
                        transactionTime: Date().description,
                        settlementTime: Date().description,
                        retryAllocationUntilTime: Date().description,
                        source: c.generate(),
                        sourceSubType: c.generate(),
                        status: c.generate(),
                        counterPartyType: c.generate(),
                        counterPartyUid: c.generate(),
                        counterPartyName: c.generate(),
                        counterPartySubEntityUid: c.generate(),
                        counterPartySubEntityName: c.generate(),
                        counterPartySubEntityIdentifier: c.generate(),
                        counterPartySubEntitySubIdentifier: c.generate(),
                        exchangeRate: c.generate(),
                        totalFees: c.generate(),
                        reference: c.generate(),
                        country: c.generate(),
                        spendingCategory: c.generate(),
                        userNote: c.generate(),
                        roundUp: c.generate())
    }
  }

  public static var arbitraryWithSources: Gen<STTransactionFeed> {
    Gen<STTransactionFeed>.compose { c in
      STTransactionFeed(feedItemUid: Gen<String>.pure(UUID().uuidString).generate,
                        categoryUid: Gen<String>.pure(UUID().uuidString).generate,
                        amount: CurrencyAndAmount(currency: .GBP, minorUnits: Int.random(in: 0 ..< 1_000_000)),
                        sourceAmount: c.generate(),
                        direction: c.generate(),
                        updatedAt: Date().description,
                        transactionTime: Date().description,
                        settlementTime: Date().description,
                        retryAllocationUntilTime: Date().description,
                        source: Source.allCases.randomElement()!,
                        sourceSubType: SourceSubType.allCases.randomElement()!,
                        status: c.generate(),
                        counterPartyType: c.generate(),
                        counterPartyUid: c.generate(),
                        counterPartyName: c.generate(),
                        counterPartySubEntityUid: c.generate(),
                        counterPartySubEntityName: c.generate(),
                        counterPartySubEntityIdentifier: c.generate(),
                        counterPartySubEntitySubIdentifier: c.generate(),
                        exchangeRate: c.generate(),
                        totalFees: c.generate(),
                        reference: c.generate(),
                        country: c.generate(),
                        spendingCategory: c.generate(),
                        userNote: c.generate(),
                        roundUp: c.generate())
    }
  }
}

extension STBalance: Arbitrary {
  public static var arbitrary: Gen<STBalance> {
    Gen<STBalance>.compose { gc -> STBalance in
      STBalance(clearedBalance: gc.generate(),
                effectiveBalance: gc.generate(),
                pendingTransactions: gc.generate(),
                acceptedOverdraft: gc.generate(),
                amount: gc.generate())
    }
  }
}
