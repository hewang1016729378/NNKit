//
//  BaseTextField.swift
//  NNIM
//
//  Created by ly on 2022/10/14.
//

import Foundation
import UIKit

open class BaseTextField: UITextField {
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public var maxTextLength: Int = 100
    public var removeSpace = false
    public override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(self.greetingTextFieldChanged), name: NSNotification.Name(rawValue:"UITextFieldTextDidChangeNotification"), object: self)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    @objc func greetingTextFieldChanged(obj: Notification) {
        // 非 marketedText 才继续往下处理
        guard let _:UITextRange = self.markedTextRange else {
            // 记录当前光标的位置，后面需要进行修改
            let cursorPostion = self.offset(from: self.endOfDocument, to: self.selectedTextRange!.end)
            var flag: Bool = false
            // 判断非中文的正则表达式
//            let pattern = "[^\\u4E00-\\u9FA5]"
            // 替换后的字符串(已过滤非中文字符)
//            if var str = self.text?.pregReplace(pattern: pattern, with: "") ?? self.text {
            if var str = self.text {
                // 限制最大输入长度
                if str.count > maxTextLength {
                    str = String(str.prefix(maxTextLength))
                    flag = true
                }
                // 删除空格
                if removeSpace {
                    str = str.replaceSpaceToString()
                }
                self.text = str
                // 让光标停留在正确的位置
                if flag && cursorPostion != 0 {
                    if let targetPosion = self.position(from: self.endOfDocument, offset: cursorPostion + 1) {
                        self.selectedTextRange = self.textRange(from: targetPosion, to: targetPosion)
                    }
                } else {
                    if let targetPosion = self.position(from: self.endOfDocument, offset: cursorPostion) {
                        self.selectedTextRange = self.textRange(from: targetPosion, to: targetPosion)
                    }
                }
            }
            return
        }
    }
}

public extension String {
    // 使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern, options: options)
        return regex?.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
}
