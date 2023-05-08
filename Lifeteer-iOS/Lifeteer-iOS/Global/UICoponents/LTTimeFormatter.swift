//
//  LTTimeFormatter.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/04/03.
//

import Foundation

class LTTimeFormatter {
    static func getCurrentMonthToString() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월"
        dateFormatter.timeZone = NSTimeZone(name: "ko-KR") as TimeZone?
        
        return dateFormatter.string(from: now)
    }
}
