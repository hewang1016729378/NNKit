//
//  BaseView.swift
//  NNAcc
//
//  Created by ly on 2021/12/13.
//

import Foundation
import UIKit

public enum CornerDirection {
    case top
    case bottom
    case left
    case right
    case all
}

public enum LayoutType {
    case frame
    case autoLayout
}

public class CornerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var direction:CornerDirection!
    var cornerHeight:CGFloat!
    var layoutType:LayoutType!

    public convenience init(frame: CGRect, direction: CornerDirection, height:CGFloat, color:UIColor, layoutType:LayoutType) {
        self.init(frame: frame)
        self.backgroundColor = color
        self.direction = direction
        self.cornerHeight = height
        self.layoutType = layoutType
        // 自动化布局
        if layoutType == .frame {
            self.setupCornerMask(height: height)
        }
    }
    
    func setupCornerMask(height: CGFloat) {
        var directionTmp:UIRectCorner
        if self.direction == .top {
            directionTmp = [.topLeft, .topRight]
        }
        else {
            directionTmp = [.bottomLeft, .bottomRight]
        }
        
        let maskPath = UIBezierPath.init(roundedRect: CGRect.init(x: 0.0, y: 0.0, width: self.frame.size.width, height: height), byRoundingCorners: directionTmp, cornerRadii: CGSize.init(width: height, height: height))
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        
        self.layer.mask = maskLayer
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if layoutType == .autoLayout {
            self.setupCornerMask(height: height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

