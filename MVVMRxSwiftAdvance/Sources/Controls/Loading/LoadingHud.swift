//
//  LoadingHud.swift
//  MVVM
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//

import UIKit

class LoadingView: UIView {
    
    lazy var animationView: LoadingCircleView = {
        let animationView = LoadingCircleView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animationView)
        animationView.play()
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(white: 1, alpha: 0.9)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        animationView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

var loadingView: LoadingView = {
    let view = LoadingView(frame: UIScreen.main.bounds)
    return view
}()

struct LoadingHud {
    static func show() {
        UIApplication.shared.keyWindow?.addSubview(loadingView)
    }
    
    static func hide() {
        loadingView.animationView.stop()
        loadingView.removeFromSuperview()
    }
}
