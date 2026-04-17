//
//  LYAlertViewHelper.swift
//
//  Created by Liu Yang on 26/10/2017.
//

import UIKit
import PanModal

/// 是否开启通用弹窗暗黑模式适配
public var EnableAlertViewDarkMode = false

public class LYAlertViewHelper: NSObject {
    public typealias RefreshCompletion = (_ succeeded: Bool, _ publicKey: String?, _ state: Int?) -> Void
    public typealias ConfirmCompletion = (_ action: UIAlertAction) -> Void
    public typealias CancelCompletion = (_ action: UIAlertAction) -> Void
    /*
     * 取消、确认按钮弹窗
     */
    static public func alertViewConfirmAndCancelWithTagert(_ target: UIViewController, _ title: String, _ content: String, _ confirmEvent: (ConfirmCompletion)?, cancelEvent: (CancelCompletion)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "确认".localized, style: .default, handler: { (action) in
                confirmEvent?(action)
            }))
            alert.addAction(UIAlertAction.init(title: "取消".localized, style: .cancel, handler: { (action) in
                cancelEvent?(action)
            }))
            presentNormalVC(target: target, alert: alert)
        })
    }
    /*
     * 取消、右按钮自定义文本弹窗
     */
    static public func alertViewCustomBtnTextAndCancelWithTagert(_ target: UIViewController, _ title: String, _ content: String, _ confirmTitle: String,_ confirmEvent: (ConfirmCompletion)?, cancelEvent: (CancelCompletion)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: confirmTitle, style: .default, handler: { (action) in
                confirmEvent?(action)
            }))
            alert.addAction(UIAlertAction.init(title: "取消".localized, style: .cancel, handler: { (action) in
                cancelEvent?(action)
            }))
            presentNormalVC(target: target, alert: alert)
        })
    }
    /*
     * 确认按钮弹窗
     */
    static public func alertViewConfirmWithTagert(_ target: UIViewController, _ title: String, _ content: String, _ confirmEvent: (ConfirmCompletion)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let alert = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "确认".localized, style: .default, handler: { (action) in
                confirmEvent?(action)
            }))
            presentNormalVC(target: target, alert: alert)
        }
    }
    /*
     * 自定义提示框(自定义确认文本按钮)
     */
    static public func customAlertViewConfirmWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ contentAliment: NSTextAlignment? = .center, _ confirmButtonStr:String? = "确认".localized, _ confirmEvent:(() -> Void)? = nil) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController(title: title, message: content, contentAligment:contentAliment, customBtnText: confirmButtonStr, customCancelBtnText: "取消", style: .confirm, confirmEvent: confirmEvent, cancelEvent: nil)
            presentPanModalVC(target: target, alert: alert)
        })
    }
    /*
     * 自定义提示框(确认取消按钮)
     */
    static public func customAlertViewConfirmAndCancelWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(title: title, message: content, style: .confirmAndCancel, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            presentPanModalVC(target: target, alert: alert)
        })
    }
    /*
     * 自定义提示框(自定义文本的确认按钮，取消按钮)
     */
    static public func customAlertViewCustomTextAndCancelWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ customConfirmBtnText: String, _ customCancleBtnText: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(title: title, message: content, customBtnText: customConfirmBtnText, customCancelBtnText:customCancleBtnText, style: .confirmAndCancel, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            presentPanModalVC(target: target, alert: alert)
        })
    }
    /*
     * 自定义提示框(自定义文本的确认按钮，取消按钮，title文字颜色)
     */
    static public func customAlertViewCustomTextAndCancelWithTitleColorTarget(_ target: UIViewController, _ title: String, _ titleColor: String, _ content: String, _ customBtnText: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(title: title, titleColor: titleColor, message: content, customBtnText: customBtnText, style: .confirmAndCancel, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            presentPanModalVC(target: target, alert: alert)
        })
    }
    /*
     * 自定义提示框(标题和内容支持富文本)
     */
    static public func customAlertViewCustomAttributedTitleWith(_ target: UIViewController, _ attributedTitle: NSAttributedString?, _ attributedContent: NSAttributedString?, _ customBtnText: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)?) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(attributedTitle: attributedTitle, message: attributedContent, customBtnText: customBtnText, style: .confirmAndCancel, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            presentPanModalVC(target: target, alert: alert)
        })
    }
    /*
     * 自定义提示框(自定义确认文本按钮, 失败)
     */
    static public func customAlertViewConfirmFailureWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ contentAliment: NSTextAlignment? = .center, _ confirmButtonStr:String? = "确认".localized, _ confirmEvent:(() -> Void)?) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController(title: title, message: content, contentAligment:contentAliment, customBtnText: confirmButtonStr, style: .confirm, result: .failure, confirmEvent: confirmEvent, cancelEvent: nil)
            presentPanModalVC(target: target, alert: alert)
        })
    }
    /*
     * 自定义提示框(自定义确认文本按钮, 成功)
     */
    static public func customAlertViewConfirmSuccessWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ contentAliment: NSTextAlignment? = .center, _ confirmButtonStr:String? = "确认".localized, _ confirmEvent:(() -> Void)?) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController(title: title, message: content, contentAligment:contentAliment, customBtnText: confirmButtonStr, style: .confirm, result: .success, confirmEvent: confirmEvent, cancelEvent: nil)
            presentPanModalVC(target: target, alert: alert)
        })
    }
    /*
     * 自定义提示框(自定义文本的确认按钮，取消按钮，成功)
     */
    static public func customAlertViewCustomTextAndCancelSuccessWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ customBtnText: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(title: title, message: content, customBtnText: customBtnText, style: .confirmAndCancel, result: .success, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            presentPanModalVC(target: target, alert: alert)
        })
    }
    /*
     * 自定义提示框(自定义文本的确认按钮，取消按钮，失败)
     */
    static public func customAlertViewCustomTextAndCancelFailureWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ customBtnText: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(title: title, message: content, customBtnText: customBtnText, style: .confirmAndCancel, result: .failure, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            presentPanModalVC(target: target, alert: alert)
        })
    }
    
    /// fixbux: ViewController刚加载时，就弹出PanModal弹窗会导致背景图不显示
    /// - Parameters:
    ///   - target: target description
    ///   - alert: alert description
    private static func presentPanModalVC<T: PanModalPresentable>(target: UIViewController, alert: T) where T: UIViewController {
        if abs(Date.init().timeIntervalSince1970 - recentLoadVCTimeInterval) < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                target.presentPanModal(alert)
            }
        } else {
            DispatchQueue.main.async(execute: { () in
                target.presentPanModal(alert)
            })
        }
    }
    
    /// fixbux: ViewController刚加载时，就弹出PanModal弹窗会导致背景图不显示
    /// - Parameters:
    ///   - target: target description
    ///   - alert: alert description
    private static func presentNormalVC<T: UIViewController>(target: UIViewController, alert: T) where T: UIViewController {
        if abs(Date.init().timeIntervalSince1970 - recentLoadVCTimeInterval) < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                target.present(alert, animated: true)
            }
        } else {
            DispatchQueue.main.async(execute: { () in
                target.present(alert, animated: true)
            })
        }
    }
}
