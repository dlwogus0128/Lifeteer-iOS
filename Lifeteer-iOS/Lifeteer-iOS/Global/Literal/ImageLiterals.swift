//
//  ImageLiterals.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/01/19.
//

import UIKit

enum ImageLiterals {
    // icon
    static var icBack: UIImage { .load(named: "ic_back") }
    static var icBucketListFill: UIImage { .load(named: "ic_bucket_list_fill") }
    static var icBucketList: UIImage { .load(named: "ic_bucket_list") }
    static var icCheck: UIImage { .load(named: "ic_check") }
    static var icDiaryFill: UIImage { .load(named: "ic_diary_fill") }
    static var icDiary: UIImage { .load(named: "ic_diary") }
    static var icHealthFill: UIImage { .load(named: "ic_health_fill") }
    static var icHealth: UIImage { .load(named: "ic_health") }
    static var icLetterFill: UIImage { .load(named: "ic_letter_fill") }
    static var icLetter: UIImage { .load(named: "ic_letter") }
    static var icMenu: UIImage { .load(named: "ic_menu") }
    static var icMindsetBI: UIImage { .load(named: "ic_mindset_BI") }
    static var icMindsetFill: UIImage { .load(named: "ic_mindset_fill") }
    static var icMindset: UIImage { .load(named: "ic_mindset") }
    static var icPlus: UIImage { .load(named: "ic_plus") }
    static var icRecordSortFill: UIImage { .load(named: "ic_record_sort_fill") }
    static var icRecordSort: UIImage { .load(named: "ic_record_sort") }
    static var icRecordedWillFill: UIImage { .load(named: "ic_recorded_will_fill") }
    static var icRecordedWill: UIImage { .load(named: "ic_recorded_will") }
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }
    
    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
