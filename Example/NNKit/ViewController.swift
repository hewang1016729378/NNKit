//
//  ViewController.swift
//  NNKit
//
//  Created by ly on 06/28/2023.
//  Copyright (c) 2023 ly. All rights reserved.
//

import UIKit
import NNKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        LYAlertViewHelper.customAlertViewCustomTextAndCancelWithTarget(self, "企业认证", "1233", "认证", "退出") {
//
//        } cancelEvent: {
//
//        }
        LYAlertViewHelper.customAlertViewCustomTextAndCancelSuccessWithTarget(self, "成功", "123", "好的") {

        } cancelEvent: {

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

