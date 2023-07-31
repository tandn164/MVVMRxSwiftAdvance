//
//  EnumDefine.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 22/04/2023.
//

import Foundation

enum ViewType {
    case top
    case setting
    
    var navBarHidden: Bool {
        switch self {
        case .top:
            return false
        case .setting:
            return true
        }
    }
}

enum ThemeType {
    case dark
    case light
}
