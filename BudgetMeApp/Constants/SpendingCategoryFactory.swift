//
//  SpendingCategoryFactory.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 14/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

enum SpendingCategoryFactory {
    static func makeSpendingCategory(spendingCategory: SpendingCategory) -> SpendingCategoryImage {
        switch spendingCategory {
        case .TRAVEL: return TravelSC()
        case .REVENUE: return RevenueSC()
        case .OTHER: return OtherSC()
        default: return DefaultSC()
        }
    }
}

protocol SpendingCategoryImage {
    var categoryImage: String { get }
}

private struct RevenueSC: SpendingCategoryImage {
    var categoryImage: String {
        "sterlingsign.circle.fill"
    }
}

private struct OtherSC: SpendingCategoryImage {
    var categoryImage: String {
        "pencil.and.ellipsis.rectangle"
    }
}

private struct TravelSC: SpendingCategoryImage {
    var categoryImage: String {
        "airplane"
    }
}

private struct DefaultSC: SpendingCategoryImage {
    var categoryImage: String {
        "bag"
    }
}
