//
//  UIScrollView+Extensions.swift
//

import Foundation
import UIKit

public extension UIScrollView {
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
    
    func setBottomInset(height: CGFloat) {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        contentInset = contentInsets
        scrollIndicatorInsets = contentInsets
    }
}
