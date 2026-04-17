//
//  UIView+AddClickedEvent.swift
//  kanqiusports
//
//  Created by Apple on 2020/1/4.
//  Copyright © 2020 kanqiusports. All rights reserved.
//

import Foundation
import UIKit
public extension UIView {
    private struct AssociatedKeys {
        static var clickedKey = "AddClickedEvent"
    }

    private var block: (() -> Void?)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.clickedKey) as? (() -> Void?)
        }
        set(manager) {
            if let btn = self as? UIButton {
                btn.addTarget(self, action: #selector(tagAction), for: .touchUpInside)
            } else {
                addTapGesture()
            }
            objc_setAssociatedObject(self, &AssociatedKeys.clickedKey, manager, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func addClick<T: AnyObject>(on target: T, block: ((T) -> Void)?) {
        self.block = { [weak target] in
            guard let target = target else {
                return nil
            }
            return block?(target)
        }
    }

    private func addTapGesture() {
        if gestureRecognizers == nil {
            isUserInteractionEnabled = true

            // :添加单击事件
            let tap = UITapGestureRecognizer(target: self, action: #selector(tagAction))
            addGestureRecognizer(tap)
        }
    }

    @objc func tagAction() {
        block?()
    }
}
