//
// Created by DengXiaoBai on 2019-07-22.
// Copyright (c) 2019 mrball. All rights reserved.
//

import UIKit

// MARK: - Factory

public extension UIView {
    // MARK: UIView

    public class func lineView(_ backgroundColor: UIColor = .lineColor) -> UIView {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        return view
    }

    // MARK: UITextView

    class func createTextView(textColor: UIColor,
                              backgroundColor: UIColor,
                              font: UIFont,
                              text: String = "",
                              delegate: UITextViewDelegate?) -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = textColor
        textView.backgroundColor = backgroundColor
        textView.font = font
        textView.text = text
        textView.delegate = delegate

        textView.returnKeyType = .default
        textView.keyboardType = .default
        textView.isScrollEnabled = true
        textView.autoresizingMask = .flexibleHeight
        return textView
    }

    // MARK: UITextField

    class func createTextField(borderStyle: UITextField.BorderStyle = .none,
                               placeholder: String = "",
                               font: UIFont,
                               textAlignment: NSTextAlignment = .left,
                               isSecureTextEntry: Bool = false,
                               delegate: UITextFieldDelegate?) -> UITextField {
        let textField: UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = borderStyle
        textField.placeholder = placeholder
        textField.font = font
        textField.textAlignment = textAlignment
        textField.isSecureTextEntry = isSecureTextEntry
        textField.delegate = delegate
        return textField
    }

    // MARK: UIImageView

    class func createImageView() -> UIImageView {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    class func createImageView(image: UIImage?) -> UIImageView {
        let imageView: UIImageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    // MARK: UIButton

    class func createButton(target: AnyObject?, action: Selector) -> NNBigButton {
        let button: NNBigButton = NNBigButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }

    // MARK: - UILabel

    class func createLabel(text: String, textAlignment: NSTextAlignment = .left, font: UIFont, textColor: UIColor = UIColor.black) -> UILabel {
        let label: UILabel = UILabel()
        label.text = text
        label.textAlignment = textAlignment
        label.font = font
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    // MARK: - UIVisualEffectView

    class func createBlurView(style: UIBlurEffect.Style) -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        effectView.translatesAutoresizingMaskIntoConstraints = false
        return effectView
    }

    // MARK: - UIScrollView

    class func createScrollView(delegate: UIScrollViewDelegate?) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = delegate
        scrollView.backgroundColor = UIColor.clear
        /// 防止iOS11自动调整contentInset
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }
}

// MARK: add corners specified corner

public extension UIView {
    /// 背景渐变色
    @discardableResult
    func gradientLayer(left leftColor: UIColor, right rightColor: UIColor, leftToRight: Bool = false) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.frame = bounds
        if leftToRight {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        }
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    /// 开启置灰效果
    func enableGrayscale() {
        let grayscaleOverlay = CALayer()
        grayscaleOverlay.backgroundColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        grayscaleOverlay.frame = self.bounds
        self.layer.addSublayer(grayscaleOverlay)
    }
}

// MARK: reuse id

public extension UIView {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
}

public extension UIView {
    var inScreen: Bool {
        guard superview != nil, window != nil else {
            return false
        }
        let rect = convert(frame, from: nil)
        guard !rect.isEmpty, !rect.isNull, rect != .zero else {
            return false
        }

        let interRect = rect.intersection(UIScreen.main.bounds)
        guard !interRect.isEmpty, !interRect.isNull else {
            return false
        }
        return true
    }
}

// MARK: - 阴影

public extension UIView {
    func addShadow(offSet: CGSize = CGSize(width: 0, height: -3),
                   radius: CGFloat = 3,
                   opacity: Float = 0.8,
                   color: UIColor) {
        clipsToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    func addCellShadow(offSet: CGSize = CGSize(width: 0, height: 5),
                       opacity: Float = 1, shadowRadius: CGFloat = 6) {
        layer.shadowColor = UIColor(red: 0.53, green: 0.53, blue: 0.56, alpha: 0.1).cgColor

        layer.shadowOffset = offSet
        layer.shadowOpacity = opacity
        layer.shadowRadius = shadowRadius
        clipsToBounds = false
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    func removeCornerAndShadow() {
        layer.cornerRadius = 0
        layer.shadowRadius = 0
        layer.shadowPath = nil
        layer.shadowOffset = .zero
        layer.shadowColor = nil
    }
}

public extension UIView {
    /// SwifterSwift: Add array of subviews to view.
    ///
    /// - Parameter subviews: array of subviews to add to self.
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}

public extension UIView {
    // 添加虚线边框
    func drawBoardDottedLine(width: CGFloat, lenth: CGFloat, space: CGFloat, cornerRadius: CGFloat, color: UIColor) {
        layer.cornerRadius = cornerRadius
        let borderLayer = CAShapeLayer()
        borderLayer.bounds = bounds

        borderLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: cornerRadius).cgPath
        borderLayer.lineWidth = width / UIScreen.main.scale

        // 虚线边框---小边框的长度

        borderLayer.lineDashPattern = [lenth, space] as? [NSNumber] // 前边是虚线的长度，后边是虚线之间空隙的长度
        borderLayer.lineDashPhase = 0.1
        // 实线边框

        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color.cgColor
        layer.addSublayer(borderLayer)
    }
}

public extension UIView {
    fileprivate func showToast(_ text: String, _ view: UIView, _ isBlackStyle: Bool = false) {
        view.hideAllToasts()
        let style = TUICSToastManager.sharedStyle()
        style?.cornerRadius = 6.0
        style?.horizontalPadding = 15
        style?.messageFont = UIFont.systemFont(ofSize: 14)
        style?.shadowColor = .black
        style?.shadowOffset = CGSize(width: 0, height: 10.0)
        style?.shadowOpacity = 0.15
        style?.titleFont = .pingfang(14.0)
        if isBlackStyle {
            style?.titleColor = .white
            style?.messageColor = .white
            style?.backgroundColor = .black
        } else {
            style?.titleColor = k_333333
        }
        view.makeToast(text, duration: 1.5, position: TUICSToastPositionBottom, style: style)
    }

    fileprivate func showCennterToast(_ text: String, _ view: UIView,  _ isBlackStyle: Bool = false) {
        view.hideAllToasts()
        let style = TUICSToastManager.sharedStyle()
        style?.cornerRadius = 6.0
        style?.horizontalPadding = 15
        style?.messageFont = UIFont.systemFont(ofSize: 14)
        style?.shadowColor = .black
        style?.shadowOffset = CGSize(width: 0, height: 10.0)
        style?.shadowOpacity = 0.15
        style?.titleFont = .pingfang(14.0)
        if isBlackStyle {
            style?.titleColor = .white
            style?.messageColor = .white
            style?.backgroundColor = .black
        } else {
            style?.titleColor = k_333333
        }
        style?.messageFont = UIFont.systemFont(ofSize: 14)
        view.makeToast(text, duration: 1.5, position: TUICSToastPositionCenter, style: style)
    }

    func showToast(_ text: String, _ isBlackStyle: Bool = false) {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.keyWindow {
                self.showToast(text, keyWindow, isBlackStyle)
            }
        }
    }

    func showCennterToast(_ text: String, _ isBlackStyle: Bool = false) {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.keyWindow {
                self.showCennterToast(text, keyWindow, isBlackStyle)
            }
        }
    }
}

