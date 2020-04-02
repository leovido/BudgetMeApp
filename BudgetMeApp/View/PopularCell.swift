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

    @IBOutlet weak var imageIcon: UIImageView!

    func configure(spendingCategory: SpendingCategory) {
        if #available(iOS 13.0, *) {

            switch spendingCategory {
            case .OTHER:
                self.imageIcon.image = UIImage(systemName: "pencil.and.ellipsis.rectangle")!
            case .REVENUE:
                self.imageIcon.image = UIImage(systemName: "sterlingsign.circle.fill")!
            case .TRAVEL:
                self.imageIcon.image = UIImage(systemName: "airplane")!
            default:
                self.imageIcon.image = UIImage(systemName: "bag")!
            }

        } else {
            // Fallback on earlier versions
        }
    }

}
