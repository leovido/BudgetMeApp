//
//  SegueManager.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 13/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit

enum SegueIdentifier: String {
    case transactionSegue = "TransactionSegue"
}

struct SegueManager {

    typealias SegueDestination = UIViewController

    let segueDestination: SegueDestination
    let segueIdentifier: SegueIdentifier

    func performSegue(with account: AccountComposite) {

        guard let destinationVieController = segueDestination as? TransactionFeedViewController else {
            return
        }

        destinationVieController.account = account
    }

    init?(_ segue: UIStoryboardSegue) {

        guard let segueIdentifier = segue.identifier else {
            return nil
        }

        guard let id = SegueIdentifier(rawValue: segueIdentifier) else {
            return nil
        }

        self.segueDestination = segue.destination
        self.segueIdentifier = id

    }
}
