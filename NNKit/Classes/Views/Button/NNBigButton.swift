//
//  NNBigButton.swift
//  NNHost
//
//  Created by Leigod on 2022/4/1.
//

import UIKit

// 扩大点击范围
public class NNBigButton: UIButton {
    // 取消高亮
    public override var isHighlighted: Bool {
        set { }
        get { return false }
    }

    public override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.alpha = 1.0
            } else {
                self.alpha = 0.5
            }
        }
    }

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if point.x > -20 && point.x < width + 20 &&
            point.y > -20 && point.y < height + 20 {
            return true
        } else {
            return false
        }
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.disable(withDuration: 1)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
