//
//  SpinningView.swift
//  Task 14. Animations
//
//  Created by Arseniy Matus on 15.12.2022.
//

import UIKit

class SpinningView: UIView {
    private let startOffset: Double = 0.05

    let circleLayer = CAShapeLayer()

    var rotationAnimation: CAAnimation {
        let radius = Double(bounds.width) / 2.0
        let perimeter = 2 * Double.pi * radius
        let theta = perimeter * startOffset / (2 * radius)
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = theta * 2 + Double.pi * 2
        animation.duration = 3.5
        animation.repeatCount = .infinity
        return animation
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        circleLayer.lineWidth = 10.0
        circleLayer.fillColor = nil

        circleLayer.strokeColor = UIColor.systemRed.cgColor
        circleLayer.lineCap = .round
        layer.addSublayer(circleLayer)
        updateAnimation()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth / 2

        circleLayer.position = center

        circleLayer.path = UIBezierPath(arcCenter: CGPoint.zero,
                                        radius: radius,
                                        startAngle: -.pi / 2,
                                        endAngle: 3 * .pi / 2,
                                        clockwise: true).cgPath
        setup()
    }

    private func updateAnimation() {
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.beginTime = 0.5
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1.0 - startOffset
        strokeStartAnimation.duration = 3.0
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = startOffset
        strokeEndAnimation.toValue = 1.0
        strokeEndAnimation.duration = 2.0
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 3.5
        strokeAnimationGroup.repeatCount = .infinity
        strokeAnimationGroup.fillMode = .forwards
        strokeAnimationGroup.isRemovedOnCompletion = false
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]

        circleLayer.add(strokeAnimationGroup, forKey: nil)
        circleLayer.add(rotationAnimation, forKey: "rotation")
    }
}
