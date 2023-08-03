//
//  LoadingCircleView.swift
//  MVVM
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//

import UIKit

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 3) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat.pi * 2
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}

class LoadingCircleView: UIView {
    let spinningCircle = CAShapeLayer()
    var foregroundColor = UIColor.red
    
    var lineWidth: CGFloat = 5.0
    
    private var isAnimating = false {
        didSet {
            if isAnimating {
                self.isHidden = false
                self.rotate360Degrees(duration: 1.0)
            } else {
                self.isHidden = true
                self.layer.removeAllAnimations()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.isHidden = true
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        let width = bounds.width
        let height = bounds.height
        let radius = (min(width, height) - lineWidth) / 2.0
        
        var currentPoint = CGPoint(x: width / 2.0 + radius, y: height / 2.0)
        var priorAngle = CGFloat(360)
        
        for angle in stride(from: CGFloat(360), through: 0, by: -2) {
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            
            path.move(to: currentPoint)
            currentPoint = CGPoint(x: width / 2.0 + cos(angle * .pi / 180.0) * radius, y: height / 2.0 + sin(angle * .pi / 180.0) * radius)
            path.addArc(withCenter: CGPoint(x: width / 2.0, y: height / 2.0), radius: radius, startAngle: priorAngle * .pi / 180.0 , endAngle: angle * .pi / 180.0, clockwise: false)
            priorAngle = angle
            
            foregroundColor.withAlphaComponent(angle/360.0).setStroke()
            path.stroke()
        }
    }
    
    func play() {
        isAnimating = true
    }
    
    func stop() {
        isAnimating = false
    }
}
