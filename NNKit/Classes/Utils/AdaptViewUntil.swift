//
//  AdaptViewUntil.swift
//  NNHost
//
//  Created by Leigod on 2022/3/15.
//

import UIKit

// MARK: - keyWindow

public var keyWindow: UIWindow? { return keywindows() }

fileprivate func keywindows() -> UIWindow? {
    var keyWindow: UIWindow?
    if #available(iOS 13.0, *) {
        let thread = Thread.current
        keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow }).first
    } else {
        // Fallback on earlier versions
        keyWindow = UIApplication.shared.keyWindow
    }
    #if DEBUG
//        assert(keyWindow != nil)
    #endif
    return keyWindow
}

public func adaptW(_ viewWidth: CGFloat) -> CGFloat {
    return floor(AdaptViewUntil.sharedInstance.getAdaptWidth(viewWidth: viewWidth))
}

public class AdaptViewUntil: NSObject {
    let kRefereWidth: CGFloat = 375.0

    var sizeRate: CGFloat

    static let sharedInstance = AdaptViewUntil()
    override init() {
        sizeRate = UIScreen.main.bounds.size.width / kRefereWidth
    }

    public func getAdaptWidth(viewWidth: CGFloat) -> CGFloat {
        return viewWidth * sizeRate
    }
}
