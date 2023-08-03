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
    
    var viewType: ViewType {
        switch self {
        case .top:
            return .top
        case .setting:
            return .setting
        }
    }
    
    func loadViewController<T: BaseViewController>(_ vcClass: T.Type, _ vcIdentifier: String? = nil) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vcID = vcIdentifier ?? "\(vcClass)"
        if !vcID.isEmpty {
            if let viewController = storyboard.instantiateViewController(withIdentifier: vcID) as? T {
                viewController.viewType = viewType
                return viewController
            }
        } else {
            if let viewController = storyboard.instantiateInitialViewController() as? T {
                viewController.viewType = viewType
                return viewController
            }
        }
        let viewController = T()
        viewController.viewType = viewType
        return viewController
    }
}
