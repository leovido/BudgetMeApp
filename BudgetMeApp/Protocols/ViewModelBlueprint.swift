//
//  ViewModelBlueprint.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

/// Protocol/Interface to be shared for view models with same functionality, different implementation.
/// A provider has a specific Model that is assigned to the component that conforms to this protocol.
/// dataSource is an Observable that signals values when it changes
protocol ViewModelBlueprint {

	associatedtype T: Decodable
    associatedtype Provider

	var provider: Provider { get }
	var isLoading: PublishSubject<Bool> { get }
	var dataSource: BehaviorRelay<[T]> { get }
	var errorPublisher: PublishSubject<Error> { get }

	func refreshData(completion: @escaping () -> Void)

}

protocol AlternativeViewModelBlueprint {

    associatedtype Input
    associatedtype Output
    associatedtype Provider

    var input: Input { get }
    var output: Output { get }
    var provider: Provider { get }

    func refreshData(completion: @escaping () -> Void)
}
