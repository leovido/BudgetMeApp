//
//  LoginViewController.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 01/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
