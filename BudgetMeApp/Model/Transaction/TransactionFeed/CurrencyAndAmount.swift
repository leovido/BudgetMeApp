//
//  CurrencyAndAmount.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

public typealias MinorUnits = Int
public typealias Currency = String

public struct CurrencyAndAmount: Decodable {
    var currency: CurrencySymbol
    var minorUnits: MinorUnits
}
