//
//  STSavingsGoal.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

struct STSavingsGoal: Decodable {
  let savingsGoalUid: String
  let name: String
  let target: CurrencyAndAmount?
  let totalSaved: CurrencyAndAmount
  let savedPercentage: Int?
}
