//
//  AccountComposite.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 31/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

struct AccountComposite: Decodable, Equatable {
    var account: STAccount
    var balance: STBalance
    var identifiers: STAccountIdentifiers
}
