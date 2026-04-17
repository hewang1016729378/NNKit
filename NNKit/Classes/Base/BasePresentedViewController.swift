//
//  BasePresentViewController.swift
//  NNIM
//
//  Created by 刘警锋 on 2023/12/4.
//  Copyright © 2023 NN. All rights reserved.
//

import Foundation

open class BasePresentedViewController: UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // 模态视图点击阴影隐藏
        if presentingViewController != nil {
            if let touchedView = event?.allTouches?.first?.view, touchedView == view {
                dismiss(animated: true)
            }
        }
    }
}
