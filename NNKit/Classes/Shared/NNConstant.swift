//
//  Constant.swift
//  NNAcc
//
//  Created by ly on 2021/11/29.
//

import Foundation
import UIKit

public let kScreenWidth: CGFloat = UIScreen.main.bounds.width
public let kScreenHeight: CGFloat = UIScreen.main.bounds.height
@available(iOS 11.0, *)
public let kBottomSafeAreaHeight: CGFloat = UIApplication.shared.windows[0].safeAreaInsets.bottom
public var NNKitConfirmTitleColor = UIColor.white
public var NNKitConfirmBackColor = "#FF9B27".color()
public var NNKitThemeColor = "#FF9B27".color()


public enum TitleBarUIConstant {
    // OneLogin
    static let kTopBarH = 50.0
    static let kMenuBarH = 50.0
}

public struct UIConstant {
    /// 适配刘海屏
    public static func statusBarHeight() -> CGFloat {
        var statusBarHeight = 20.0
        if #available(iOS 13.0, *) {
            if let windowScene: UIWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let statusBarManager = windowScene.statusBarManager {
                statusBarHeight = statusBarManager.statusBarFrame.size.height
            }
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        }
        return statusBarHeight
    }

    public static func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }

    public static func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }

    public static func onePixel() -> CGFloat {
        return 1.0 / UIScreen.main.scale
    }

    /// 判断该机型是否有home按钮
    public static func isNoHomeButtonStyleScreen() -> Bool {
        if #available(iOS 11.0, *) {
            if let mainWindow = UIApplication.shared.delegate?.window, mainWindow?.safeAreaInsets.bottom ?? 0.0 > 0.0 {
                return true
            }
        }
        return false
    }

    public static func getTabBarHeight() -> CGFloat {
        if isNoHomeButtonStyleScreen() {
            return 83.0
        } else {
            return 49.0
        }
    }

    public static func getBottomHeight() -> CGFloat {
        if isNoHomeButtonStyleScreen() {
            return 34.0
        } else {
            return 0.0
        }
    }

    public static func aspect(width: Double) -> Double {
        let uiScreenWidth = 375.0
        let scale = screenWidth() / uiScreenWidth
        return width * scale
    }

    public static func isSmallDevice() -> Bool {
        let isIphone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
        if isIphone, screenHeight() <= 667.0 {
            return true
        }
        return false
    }
}
