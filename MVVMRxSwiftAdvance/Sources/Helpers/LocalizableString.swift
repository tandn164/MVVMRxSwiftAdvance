//
//  Localizable.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 22/04/2023.
//

import UIKit

protocol LocalizableString {
    var localized: String { get }
}
extension String: LocalizableString {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

protocol XIBLocalizable {
    var localizable: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var localizable: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}
extension UIButton: XIBLocalizable {
    @IBInspectable var localizable: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
   }
}

extension UITextField: XIBLocalizable {
    @IBInspectable var localizable: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }
}

func localizedString(forKey key: String) -> String {
    var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)

    if result == key {
        result = Bundle.main.localizedString(forKey: key, value: nil, table: "Default")
    }

    return result
}
