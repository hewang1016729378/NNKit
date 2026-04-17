//
//  InsetLabel.swift
//  NNHost
//
//  Created by Leigod on 2022/3/11.
//

import UIKit

public class InsetLabel: UILabel {
    public var textInsets = UIEdgeInsets.zero
    public func setBorder(radius: CGFloat, width: CGFloat) {
        layer.cornerRadius = radius
        layer.borderWidth = width
        layer.borderColor = textColor.cgColor
    }

    /// 扩展一个padding方法
    public func padding(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        frame = CGRect(x: 0, y: 0, width: frame.width + left + right, height: frame.height + top + bottom)
        textInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    public override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += textInsets.top + textInsets.bottom
        contentSize.width += textInsets.left + textInsets.right
        return contentSize
    }
}
