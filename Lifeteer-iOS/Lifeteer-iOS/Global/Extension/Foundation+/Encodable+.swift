//
//  Encodable+.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/01/19.
//

import Foundation

// MARK: - Encodable Extension

extension Encodable {
    
  func asParameter() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            as? [String: Any] else {
        throw NSError()
    }
    return dictionary
  }
}
