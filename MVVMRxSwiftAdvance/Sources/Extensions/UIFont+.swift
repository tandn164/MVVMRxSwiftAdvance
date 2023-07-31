//
//  UIFont+.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 22/04/2023.
//

import UIKit

extension UIFont {
    static func hiraginoW3(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HiraKakuProN-W3", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func hiraginoW6(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HiraKakuProN-W6", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    static func hiraginoW3Fit(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HiraKakuProN-W3", size: calculateFontSize(size)) ?? .systemFont(ofSize: self.calculateFontSize(size))
    }
    
    static func hiraginoW6Fit(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HiraKakuProN-W6", size: calculateFontSize(size)) ?? .boldSystemFont(ofSize: self.calculateFontSize(size))
    }
    
    static func calculateFontSize(_ fontSize: CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0:
            return fontSize * 0.7
        case 568.0:
            return fontSize * 0.8
        case 667.0:
            return fontSize * 0.9
        default:
            return fontSize
        }
    }
}
