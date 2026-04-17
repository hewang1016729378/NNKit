//
//  GradientView.swift
//  NNIM
//
//  Created by ljf on 2023/3/16.
//

import Foundation

enum GradientMode {
    case leftToRight
    case topToBottom
}

// 渐变view
class GradientView: UIView {

    lazy var gradientLayer: CAGradientLayer = {
        let tmp = CAGradientLayer()
        tmp.locations = [0, 1]
        tmp.startPoint = CGPoint(x: 0.0, y: 0.5)
        tmp.endPoint = CGPoint(x: 1.0, y: 0.5)
        return tmp
    }()

    var gradientMode: GradientMode = .leftToRight {
        didSet {
            if gradientMode != oldValue {
                switch gradientMode {
                case .leftToRight:
                    gradientLayer.locations = [0, 1]
                    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                case .topToBottom:
                    gradientLayer.locations = [0, 1]
                    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
                    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
                }
            }
        }
    }
    
    override init(frame: CGRect) {

        super.init(frame: frame)

        layer.addSublayer(gradientLayer)

    }

    required init?(coder: NSCoder) {

        super.init(coder: coder)

        layer.addSublayer(gradientLayer)

    }

    override func layoutSubviews() {

        super.layoutSubviews()

        gradientLayer.frame = self.bounds

    }
}

// 渐变button
class GradientButton: UIButton {
    
    lazy var gradientLayer: CAGradientLayer = {
        let tmp = CAGradientLayer()
        tmp.locations = [0, 1]
        tmp.startPoint = CGPoint(x: 0.0, y: 0.5)
        tmp.endPoint = CGPoint(x: 1.0, y: 0.5)
        return tmp
    }()

    var gradientMode: GradientMode = .leftToRight {
        didSet {
            if gradientMode != oldValue {
                switch gradientMode {
                case .leftToRight:
                    gradientLayer.locations = [0, 1]
                    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                case .topToBottom:
                    gradientLayer.locations = [0, 1]
                    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
                    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
                }
            }
        }
    }

    override func layoutSubviews() {

        super.layoutSubviews()

        layer.insertSublayer(gradientLayer, at: 0)
        
        gradientLayer.frame = self.bounds

    }
}
