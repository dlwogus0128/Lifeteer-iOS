//
//  applyShadow.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/01/19.
//

import UIKit

/**
 
 - Description:
 
 View의 Layer 계층(CALayer)에 shadow를 간편하게 입힐 수 있는 메서드입니다.
 피그마에 나와있는 shadow 속성 값을 그대로 기입하면 됩니다!
 
 */

public extension CALayer {
    func applyShadow(
        color: UIColor = .black.withAlphaComponent(0.7),
        alpha: Float = 0.25,
        x: CGFloat = 0,
        y: CGFloat = 4,
        blur: CGFloat = 24,
        spread: CGFloat = 0) {
            
            masksToBounds = false
            shadowColor = color.cgColor
            shadowOpacity = alpha
            shadowOffset = CGSize(width: x, height: y)
            shadowRadius = blur / 2.0
            if spread == 0 {
                shadowPath = nil
            } else {
                let dx = -spread
                let rect = bounds.insetBy(dx: dx, dy: dx)
                shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
}
