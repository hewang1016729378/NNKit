//
//  String+ComputedTextSize.swift
//  NNHost
//
//  Created by Leigod on 2022/3/15.
//

import Foundation
import UIKit

extension String {
    
// MARK: - 传入高度，返回文字宽度
    public func textSize(with font: UIFont, maxHeight: CGFloat) -> CGSize {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        // swift NSParagraphStyleAttributeName 变成了
        var attrs = [NSAttributedString.Key : Any]()
        attrs[NSAttributedString.Key.font] = font
        attrs[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        
        let maxSize = CGSize.init(width: CGFloat(MAXFLOAT), height: maxHeight)
        
        self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        
        return self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil).size
    }
    
// MARK: - 传入宽度，返回文字高度
    public func textSize(with font: UIFont, maxWidth: CGFloat) -> CGSize {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        var attrs = [NSAttributedString.Key: Any]()
        attrs[NSAttributedString.Key.font] = font
        attrs[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        
        let maxSize = CGSize.init(width: maxWidth, height: CGFloat(MAXFLOAT))
        
        return self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil).size
    }
}
