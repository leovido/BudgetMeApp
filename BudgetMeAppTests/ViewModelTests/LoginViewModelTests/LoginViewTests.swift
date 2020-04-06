//
//  LoginViewTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 06/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest
import Moya
import RxSwift
import RxCocoa
import RxTest
@testable import BudgetMeApp

class LoginViewTests: XCTestCase {

    var loginViewModel: LoginViewModel!
    var scheduler: TestScheduler!
    var disposeBag = DisposeBag()

    override func setUp() {

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAuthentication() {

        loginViewModel = LoginViewModel(provider: makeMoyaSuccessStub(type: .auth))
        scheduler = TestScheduler(initialClock: 0)
        let mockAccessToken = scheduler.createObserver(STAccessToken.self)

        let mockButton = UIButton()
        let output = loginViewModel.transform(input: LoginViewModel.Input(
            emailTextFieldChanged: Observable.of(""),
            passwordTextFieldChanged: Observable.of(""),
            loginButtonTapped: mockButton.rx.controlEvent(.touchUpInside).asSignal())
        )

        output.loginCredentials
            .bind(to: mockAccessToken)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(mockAccessToken.events, [.next(0, STAccessToken(
                                                            access_token: "some long token",
                                                            token_type: "tokeType",
                                                            expires_in: 86400,
                                                            scope: "some scope")
                                                            ),
                                                .completed(0)
                                                ])

    }

    func testIsEmailTextFieldValid() {

        loginViewModel = LoginViewModel(provider: makeMoyaSuccessStub(type: .auth))

        scheduler = TestScheduler(initialClock: 0)
        let mockIsValid = scheduler.createObserver(Bool.self)

        var mockEmailTextFieldValues: Observable<String>
        
        mockEmailTextFieldValues = scheduler.createHotObservable([.next(0, "s"),
                                                                  .next(10, "s"),
                                                                  .next(11, "st"),
                                                                  .next(12, "st@"),
                                                                  .next(13, "st")]).asObservable()

        let mockButton = UIButton()

        let output = loginViewModel.transform(input: LoginViewModel.Input(
            emailTextFieldChanged: mockEmailTextFieldValues,
            passwordTextFieldChanged: Observable.of(""),
            loginButtonTapped: mockButton.rx.controlEvent(.touchUpInside).asSignal())
        )

        output.isEmailTextFieldValid
            .drive(mockIsValid)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(mockIsValid.events, [.next(0, false),
                                            .next(10, false),
                                            .next(11, false),
                                            .next(12, true),
                                            .next(13, false)])

    }

    private var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    enum STAuthenticationSuccessTestCases: String {
        case auth
    }

    private func makeMoyaSuccessStub<T: TargetType>(type: STAuthenticationSuccessTestCases) -> MoyaProvider<T> {

        #if DEBUG
        let url = bundle.url(forResource: "authentication_success_" + type.rawValue, withExtension: "json")!
        let data = try! Data(contentsOf: url)

        let serverEndpointSuccess = { (target: T) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, data) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }

        let serverStubSuccess = MoyaProvider<T>(
            endpointClosure: serverEndpointSuccess,
            stubClosure: MoyaProvider.immediatelyStub,
            plugins: [
                AuthPlugin(tokenClosure: { return Session.shared.token })
            ]
        )

        return serverStubSuccess

        #endif

    }

}
