//
//  UIColor+Dark.swift
//  NNHost
//
//  Created by ly on 2024/8/21.
//

import Foundation
import UIKit

extension UIColor {
    
    /// 随系统暗黑模式变化，字体色
    /// - Parameters:
    ///   - lightColor: 浅色模式的下颜色值，不传默认黑色
    ///   - darkColor: 深色模式的下颜色值，不传默认白色
    /// - Returns: color
    public static func systemThemeTextColor(_ defaultColor: UIColor? = nil, darkColor:UIColor? = nil) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    if let darkColor = darkColor {
                        return darkColor
                    }
                    return .white
                } else {
                    if let color = defaultColor {
                        return color
                    }
                    return .black
                }
            }
        }
        return .white
    }
    
    /// 随系统暗黑模式变化，背景色
    /// - Parameters:
    ///   - defaultColor: 浅色模式的下颜色值，不传默认白色
    ///   - darkColor: 浅色模式的下颜色值，不传默认黑色
    /// - Returns: color
    public static func systemThemeBackgroudColor(_ defaultColor: UIColor? = nil, darkColor: UIColor? = nil) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    if let darkColor = darkColor {
                        return darkColor
                    }
                    return.black
                } else {
                    if let color = defaultColor {
                        return color
                    }
                    return .white
                }
            }
        }
        return .white
    }
}
