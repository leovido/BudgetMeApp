//
//  RoundUp.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

struct RoundUp: Decodable, Equatable, Hashable {
    public let goalCategoryUid: String
    public let amount: CurrencyAndAmount
}
