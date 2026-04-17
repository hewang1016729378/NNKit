//
//  Error+Extension.swift
//  NNHost
//
//  Created by ly on 2022/6/1.
//

import Foundation

public extension Error {
    var errorCode: Int? {
        return (self as NSError).code
    }
}
