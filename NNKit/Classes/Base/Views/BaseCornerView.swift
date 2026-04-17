//
//  BaseCornerView.swift
//  NNAcc
//
//  Created by ly on 2021/12/14.
//

import Foundation
import UIKit

open class BaseCornerView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public func createCorner(direction: CornerDirection, height: CGFloat) {
        var directionTmp: UIRectCorner
        if direction == .top {
            directionTmp = [.topLeft, .topRight]
        } else if direction == .left {
            directionTmp = [.topLeft, .bottomLeft]
        } else if direction == .right {
            directionTmp = [.topRight, .bottomRight]
        } else if direction == .bottom {
            directionTmp = [.bottomLeft, .bottomRight]
        } else {
            directionTmp = [.bottomLeft, .bottomRight,.topLeft,.topRight]
        }
        let maskPath = UIBezierPath.init(roundedRect: self.frame, byRoundingCorners: directionTmp, cornerRadii: CGSize.init(width: height, height: height))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
