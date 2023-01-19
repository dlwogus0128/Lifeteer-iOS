//
//  UserDefaultKeyList.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/01/19.
//

import Foundation

struct UserDefaultKeyList {
    struct Auth {
        @UserDefaultWrapper<Bool>(key: "didSignIn") public static var didSignIn
    }
}
