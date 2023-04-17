//
//  PopularCell.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 02/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit

class PopularCell: UICollectionViewCell {
    static var identifier: String = "PopularCell"

    @IBOutlet var imageIcon: UIImageView!

    func configure(spendingCategory: SpendingCategory) {
        let imageName = SpendingCategoryFactory.makeSpendingCategory(spendingCategory: spendingCategory)
            .categoryImage

        imageIcon.image = UIImage(named: imageName)
    }
}
