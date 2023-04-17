//
//  EntityComponent.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

/// Networking component to that share common functionality with different implementation.
/// Can be extended to group common behaviour such as browse (get all), read (with specific id), edit, add, delete, etc. Basically like offering a CRUD functionality for any "Moya Manager" component that conforms to this protocol.
protocol EntityComponent {
    associatedtype Model: Decodable

    func browse(completion: @escaping (Result<[Model], Error>) -> Void)
}
