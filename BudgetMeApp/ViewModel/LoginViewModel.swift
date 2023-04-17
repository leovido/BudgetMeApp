//
//  LoginViewModel.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 06/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

enum BMDisplayColor: String {
  case `default` = "white"
  case success = "systemGreen"
  case error = "systemRed"
}

struct LoginViewModel: AlternativeViewModelBlueprint {
  typealias Provider = MoyaProvider<STAuthentication>

  typealias Input = LoginViewModelInput
  typealias Output = LoginViewModelOutput

  struct LoginViewModelInput {
    var emailTextFieldChanged: Observable<String>
    var passwordTextFieldChanged: Observable<String>
  }

  struct LoginViewModelOutput {
    var isEmailTextFieldValid: Driver<Bool>
    var isValid: Driver<Bool>
  }

  let provider: MoyaProvider<STAuthentication>

  init(provider: MoyaProvider<STAuthentication> = MoyaNetworkManagerFactory.makeManager()) {
    self.provider = provider
  }

  func transform(input: Input) -> Output {
    let isEmailTextFieldValueValid = input.emailTextFieldChanged
      .map { $0.contains("@") }
      .asDriver(onErrorJustReturn: false)

    let isPasswordTextFieldValueValid = input.passwordTextFieldChanged
      .map { $0.count > 6 }
      .asDriver(onErrorJustReturn: false)

    let isValid = Observable.combineLatest(
      isEmailTextFieldValueValid.asObservable(),
      isPasswordTextFieldValueValid.asObservable()
    )
    .map { $0 && $1 }
    .asDriver(onErrorJustReturn: false)

    return Output(
      isEmailTextFieldValid: isEmailTextFieldValueValid,
      isValid: isValid
    )
  }
}

struct STCredentials {
  var refreshToken: RefreshToken
  var cliendId: String
  var clientSecret: String
}
