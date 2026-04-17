//
//  UIDevice+Extensions.swift
//  NNAcc
//
//  Created by ly on 2021/12/1.
//

import Foundation
import SystemConfiguration.CaptiveNetwork
import NetworkExtension
import UIKit
import AdSupport
import AppTrackingTransparency

public extension UIDevice {
    
    //MARK: --------------------- 判断是否是刘海屏
    static func isPhoneX() ->Bool {
        
        if #available(iOS 12.0, *) {
            let keyWindow = UIApplication.shared.windows
            if let window = keyWindow.first {
                let bottomSafeInset = window.safeAreaInsets.bottom
                if (bottomSafeInset == 34 || bottomSafeInset == 21) {
                    return true
                }
            }
        }
        return false
    }

    static func getIDFA() -> String {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .denied:
//                    debugPrint("用户拒绝")
                    break
                case .authorized:
//                    debugPrint("用户允许")
                    debugPrint("IDFA:\(ASIdentifierManager.shared().advertisingIdentifier.uuidString)")
                    break
                case .notDetermined:
                    debugPrint("用户没有选择")
                default:
                    break
                }
            }
        } else {
            // iOS13及之前版本，继续用以前的方式
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                debugPrint("可以获取:\(ASIdentifierManager.shared().advertisingIdentifier.uuidString)")
            } else {
                debugPrint("用户未打开IDFA开关")
            }
        }
        let id = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        return id
    }

    static func get_uuid() -> String {
        //不存在则生成一个新的并保存
        let uuidRef = CFUUIDCreate(nil)
        let uuidStringRef = CFUUIDCreateString(nil , uuidRef)
        let uuid = uuidStringRef! as String
        UserDefaults.standard.set(uuid, forKey: "donkey")
        return uuid
    }
    /*
     * 获取wifi名
     */
    static func getWiFiName() -> String? {
        guard let unwrappedCFArrayInterfaces = CNCopySupportedInterfaces() else {
            print("this must be a simulator, no interfaces found")
            return nil
        }
        guard let swiftInterfaces = (unwrappedCFArrayInterfaces as NSArray) as? [String] else {
            print("System error: did not come back as array of Strings")
            return nil
        }
        var wifiName: String?
        for interface in swiftInterfaces {
            print("Looking up SSID info for \(interface)") // en0
            guard let unwrappedCFDictionaryForInterface = CNCopyCurrentNetworkInfo(interface as CFString) else {
                print("System error: \(interface) has no information")
                return nil
            }
            guard let SSIDDict = (unwrappedCFDictionaryForInterface as NSDictionary) as? [String: AnyObject] else {
                print("System error: interface information is not a string-keyed dictionary")
                return nil
            }
            wifiName = (SSIDDict["SSID"] as? String)
        }
        return wifiName
    }
    /*
     * 实测上面的方法和下面的方法一样，优先使用上面的方法获取wifi名。
     */
    static func getNetworkInfo(compleationHandler: @escaping ([String: Any])->Void){
       var currentWirelessInfo: [String: Any] = [:]
        if #available(iOS 14.0, *) {
            NEHotspotNetwork.fetchCurrent { network in
                guard let network = network else {
                    compleationHandler([:])
                    return
                }
                let bssid = network.bssid
                let ssid = network.ssid
                currentWirelessInfo = ["BSSID ": bssid, "SSID": ssid, "SSIDDATA": "<54656e64 615f3443 38354430>"]
                compleationHandler(currentWirelessInfo)
            }
        } else {
            #if !TARGET_IPHONE_SIMULATOR
            guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
                compleationHandler([:])
                return
            }
            guard let name = interfaceNames.first, let info = CNCopyCurrentNetworkInfo(name as CFString) as? [String: Any] else {
                compleationHandler([:])
                return
            }
            currentWirelessInfo = info
            #else
            currentWirelessInfo = ["BSSID ": "c8:3a:35:4c:85:d0", "SSID": "Tenda_4C85D0", "SSIDDATA": "<54656e64 615f3443 38354430>"]
            #endif
            compleationHandler(currentWirelessInfo)
        }
    }
}

public extension UIDevice {
    struct Is {
        static let iPhone5: Bool = UIDevice.iPhone5
        static let iPhone6: Bool = UIDevice.iPhone6
        static let iPhone6Plus: Bool = UIDevice.iPhoneX
        static let iPhoneX: Bool = UIDevice.iPhoneX
        static let iPhoneXSMax: Bool = UIDevice.iPhoneXSMax
        static let iPhoneXR: Bool = UIDevice.iPhoneXR
    }

    class var iPhone5: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 1136 { return true }
            return false
        }

        return false
    }

    class var iPhone6: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 1334 { return true }
            return false
        }

        return false
    }

    class var iPhoneXSMax: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            let h = UIScreen.main.nativeBounds.height
            if h == 2688 { return true }
        }
        return false
    }

    class var iPhoneXR: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            let h = UIScreen.main.nativeBounds.height
            if h == 1792 { return true }
        }
        return false
    }

    class var iPhoneX: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136: // iPhone 5 or 5S or 5C
                return false

            case 1334: // iPhone 6/6S/7/8

                return false
            case 1920, 2208: // iPhone 6+/6S+/7+/8+

                return false
            case 2436, 2532: // iPhone X, XS, 12

                return true

            case 2688, 2778: // viPhone XS Max  12Max

                return true

            case 1792, 2340: // iPhone XR, 12 Mini

                return true

            default: break
            }
        }
        return false
    }

    class func getNavAndBarHeight() -> CGFloat {
        if Is.iPhoneX {
            return 84.0
        }
        return 64.0
    }

    class func getBarHeight() -> CGFloat {
        if Is.iPhoneX {
            return 40.0
        }
        return 20.0
    }

    class func getNavHeight() -> CGFloat {
        return 44.0
    }

    class func getTabHeight() -> CGFloat {
        return 49.0
    }

    class func getFullTabHeight() -> CGFloat {
        return 49.0 + getSafeHeight()
    }

    class func getSafeHeight() -> CGFloat {
        if Is.iPhoneX {
            return 34.0
        }
        return 0.0
    }

    class func getWithoutNavTabHeight() -> CGFloat {
        return UIScreen.main.bounds.height - UIDevice.getSafeHeight() - UIDevice.getNavAndBarHeight() - UIDevice.getTabHeight()
    }

}
