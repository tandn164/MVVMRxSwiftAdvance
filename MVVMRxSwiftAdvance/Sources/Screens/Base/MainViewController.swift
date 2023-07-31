//
//  MainViewController.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 10/07/2023.
//

import UIKit

enum TabType {
    case top
    
    var name: String {
        switch self {
        case .top:
            return Localizable.tabTop
        }
    }
    
    var iconOn: UIImage? {
        switch self {
        case .top:
            return nil
        }
    }
    
    var iconOff: UIImage? {
        switch self {
        case .top:
            return nil
        }
    }
    
    var viewController: UIViewController {
        let vc: UIViewController
        
        switch self {
        case .top:
            vc = Storyboard.top.loadViewController(TopViewController.self)
        }
        
        return vc
    }
}

final class MainViewController: UITabBarController {
    private let mainTabBars: [TabType] = [.top]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = UIColor.white
            
            let activeAtt = [
                NSAttributedString.Key.font : UIFont.hiraginoW6(10),
                NSAttributedString.Key.foregroundColor: UIColor.blue,
                NSAttributedString.Key.paragraphStyle: NSParagraphStyle.default
            ]
            let inActiveAtt = [
                NSAttributedString.Key.font : UIFont.hiraginoW6(9),
                NSAttributedString.Key.foregroundColor : UIColor.gray,
                NSAttributedString.Key.paragraphStyle: NSParagraphStyle.default
            ]
            
            let tabItemAppearance = UITabBarItemAppearance()
            tabItemAppearance.normal.titleTextAttributes = inActiveAtt as [NSAttributedString.Key : Any]
            tabItemAppearance.selected.titleTextAttributes = activeAtt as [NSAttributedString.Key : Any]
            
            tabBarAppearance.stackedLayoutAppearance = tabItemAppearance

            self.tabBar.standardAppearance = tabBarAppearance;
            if #available(iOS 15.0, *) {
                self.tabBar.scrollEdgeAppearance = tabBarAppearance;
            }
        } else {
            let appearance = UITabBarItem.appearance()
            appearance.setTitleTextAttributes([.foregroundColor: UIColor.gray],
                                              for: .normal)
            appearance.setTitleTextAttributes([.foregroundColor: UIColor.blue],
                                              for: .selected)
            appearance.setTitleTextAttributes([.font: UIFont.hiraginoW6(10)],
                                              for: .normal)
            
            tabBar.barTintColor = .white
            tabBar.isTranslucent = false
        }
        
        let viewControllers = mainTabBars.map { tab -> UIViewController in
            let tabBarItem = UITabBarItem(title: tab.name,
                                          image: tab.iconOff?.withRenderingMode(.alwaysOriginal),
                                          selectedImage: tab.iconOn?.withRenderingMode(.alwaysOriginal))
            
            let viewController = BaseNavigationViewController(rootViewController: tab.viewController)
            viewController.tabBarItem = tabBarItem
            return viewController
        }
        
        self.setViewControllers(viewControllers,
                                animated: false)
    }
}
