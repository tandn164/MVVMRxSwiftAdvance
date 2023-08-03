//
//  ViewManager.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 22/04/2023.
//

import UIKit

class ViewManager {
    static let shared = ViewManager()
    var selectedIndex: Int?
    
    func setTabbarIsRootView() {
        let mainViewController = MainViewController()
        let oldRootView = ApplicationUtil.mainView
        
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            if #available(iOS 15.0, *) {
                scene?.keyWindow?.rootViewController = mainViewController
            } else {
                scene?.windows.first(where: { $0.isKeyWindow })?.rootViewController = mainViewController
            }
        } else {
            UIApplication.shared.keyWindow?.rootViewController = mainViewController
        }
        DispatchQueue.main.async {
            oldRootView?.dismiss()
        }
    }
}
