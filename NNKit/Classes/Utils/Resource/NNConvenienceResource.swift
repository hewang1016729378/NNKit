//
//  NNConvenienceResource.swift
//  NNKit
//
//  Created by leigodLi on 2023/7/10.
//

import Foundation
import UIKit

public class NNConvenienceResource: NSObject {
    
    public static let share = NNConvenienceResource()
    
    public lazy var language: String = {
        guard var language = Locale.current.languageCode else {
            return "zh-Hans"
        }
        if (language.hasPrefix("en")) {
            language = "en"
        } else {
            language = "zh-Hans"
        }
        return language
    }()
    
    public static func text(bundle: Bundle, name: String) -> String? {
        guard let path = bundle.path(forResource: "languages/" + NNConvenienceResource.share.language, ofType: "lproj") else {
            return nil
        }
        let bundle = Bundle.init(path: path)
        guard let text = bundle?.localizedString(forKey: name, value: nil, table: nil) else {
            return nil
        }
        return text
    }
    
    public static func image(bundle: Bundle, name: String) -> UIImage? {
        guard let path = bundle.path(forResource: "Assets.xcassets/\(name).imageset/Contents.json", ofType: nil) else {
            return nil
        }
        guard let json = try? String.init(contentsOfFile: path) else {
            return nil
        }
        guard let dict = self.dictionaryWithJsonString(jsonString: json) else {
            return nil
        }
        guard let imagesArray = dict["images"] as? [[String:String]] else {
            return nil
        }
        let scale = Int(UIScreen.main.scale)
        let scaleStr = String.init(format: "%dx", scale)
        
        var defaultFileName = ""
        for imageDict in imagesArray {
            if let currentScale = imageDict["scale"] {
                if currentScale == scaleStr {
                    if let filename = imageDict["filename"] {
                        if let resultPath = bundle.path(forResource: "Assets.xcassets/\(name).imageset/\(filename)", ofType: nil) {
                            if let image = UIImage.init(contentsOfFile: resultPath) {
                                if NNConvenienceResource.share.language == "ar" {
                                    return image.withHorizontallyFlippedOrientation()
                                }
                                return image
                            }
                        }
                    }
                }
                if currentScale == "2x" {
                    if let filename = imageDict["filename"] {
                        defaultFileName = filename
                    }
                }
            }
        }
        if let resultPath = bundle.path(forResource: "Assets.xcassets/\(name).imageset/\(defaultFileName)", ofType: nil) {
            if let image = UIImage.init(contentsOfFile: resultPath) {
                if NNConvenienceResource.share.language == "ar" {
                    return image.withHorizontallyFlippedOrientation()
                }
                return image
            }
        }
        return nil
    }
}

extension NNConvenienceResource {
    private static func dictionaryWithJsonString(jsonString: String) -> NSDictionary? {
        let jsonData = jsonString.data(using: .utf8)
        guard let dict = try? JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments) as? NSDictionary else {
            return nil
        }
        return dict
    }
}

public extension NSTextAlignment {
    struct RTL {
        public static func trailing() -> NSTextAlignment {
            if NNConvenienceResource.share.language == "ar" {
               return NSTextAlignment.left
           }
           return NSTextAlignment.right
       }
    }
}

public extension UIControl.ContentHorizontalAlignment {
    struct RTL {
        public static func trailing() -> UIControl.ContentHorizontalAlignment {
           if NNConvenienceResource.share.language == "ar" {
               return UIControl.ContentHorizontalAlignment.left
           }
           return UIControl.ContentHorizontalAlignment.right
       }
    }
}

public extension UIView {
    func responderController() -> UIViewController? {
        var responder = self.next
        while (responder != nil) {
            if responder?.isKind(of: UIViewController.self) == true {
                return responder as? UIViewController
            }
            responder = self.next
        }
        return nil
    }
}
