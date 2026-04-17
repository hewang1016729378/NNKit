//
//  Reusable.swift
//  NNHost
//
//  Created by Leigod on 2022/3/8.
//

import UIKit

public protocol Reusable {
    static var reuseID: String {get}
}

public extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UITableViewHeaderFooterView: Reusable {}

extension UICollectionReusableView: Reusable {}


extension UIViewController: Reusable {}
public extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
        guard let viewController = instantiateViewController(withIdentifier: type.reuseID) as? T else {
            fatalError()
        }
        return viewController
    }
}
