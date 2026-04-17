//
//  UICollectionView+Extension.swift
//  NNHost
//
//  Created by Leigod on 2022/3/29.
//

import UIKit
import NNKit

public extension UICollectionView {
    func registerClassOf<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseID)
    }

    func registerClassOf<T: UICollectionReusableView>(_: T.Type, elementKind: String) {
        register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseID)
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(elementKind: String, indexPath: IndexPath)
        -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseID)")
        }
        return cell
    }

    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseID)")
        }
        return cell
    }
}
