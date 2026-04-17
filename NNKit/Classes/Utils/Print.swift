//
//  Print.swift
//  NNAcc
//
//  Created by ly on 2021/11/29.
//

import Foundation

public func printToConsole(message: String) {
    #if DEBUG
        print(message)
    #endif
}

public var showLog = true
public func printLog<T>(_ message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line) {
    #if DEBUG
        guard showLog else { return }
        let queue = Thread.isMainThread ? "UI" : "BG"
        print("\n 打印类型： <\(queue)> \n 打印时间： [\(Date.getNowTimeStr())] ; \n 所属类别： \((file as NSString).lastPathComponent)[\(line)] ；\n 所属方法： \(method) ; \n 打印结果： \n \(message) \n")
    #endif
}

public func printCurrentThread() {
    #if DEBUG
        print("currentThread: <\(Thread.current)>")
    #endif
}

public func printError<T>(_ message: T,
                   file: String = #file,
                   method: String = #function,
                   line: Int = #line) {
    #if DEBUG
        let queue = Thread.isMainThread ? "UI" : "BG"
        print("\n ‼️ Error错误信息：<\(queue)> ； \n 所属类别： \((file as NSString).lastPathComponent)[\(line)] ； \n 所属方法： \(method)  ; \n 打印结果 \(message) \n")
    #endif
}

// MARK: 返回className

extension NSObject {
    public var className: String {
        let name = type(of: self).description()
        if name.contains(".") {
            return name.components(separatedBy: ".")[1]
        }
        return name
    }
//    var ClassName: String {
//        let name = type(of: self).description()
//        if name.contains(".") {
//            return name.components(separatedBy: ".")[1]
//        }
//        return name
//    }
}
