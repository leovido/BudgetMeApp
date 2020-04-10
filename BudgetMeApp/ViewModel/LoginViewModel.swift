//
//  LoginViewModel.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 06/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

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
        var isRememberMeSelected: Observable<Bool>
        var loginButtonTapped: Signal<()>
    }

    struct LoginViewModelOutput {
        var isEmailTextFieldValid: Driver<Bool>
        var isValid: Driver<Bool>

        var loginCredentials: Observable<STAccessToken>
    }

    var provider: MoyaProvider<STAuthentication> = MoyaNetworkManagerFactory.makeManager()

    func transform(input: Input) -> Output {

        let isEmailTextFieldValueValid = input.emailTextFieldChanged
            .map({ $0.contains("@") })
            .asDriver(onErrorJustReturn: false)

        let isPasswordTextFieldValueValid = input.passwordTextFieldChanged
            .map({ $0.count > 6 })
            .asDriver(onErrorJustReturn: false)

        let isValid = Observable.combineLatest(isEmailTextFieldValueValid.asObservable(),
                                               isPasswordTextFieldValueValid.asObservable())
            .map({ $0 && $1 })
            .asDriver(onErrorJustReturn: false)

        input.loginButtonTapped
        let loginCredentials = provider.rx
            .request(.authenticate(refreshToken: Session.shared.refreshToken,
            .map(STAccessToken.self)
            .asObservable()
            .share()

        return Output(isEmailTextFieldValid: isEmailTextFieldValueValid,
                      isValid: isValid,
                      loginCredentials: loginCredentials)
    }

}

struct STCredentials {
    var refreshToken: RefreshToken
    var cliendId: String
    var clientSecret: String
}
