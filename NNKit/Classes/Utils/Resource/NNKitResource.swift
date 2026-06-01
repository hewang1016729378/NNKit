//
//  NNKitResource.swift
//  NNKit
//
//  Created by leigodLi on 2023/7/10.
//

import Foundation
import UIKit

class NNKitResource: NSObject {
    static func resourceBundle() -> Bundle {
        //let bundle = Bundle.init(path: Bundle.init(for: NNKitResource.self).path(forResource: "NNKitBundle", ofType: "bundle")!)
        //return bundle!
        let mainBundle = Bundle(for: NNKitResource.self)
        guard let path = mainBundle.path(forResource: "NNKitBundle", ofType: "bundle") else {return mainBundle}
        let resourceBundle = Bundle(path: path)
        return resourceBundle!
    }
}

func L$(_ name: String) -> String {
    guard let text = NNConvenienceResource.text(bundle: NNKitResource.resourceBundle(), name: name) else {
        return ""
    }
    return text
}

func I$(_ name: String) -> UIImage {
    guard let image = NNConvenienceResource.image(bundle: NNKitResource.resourceBundle(), name: name) else {
        return UIImage()
    }
    return image
}

extension UIImage {
    struct NoticeIcon {
        static let close = I$("close")
    }
}

extension String {
    public struct NoticeText {
        static let title = L$("key_notice_title")
        static let confirm = L$("key_notice_btn")
    }
    
    public struct JsonPath {
        static let activity = NNKitResource.resourceBundle().path(forResource: "json/jiazai", ofType: "json") ?? ""
    }
}
