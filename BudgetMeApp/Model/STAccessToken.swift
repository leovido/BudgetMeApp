//
//  STAccessToken.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 06/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

struct STAccessToken: Decodable {
    var access_token: String
    var refresh_token: String
    var token_type: String
    var expires_in: Int
    var scope: String
}
