//
//  String+Extensions.swift
//

import CommonCrypto
import Foundation
import SwiftUI
import UIKit

extension String {
    public func color() -> UIColor {
        var cString: String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if cString.count < 6 {
            return UIColor.black
        }
        if cString.hasPrefix("0X") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 2)))
        }
        if cString.hasPrefix("#") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 1)))
        }
        if cString.count != 6 {return UIColor.black}
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    }
    public func color(alpha: Float) -> UIColor {
        var cString: String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if cString.count < 6 {
            return UIColor.black
        }
        if cString.hasPrefix("0X") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 2)))
        }
        if cString.hasPrefix("#") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 1)))
        }
        if cString.count != 6 {return UIColor.black}
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha))
    }
}


extension String {
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

    public var isValidURL: Bool {
        return isStringLink(string: self)
    }

    // 验证手机号码
    public var isMobile: Bool {
        var isPhone = false
        if count == 11 {
            if first == "1" {
                isPhone = true
            } else {
                isPhone = false
            }
        } else {
            isPhone = false
        }
        return isPhone
//        let mobilePhone = "^(1[345789][0-9]{9})|((0\\d{2}-\\d{8})|(0\\d{3}-\\d{7,8})|(0\\d{10,11}))$"
//        return NSPredicate(format: "SELF MATCHES %@", mobilePhone).evaluate(with: self)
    }

    public func jsonStringToDic() throws -> Dictionary<String, Any>? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return [:]
        }
        let result = try JSONSerialization.jsonObject(with: data, options: [])
        return result as? Dictionary<String, Any>
    }

    public func toJsonStr(dict: Any) -> String {
        var dataStr = ""
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            dataStr = String(describing: NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)
        } catch {
            print("转换失败:\(error)")
        }
        return dataStr
    }

    /*
     * 搜索null,字符串替换为"",
     */
    public func replaceNullToString() -> String {
        // 匹配null,
        let replaced = replacingOccurrences(of: "null,", with: "\"\",")
        // 匹配:null(最后一个字段为null没有,)
        let replacedAgain = replaced.replacingOccurrences(of: ":null", with: ":\"\"")
        return replacedAgain
    }

    /*
     * 搜索空格,字符串替换为"",
     */
    public func replaceSpaceToString() -> String {
        let replaced = replacingOccurrences(of: " ", with: "")
        return replaced
    }

    /*
     * 搜索null,字符串替换为0,
     */
    public func replaceNullToZeroInt() -> String {
        let replaced = replacingOccurrences(of: "null,", with: "0,")
        return replaced
    }

    public func getDocumentPath() -> String {
        let ducumentPath = NSHomeDirectory() + "/Documents"
        return ducumentPath
    }

    public func getHomePath() -> String {
        let homeDirectory = NSHomeDirectory()
        return homeDirectory
    }

    public func getLibraryPath() -> String {
        let libraryPath = NSHomeDirectory() + "/Library"
        return libraryPath
    }

    private func isStringLink(string: String) -> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard detector != nil && !string.isEmpty else { return false }
        if detector!.numberOfMatches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: string.count)) > 0 {
            return true
        }
        return false
    }

    /// Returns a new string by removing all whitespaces from the receiver object
    /// - Returns: New string without whitespaces from the receiver
    public func vc_removingAllWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

    /// 32位md5计算
    public var md5: String {
        let str = cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)

        let hash = NSMutableString()

        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }

        result.deallocate()
        return hash as String
    }

    /// Generate a random string
    public static func randomString(length: Int) -> String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }

    /// 检查是否手机号
    public func isTelNumber() -> Bool {
        if count < 11 {
            return false
        }
        let mobile = "^1\\d{10}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        return regextestmobile.evaluate(with: self)
    }

    /// 检查姓名
    public func isChineseName() -> Bool {
        // 12位汉字
        let reg = "^[\\u4E00-\\u9FA5]{2,12}(·[\\u4E00-\\u9FA5]{2,12}){0,2}$"
        let regexIdCard = NSPredicate(format: "SELF MATCHES %@", reg)
        return regexIdCard.evaluate(with: self)
    }
    
    /// 检查身份证号
    public func isIdCardNumber() -> Bool {
        // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
        let reg = "^\\d{17}[0-9Xx]|\\d{15}"
        let regexIdCard = NSPredicate(format: "SELF MATCHES %@", reg)
        return regexIdCard.evaluate(with: self)
    }

    /// 是否为纯数字
    public func isDigital() -> Bool {
        let reg = "[0-9]*"
        let regexIdCard = NSPredicate(format: "SELF MATCHES %@", reg)
        return regexIdCard.evaluate(with: self)
    }

    /// 是否为纯字母
    public func isLetter() -> Bool {
        let reg = "[a-zA-Z]*"
        let regexIdCard = NSPredicate(format: "SELF MATCHES %@", reg)
        return regexIdCard.evaluate(with: self)
    }

    /// 是否为数字和字母
    public func isDigitalAndLetter() -> Bool {
        let reg = "[a-zA-Z0-9]*"
        let regexIdCard = NSPredicate(format: "SELF MATCHES %@", reg)
        return regexIdCard.evaluate(with: self)
    }

    /// 是否为纯汉字
    public func isChinese() -> Bool {
        let reg = "^[\u{4e00}-\u{9fa5}]+$"
        let regexIdCard = NSPredicate(format: "SELF MATCHES %@", reg)
        return regexIdCard.evaluate(with: self)
    }

    /// 是否包含中文
    public func hasChiness() -> Bool {
        let reg = ".*[\u{4e00}-\u{9fa5}]+.*"
        let regexIdCard = NSPredicate(format: "SELF MATCHES %@", reg)
        return regexIdCard.evaluate(with: self)
    }

    // 是否是合法数字(整数或者小数，不包括负数)
    public func isValiteNumber() -> Bool {
        let mobile = "^[0-9]+.?[0-9]*$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        return regextestmobile.evaluate(with: self)
    }

    /// 是否是合法数字(整数或者小数，包括负数)
    public func isValiteNumberContainNegative() -> Bool {
        let mobile = "^([0-9]+.?[0-9]*|-[0-9]+.?[0-9]*)$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        return regextestmobile.evaluate(with: self)
    }

    /// 邮箱格式校验
    public func isEmail() -> Bool {
        let reg = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let regexIdCard = NSPredicate(format: "SELF MATCHES %@", reg)
        return regexIdCard.evaluate(with: self)
    }
}

/*
 * 计算字体宽高
 */
extension String {
    public func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    public func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    public func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}

public extension String {
    var image: UIImage? {
        return UIImage(named: self)
    }
}

// MARK: - range

extension String {
    public var attributedString: NSAttributedString {
        return NSAttributedString(string: self)
    }

    public var mutableAttributedString: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }

    public var nsString: NSString {
        return self as NSString
    }

    public func substring(to count: Int) -> String {
        return nsString.substring(to: count)
    }

    public func substring(from count: Int) -> String {
        return nsString.substring(from: count)
    }

    public func substring(with range: NSRange) -> String {
        return nsString.substring(with: range)
    }

    public func allRange() -> NSRange {
        return NSMakeRange(0, count)
    }

    public func nsRanges(of string: String) -> [NSRange] {
        return ranges(of: string).map {
            (range) -> NSRange in
            self.nsRange(from: range)
        }
    }

    public func ranges(of string: String) -> [Range<String.Index>] {
        var rangeArray = [Range<String.Index>]()
        var searchedRange: Range<String.Index>
        guard let sr = range(of: self) else {
            return rangeArray
        }
        searchedRange = sr

        var resultRange = range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        while let range = resultRange {
            rangeArray.append(range)
            searchedRange = Range(uncheckedBounds: (range.upperBound, searchedRange.upperBound))
            resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        }
        return rangeArray
    }

    public func toNSRange(fromRange range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }

    /// range转换为NSRange
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }

    /// NSRange转化为range
    public func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
        else { return nil }
        return from ..< to
    }

    public func paragraphStyle(_ lineSpacing: CGFloat, _ font: UIFont = kFont14, _ alignment: NSTextAlignment = .left) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        let attStr = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
        attStr.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.kern: 0.2], range: NSRange(location: 0, length: count))
        return attStr
    }

    /// 批量设置富文本
    /// - Parameter textFont: 默认文本
    /// - Parameter textColor: 默认文本颜色
    /// - Parameter changeTexts: 需要改变的文本
    /// - Parameter changFonts: 需要改变的字体
    /// - Parameter changeColors: 需要改变的颜色
    /// - Parameter isLineThrough: 是否下划线
    public func setAttributeStringTexts(FullTextFont textFont: UIFont,
                                 andFullTextColor textColor: UIColor,
                                 withChangeTexts changeTexts: [String],
                                 withChangeFonts changFonts: [UIFont],
                                 withChangeColors changeColors: [UIColor],
                                 isLineThrough: Bool = false) -> NSAttributedString {
        let strFullText: String = self

        var range: NSRange?
        var dicAttr: [NSAttributedString.Key: Any]?
        let attributeString = NSMutableAttributedString(string: strFullText)

        // 不需要改变的文本
        range = NSString(string: strFullText).range(of: String(strFullText))

        dicAttr = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]
        attributeString.addAttributes(dicAttr!, range: range!)

        // 需要改变的文本
        var index: Int = 0
        for item in changeTexts {
            let ranges = rangeOfString(string: NSString(string: strFullText), andInString: item)

            for range in ranges {
                dicAttr = [
                    NSAttributedString.Key.font: changFonts.count > index ? changFonts[index] : changFonts.first as Any,
                    NSAttributedString.Key.foregroundColor: changeColors.count > index ? changeColors[index] : changeColors.first as Any,
                ]

                if isLineThrough {
                    dicAttr?[NSAttributedString.Key.strikethroughStyle] = NSNumber(value: 1)
                }

                if range.location + range.length <= strFullText.count {
                    attributeString.addAttributes(dicAttr!, range: range)
                }
            }

            index += 1
        }

        return attributeString
    }

    /// 获取字符出现的位置信息(支持多次位置获取)
    /// - Parameter string: 原始文本
    /// - Parameter inString: 需要查找的字符
    private func rangeOfString(string: NSString, andInString inString: String) -> [NSRange] {
        var arrRange = [NSRange]()
        var fullText = string
        var rang: NSRange = fullText.range(of: inString)

        while rang.location != NSNotFound {
            var location: Int = 0
            if arrRange.count > 0 {
                if arrRange.last!.location + arrRange.last!.length < string.length {
                    location = arrRange.last!.location + arrRange.last!.length
                }
            }

            fullText = NSString(string: fullText.substring(from: rang.location + rang.length))

            if arrRange.count > 0 {
                rang.location += location
            }
            arrRange.append(rang)

            rang = fullText.range(of: inString)
        }

        return arrRange
    }
}
// 联系人分组
extension String {
    public func transformToPinYin() -> String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "").uppercased()
    }

    public func isNotLetter() -> Bool {
        let upperCaseStr: String = uppercased()
        let c = Character(upperCaseStr)
        if c >= "A", c <= "Z" {
            return false
        } else {
            return true
        }
    }

    public func dividing(by decimalNumber: String, scale: Int16 = 2, roundingMode: NSDecimalNumber.RoundingMode = .plain) -> String {
        guard decimalNumber != "0" else {
            return self
        }
        guard self != "0" else {
            return self
        }
        let dec = NSDecimalNumber(string: self)
        let dec1 = NSDecimalNumber(string: decimalNumber)
        let decimalNumberHandler = NSDecimalNumberHandler(roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        let number = dec.dividing(by: dec1, withBehavior: decimalNumberHandler)
        return String(number.doubleValue)
    }
}
