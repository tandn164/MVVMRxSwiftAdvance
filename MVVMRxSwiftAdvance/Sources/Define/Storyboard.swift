//
//  Storyboard.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 22/04/2023.
//

import UIKit

enum Storyboard: String {
    
    case top = "Top"
    case setting = "Setting"
        
    var name: String {
        return rawValue
    }
    
    func loadViewController<T: UIViewController>(_ vcClass: T.Type, _ vcIdentifier: String? = nil) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vcID = vcIdentifier ?? "\(vcClass)"
        if !vcID.isEmpty {
            if let viewController = storyboard.instantiateViewController(withIdentifier: vcID) as? T {
                return viewController
            }
        } else {
            if let viewController = storyboard.instantiateInitialViewController() as? T {
                return viewController
            }
        }
        return T()
    }
}
