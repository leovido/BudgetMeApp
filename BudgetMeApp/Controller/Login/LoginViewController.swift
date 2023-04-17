//
//  LoginViewController.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 01/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class LoginViewController: UIViewController {
  @IBOutlet var emailTF: UITextField!
  @IBOutlet var passwordTF: UITextField!

  @IBOutlet var loginButton: UIButton!
  @IBOutlet var googleButton: UIButton!

  var loginViewModel: LoginViewModel = .init()
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    checkToken()

    let outputs = loginViewModel.transform(input: LoginViewModel.Input(
      emailTextFieldChanged: emailTF.rx.text.orEmpty.asObservable(),
      passwordTextFieldChanged: passwordTF.rx.text.orEmpty.asObservable()
    )
    )

    outputs.isEmailTextFieldValid
      .map {
        switch $0 {
        case false: return UIColor.white
        case true: return UIColor.systemGreen
        }
      }
      .drive(emailTF.rx.backgroundColor)
      .disposed(by: disposeBag)

    outputs.isValid
      .drive(loginButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }

  func checkToken() {
    defer {
      self.stopAnimating()
    }

    startAnimating()

    if !Session.shared.token.isEmpty {
      print("VALID TOKEN")

      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
        self.stopAnimating()
        self.performSegue(withIdentifier: "HomeSegue", sender: self)
      }
    }
  }
}
