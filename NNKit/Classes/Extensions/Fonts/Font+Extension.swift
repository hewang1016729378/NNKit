//
//  Font+Extension.swift
//  NNHost
//
//  Created by Leigod on 2022/3/11.
//

import UIKit

extension UIFont {
    @objc func robotoBoldItalic(_ fontSize: CGFloat) -> UIFont {
        UIFont.getFont("Roboto-BoldItalic", ofSize: fontSize)
    }
    
    open class func robotoMedium(_ fontSize: CGFloat) -> UIFont {
        getFont("Roboto-Medium", ofSize: fontSize)
    }

    open class func helveticaNeue(_ fontSize: CGFloat) -> UIFont {
        getFont("HelveticaNeue", ofSize: fontSize)
    }

    open class func helveticaNeueMedium(_ fontSize: CGFloat) -> UIFont {
        getFont("HelveticaNeue-Medium", ofSize: fontSize)
    }

    open class func helveticaNeueBold(_ fontSize: CGFloat) -> UIFont {
        getFont("HelveticaNeue-Bold", ofSize: fontSize)
    }

    open class func regularSystem(_ fontSize: CGFloat) -> UIFont {
        getSystemFont(ofSize: fontSize, weight: .regular)
    }

    open class func boldFont(_ fontSize: CGFloat) -> UIFont {
        getSystemFont(ofSize: fontSize, weight: .bold)
    }

    open class func mediumFont(_ fontSize: CGFloat) -> UIFont {
        getSystemFont(ofSize: fontSize, weight: .medium)
    }

    open class func semiboldFont(_ fontSize: CGFloat) -> UIFont {
        getSystemFont(ofSize: fontSize, weight: .semibold)
    }

    open class func thinSystem(_ fontSize: CGFloat) -> UIFont {
        getSystemFont(ofSize: fontSize, weight: .thin)
    }

    open class func pingfang(_ fontSize: CGFloat) -> UIFont {
        getFont("PingFangSC-Regular", ofSize: fontSize)
    }

    open class func pingfangMedium(_ fontSize: CGFloat) -> UIFont {
        getFont("PingFangSC-Medium", ofSize: fontSize)
    }

    open class func pingfangBold(_ fontSize: CGFloat) -> UIFont {
        getFont("PingFangSC-Semibold", ofSize: fontSize)
    }
    
    open class func pingfangSCBold(_ fontSize: CGFloat) -> UIFont {
        getFont("PingFangSC-Semibold", ofSize: fontSize)
    }
    
    open class func pingfangThin(_ fontSize: CGFloat) -> UIFont {
        getFont("PingFangSC-Thin", ofSize: fontSize)
    }

    open class func harmonySC(_ fontSize: CGFloat) -> UIFont {
        getFont("HarmonyOS Sans", ofSize: fontSize)
    }

    open class func harmonyBold(_ fontSize: CGFloat) -> UIFont {
        getFont("HarmonyOS Sans Bold", ofSize: fontSize)
    }

    open class func harmonyBoldItalic(_ fontSize: CGFloat) -> UIFont {
        getFont("HarmonyOS Sans Bold Italic", ofSize: fontSize)
    }

    open class func harmonySCMedium(_ fontSize: CGFloat) -> UIFont {
        getFont("HarmonyOS Sans SC Medium", ofSize: fontSize)
    }

    open class func harmonyMediumItalic(_ fontSize: CGFloat) -> UIFont {
        getFont("HarmonyOS Sans Medium Italic", ofSize: fontSize)
    }

    open class func sourceHanSansCNRegular(_ fontSize: CGFloat) -> UIFont {
        getFont("SourceHanSansCN-Regular", ofSize: fontSize)
    }

    open class func miSansDemibold(_ fontSize: CGFloat) -> UIFont {
        getFont("MiSans Demibold", ofSize: fontSize)
    }
    open class func dinAlternatebold(_ fontSize: CGFloat) -> UIFont {
        getFont("DIN Alternate Bold", ofSize: fontSize)
    }

}

extension UIFont {
    @objc private static func defaultFont(_ fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }

    private static func getFont(_ name: String, ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: fontSize)
//        printLog("font:\(font)")
//        assert(font != nil, "字体不匹配")
        return font ?? defaultFont(fontSize)
    }

    private static func getSystemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: weight)
    }

    public func isEqual(fontName name: String) -> Bool {
        showFontName()
        assert(fontName == name, "字体不匹配")
        return fontName == name
    }

    public func showFontName() {
        print("fontName: " + fontName)
    }

    public static func showSystemFont() {
        var index = 1
        for name in UIFont.familyNames {
            let names = fontNames(forFamilyName: name)
            names.forEach { fontName in
                print("\(index): " + fontName)
            }
            index += 1
        }
    }
}
