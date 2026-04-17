//
//  AnimationTools.swift
//  NNHost
//
//  Created by ly on 2021/12/21.
//

import Foundation
import UIKit

public struct AnimationTools {
    public static func startRotateWithLayer(_ layer: CALayer) {
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Double.pi*2.0
        rotationAnimation.duration = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 10000
        rotationAnimation.isRemovedOnCompletion = false
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    public static func textSharkSpringAnimation(layer: CALayer) {
        let spring = CASpringAnimation(keyPath: "position.x")
        spring.damping = 0
        spring.stiffness = 1000
        spring.mass = -5
        spring.initialVelocity = 40
        spring.fromValue = layer.position.x + 2
        spring.toValue = layer.position.x - 2
        spring.duration = 0.3
        layer.add(spring, forKey: spring.keyPath)
    }
    /*
     *
     */
    public static func startSpringAnimation(layer: CALayer) {
        let spring = CASpringAnimation(keyPath: "position.x")
        spring.damping = 0
        spring.stiffness = 1000
        spring.mass = -5
        spring.initialVelocity = 40
        spring.fromValue = layer.position.x + 2
        spring.toValue = layer.position.x - 2
        spring.duration = 0.3
        layer.add(spring, forKey: spring.keyPath)
    }
}
