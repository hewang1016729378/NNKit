//
//  UILabel+Extensions.swift
//  NNHost
//
//  Created by ly on 2021/12/24.
//

import Foundation
import UIKit

public extension UILabel {
    /// 通用pingFangSc文字Label (textColor不传默认为B2B2B2)
    public func settingLabel(pingFangSCSize size: CGFloat, textColor: UIColor?) {
        font = UIFont.pingFangSCRegular(size)
        if let textColor = textColor {
            self.textColor = textColor
        } else {
            self.textColor = "#B2B2B2".color()
        }
    }

    public func setup(_ font: UIFont, _ textColor: UIColor, _ textAlignment: NSTextAlignment = .left) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}
