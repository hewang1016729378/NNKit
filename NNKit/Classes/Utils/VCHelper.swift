//
//  VCHelper.swift
//  NNHost
//
//  Created by Leigod on 2022/3/28.
//

import UIKit

// MARK: - 获取根控制器、

// 获取rootVC 根据window
public func getRootVC() -> (UIViewController?) {
    var window = UIApplication.shared.keyWindow
    // 是否为当前显示的window
    if window?.windowLevel != UIWindow.Level.normal {
        let windows = UIApplication.shared.windows
        for windowTemp in windows {
            if windowTemp.windowLevel == UIWindow.Level.normal {
                window = windowTemp
                break
            }
        }
    }
    return window?.rootViewController
}

// MARK: - 查找顶层控制器、

// 获取顶层控制器 根据window
public func getTopVC() -> (UIViewController?) {
    var window = UIApplication.shared.keyWindow
    // 是否为当前显示的window
    if window?.windowLevel != UIWindow.Level.normal {
        let windows = UIApplication.shared.windows
        for windowTemp in windows {
            if windowTemp.windowLevel == UIWindow.Level.normal {
                window = windowTemp
                break
            }
        }
    }
    let vc = window?.rootViewController
    return getTopVC(withCurrentVC: vc)
}

/// 根据控制器获取 顶层控制器
public func getTopVC(withCurrentVC VC: UIViewController?) -> UIViewController? {
    if VC == nil {
        print("🌶： 找不到顶层控制器")
        return nil
    }
    if let presentVC = VC?.presentedViewController {
        // modal出来的 控制器
        return getTopVC(withCurrentVC: presentVC)
    } else if let tabVC = VC as? UITabBarController {
        // tabBar 的跟控制器
        if let selectVC = tabVC.selectedViewController {
            return getTopVC(withCurrentVC: selectVC)
        }
        return nil
    } else if let naiVC = VC as? UINavigationController {
        // 控制器是 nav
        return getTopVC(withCurrentVC: naiVC.visibleViewController)
    } else {
        // 返回顶控制器
        return VC
    }
}

/// 根据控制器获取 顶层控制器(考虑返回UITabBarController的childVC)
public func getTopVC(withCurrentVC VC: UIViewController?, ignoreChildrenVC: Bool = true) -> UIViewController? {
    if VC == nil {
        print("🌶： 找不到顶层控制器")
        return nil
    }
    if let presentVC = VC?.presentedViewController {
        // modal出来的 控制器
        return getTopVC(withCurrentVC: presentVC)
    } else if let tabVC = VC as? UITabBarController {
        // tabBar 的跟控制器
        if !ignoreChildrenVC, let childrenVC = tabVC.children.last(where: { vc in
            vc.view.frame.origin == .zero
        }) {
            return childrenVC
        } else if let selectVC = tabVC.selectedViewController {
            return getTopVC(withCurrentVC: selectVC)
        }
        return nil
    } else if let naiVC = VC as? UINavigationController {
        // 控制器是 nav
        return getTopVC(withCurrentVC: naiVC.visibleViewController)
    } else {
        // 返回顶控制器
        return VC
    }
}

public func getViewController(_ vcTpye: UIViewController.Type, navigationController: UINavigationController) -> UIViewController? {
    var target: UIViewController?
    for controller in navigationController.viewControllers {
        if controller.isKind(of: vcTpye) {
            target = controller
            break
        }
    }
    return target
}
///  删除导航栏中某些子控制器
public func removeNavigtorSubView<T: UIViewController>(with type: T.Type,mainNav:UINavigationController?) {
    guard let mainNav = mainNav else { return  }
    let subView = mainNav.viewControllers
    mainNav.viewControllers.removeAll(where: { $0.classForCoder == T.self })
    let afterSubView = mainNav.viewControllers
}
