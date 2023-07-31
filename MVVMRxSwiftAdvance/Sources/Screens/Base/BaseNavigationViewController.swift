//
//  BaseNavigationViewController.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 10/07/2023.
//

import UIKit

final class BaseNavigationViewController: UINavigationController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = UIColor.black
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.setBackIndicatorImage( UIImage(named: "chevron_left"), transitionMaskImage: UIImage(named: "chevron_left"))
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
        } else {
            navigationBar.backIndicatorImage = UIImage(named: "chevron_left")
            navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "chevron_left")
            navigationBar.barTintColor = .white
        }
        self.delegate = self
    }
}

extension BaseNavigationViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                          style: .plain,
                                                                          target: nil,
                                                                          action: nil)
    }
}
