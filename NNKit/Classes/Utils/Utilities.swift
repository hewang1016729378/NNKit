//
//  Utilities.swift
//  NNAcc
//
//  Created by ly on 2021/12/10.
//

import Foundation
import UIKit
import AVFoundation

public enum DifferentiatorError: Error {
    case unwrappingOptional
    case preconditionFailed(message: String)
}

public func precondition(_ condition: Bool, _ message: @autoclosure () -> String) throws {
    if condition {
        return
    }
    debugFatalError("Precondition failed")
    throw DifferentiatorError.preconditionFailed(message: message())
}

public func debugFatalError(_ error: Error) {
    debugFatalError("\(error)")
}

public func debugFatalError(_ message: String) {
    #if DEBUG
        fatalError(message)
    #else
        print(message)
    #endif
}

public func jumpToSafari(urlString: String) {
    if let url = URL(string: urlString) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:],
                                      completionHandler: {
                                          _ in
                                      })
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

// MARK: - ------------------ 判断是否首次启动

public func setFirstLaunch() {
    UserDefaults.standard.set(true, forKey: "isFirstLaunch")
}

public func isFirstLaunch() -> Bool {
    return UserDefaults.standard.bool(forKey: "isFirstLaunch")
}

// MARK: - ------------------ 判断是否开启全app内通知

public func setNotificationSwitch(_ isSwitch: String, _ keySwitch: String) {
    UserDefaults.standard.set(isSwitch, forKey: keySwitch)
}

public func getNotificationSwitch(_ keySwitch: String) -> String {
    if let isSwitch = UserDefaults.standard.string(forKey: keySwitch) {
        return isSwitch
    }
    return "1"
}

/*
 * 检测麦克风权限
 */
public func isOpenAudioSession() -> Bool {
    let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
    return authStatus != .restricted && authStatus != .denied
//    let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
//    switch authStatus {
//    case .notDetermined:  // 用户尚未做出选择
//        return false
//    case .authorized:  // 已授权
//        return true
//    case .denied:  // 用户拒绝
//        return false
//    case .restricted:  // 家长控制
//        return false
//    }
}
