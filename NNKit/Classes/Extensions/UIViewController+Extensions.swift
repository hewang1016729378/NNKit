//
//  UIViewController+Extensions.swift
//

import Foundation
//import NotificationBannerSwift
import UIKit

public protocol ToastCapable: AnyObject {
    func showErrorToast(message: String)
}

/*
 * 顶部消息框，使用前需要遵循ToastCapable协议
 */
extension ToastCapable where Self: UIViewController {
    func showErrorToast(message: String) {
//        let banner = StatusBarNotificationBanner(title: message, style: .danger)
//        banner.show()
    }
}

public extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
