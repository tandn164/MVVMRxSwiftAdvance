//
//  UIViewController+.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 22/04/2023.
//

import UIKit

extension UIViewController {
    func dismiss() {
        dismiss(animated: false, completion: nil)
    }
    
    func presentVC(_ viewControllerToPresent: UIViewController) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        self.present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func presentOverVC(_ viewControllerToPresent: UIViewController) {
        viewControllerToPresent.modalPresentationStyle = .overCurrentContext
        self.present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: Localizable.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.ok, style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDialog(message: String) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.ok, style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String, titleButton: String, onDone: (() -> ())? = nil) {
        let alert = UIAlertController(title: Localizable.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: titleButton, style: .default, handler: { _ in
            onDone?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addNotifyBecomeActive(_ aSelector: Selector) {
        NotificationCenter.default.addObserver(self, selector: aSelector, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func removeNotifyBecomeActive() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func addNotifyEnterBackground(_ aSelector: Selector) {
        NotificationCenter.default.addObserver(self, selector: aSelector, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    func removeNotifyEnterBackground() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    func addNotifyWillResignActive(_ aSelector: Selector) {
        NotificationCenter.default.addObserver(self, selector: aSelector, name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    func topMostViewController() -> UIViewController? {
        if self.presentedViewController == nil {
            if self is UIAlertController {
                return self.presentingViewController
            }
            return self
        }
        if let navigationController = self.navigationController {
            return navigationController.visibleViewController?.topMostViewController() ?? navigationController
        }
        if let tabBarController = self.tabBarController {
            if let selected = tabBarController.selectedViewController {
                return selected.topMostViewController()
            }
            return tabBarController.topMostViewController()
        }
        return self.presentedViewController?.topMostViewController()
    }
}
