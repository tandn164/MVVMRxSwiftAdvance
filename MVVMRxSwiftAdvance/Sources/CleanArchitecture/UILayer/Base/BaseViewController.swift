//
//  BaseViewController.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 22/04/2023.
//

import UIKit

class BaseViewController: UIViewController {
    override var hidesBottomBarWhenPushed: Bool {
        get {
            return (navigationController?.topViewController == self) && (super.hidesBottomBarWhenPushed)
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }
    private weak var rootViewController: UIViewController?
    var viewType: ViewType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootViewController = navigationController?.viewControllers.first
        notiDidloadEvent(self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let viewType = viewType {
            navigationController?.isNavigationBarHidden = viewType.navBarHidden
        }
        if (navigationController?.viewControllers.count ?? 0 > 1) && (rootViewController != self) {
            addBackBarButton()
        } else {
            navigationItem.leftBarButtonItem = nil
        }
        notiWillAppearEvent(self.view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let viewType = viewType {
            navigationController?.isNavigationBarHidden = !(viewType.navBarHidden)
        }
        notiWillDisappearEvent(self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        notiDidAppearEvent(self.view)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notiDidDisappearEvent(self.view)
    }
    
    func addBackBarButton() {
        let newBackButton = UIBarButtonItem(image: UIImage(named: "chevron_left"),
                                            style: UIBarButtonItem.Style.plain,
                                            target: self,
                                            action: #selector(onBackAction))
        navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func onBackAction() {
        goBack()
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension BaseViewController {
    private func notiDidloadEvent(_ view: UIView?) {
        if let view = view as? BaseView {
            view.viewDidLoad()
        }
        view?.subviews.forEach({ subview in
            self.notiDidloadEvent(subview)
        })
    }
    
    private func notiWillAppearEvent(_ view: UIView?) {
        if let view = view as? BaseView {
            view.viewWillAppear()
        }
        view?.subviews.forEach({ subview in
            self.notiWillAppearEvent(subview)
        })
    }
    
    private func notiWillDisappearEvent(_ view: UIView?) {
        if let view = view as? BaseView {
            view.viewWillDisappear()
        }
        view?.subviews.forEach({ subview in
            self.notiWillDisappearEvent(subview)
        })
    }
    
    private func notiDidAppearEvent(_ view: UIView?) {
        if let view = view as? BaseView {
            view.viewDidAppear()
        }
        view?.subviews.forEach({ subview in
            self.notiDidAppearEvent(subview)
        })
    }
    
    private func notiDidDisappearEvent(_ view: UIView?) {
        if let view = view as? BaseView {
            view.viewDidDisappear()
        }
        view?.subviews.forEach({ subview in
            self.notiDidDisappearEvent(subview)
        })
    }
}
