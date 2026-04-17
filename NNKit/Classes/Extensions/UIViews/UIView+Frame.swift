//
//  UIView+Frame.swift
//  NNHost
//
//  Created by Leigod on 2022/3/17.
//

import Foundation
import UIKit

public extension UIView {
    var left: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return frame.origin.x
        }
    }

    var right: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue - width
            self.frame = frame
        }
        get {
            return left + width
        }
    }

    var width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return frame.size.width
        }
    }

    var height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return frame.size.height
        }
    }

    var top: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return frame.origin.y
        }
    }

    var bottom: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - height
            self.frame = frame
        }
        get {
            return top + height
        }
    }

    var centerY: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - self.frame.size.height * 0.5
            self.frame = frame
        }
        get {
            return frame.origin.y + frame.size.height * 0.5
        }
    }

    var centerX: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue - self.frame.size.width * 0.5
            self.frame = frame
        }
        get {
            return frame.origin.x + frame.size.width * 0.5
        }
    }

    var size: CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return frame.size
        }
    }
}

// MARK: - 设置四个大小不同的圆角

/// 圆角半径大小
public struct CornerRadii {
    var topLeft: CGFloat = 0 /// 左上
    var topRight: CGFloat = 0 /// 右上
    var bottomLeft: CGFloat = 0 /// 左下
    var bottomRight: CGFloat = 0 /// 右下
    public static var zero: CornerRadii {
        CornerRadii()
    }

    public init(radius: CGFloat = 0, corner: UIRectCorner = .allCorners) {
        if corner == .allCorners {
            topLeft = radius
            topRight = radius
            bottomLeft = radius
            bottomRight = radius
            return
        }

        let mask = 0b0001 // 四位二进制
        topLeft = CGFloat(Int(corner.rawValue) & mask) * radius
        topRight = CGFloat(Int(corner.rawValue >> 1) & mask) * radius
        bottomLeft = CGFloat(Int(corner.rawValue >> 2) & mask) * radius
        bottomRight = CGFloat(Int(corner.rawValue >> 3) & mask) * radius
    }

    public init(topLeft: CGFloat = 0,
                topRight: CGFloat = 0,
                bottomLeft: CGFloat = 0,
                bottomRight: CGFloat = 0) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
}

public extension UIView {
    /// 设置四个不同的圆角
    /// - Parameters:
    ///   - radii: 圆角半径参数
    func cornerRadii(_ radii: CornerRadii) {
        addMask(rect: bounds, cornerRadii: radii)
    }

    /// 添加遮罩
    /// - Parameters:
    ///   - bounds: 遮罩区域
    ///   - cornerRadii: 圆角半径
    func addMask(rect: CGRect, path: CGPath? = nil, cornerRadii: CornerRadii = .zero) {
        var maskPath: CGPath!
        if path != nil {
            maskPath = path
        } else {
            maskPath = createPathWithRoundedRect(rect: rect, cornerRadii: cornerRadii)
        }

        let shapLayer = CAShapeLayer()
        shapLayer.frame = bounds
        shapLayer.path = maskPath
        layer.mask = shapLayer
    }

    /// 切圆角函数绘制线条
    func createPathWithRoundedRect(rect: CGRect, cornerRadii: CornerRadii) -> CGPath {
        let minX = rect.minX
        let minY = rect.minY
        let maxX = rect.maxX
        let maxY = rect.maxY

        // 获取四个圆心
        let topLeftCenterX = minX + cornerRadii.topLeft
        let topLeftCenterY = minY + cornerRadii.topLeft

        let topRightCenterX = maxX - cornerRadii.topRight
        let topRightCenterY = minY + cornerRadii.topRight

        let bottomLeftCenterX = minX + cornerRadii.bottomLeft
        let bottomLeftCenterY = maxY - cornerRadii.bottomLeft

        let bottomRightCenterX = maxX - cornerRadii.bottomRight
        let bottomRightCenterY = maxY - cornerRadii.bottomRight

        // 虽然顺时针参数是YES，在iOS中的UIView中，这里实际是逆时针
        let path: CGMutablePath = CGMutablePath()
        // 顶 左
        path.addArc(
            center: CGPoint(x: topLeftCenterX, y: topLeftCenterY),
            radius: cornerRadii.topLeft,
            startAngle: CGFloat.pi,
            endAngle: CGFloat.pi * 3 / 2,
            clockwise: false
        )
        // 顶 右
        path.addArc(
            center: CGPoint(x: topRightCenterX, y: topRightCenterY),
            radius: cornerRadii.topRight,
            startAngle: CGFloat.pi * 3 / 2,
            endAngle: 0, clockwise: false
        )
        // 底 右
        path.addArc(
            center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY),
            radius: cornerRadii.bottomRight,
            startAngle: 0,
            endAngle: CGFloat.pi / 2,
            clockwise: false
        )
        // 底 左
        path.addArc(
            center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY),
            radius: cornerRadii.bottomLeft, startAngle: CGFloat.pi / 2,
            endAngle: CGFloat.pi,
            clockwise: false
        )
        path.closeSubpath()

        return path
    }
    
    public func setupCornerPath(_ conrer: UIRectCorner, _ radius: CGFloat) {
        
        let conrer = conrer
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrer, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

}
