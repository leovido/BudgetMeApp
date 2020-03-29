//
//  TransactionSectionData.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 29/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import RxDataSources

struct TransactionSectionData: Decodable {
    var header: String
    var items: [Item]
}

extension TransactionSectionData: SectionModelType {
    typealias Item = STTransactionFeed

    init(original: TransactionSectionData, items: [Item]) {
        self = original
        self.items = items
    }
}

enum TransactionType: String {
    case income
    case expense
}
