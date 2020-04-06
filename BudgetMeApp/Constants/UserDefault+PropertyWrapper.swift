//
//  UserDefault+PropertyWrapper.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 06/04/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

struct UserDefaultsConfig {
    @UserDefault("token", defaultValue: "")
    static var token: String

    @UserDefault("refreshToken", defaultValue: "")
    static var refreshToken: String
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {

    public enum Keys {
        static let token = "token"
        static let refreshToken = "refreshToken"
    }

    var token: String {
        set {
            set(newValue, forKey: Keys.token)
        }
        get {
            return string(forKey: Keys.token) ?? ""
        }
    }

    var refreshToken: String {
        set {
            set(newValue, forKey: Keys.refreshToken)
        }
        get {
            return string(forKey: Keys.refreshToken) ?? ""
        }
    }
}
