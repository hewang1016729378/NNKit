//
//  GCDUtils.swift
//  NNHost
//
//  Created by Leigod on 2022/3/15.
//

import Foundation

public class GCDUtils {
    /// 主线程执行
    ///
    /// - Parameter block: 回调
    public class func main(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async { block() }
        }
    }

    /// 指定队列, 异步执行
    ///
    /// - Parameters:
    ///   - queue: 队列名字，默认是主队列
    ///   - block: 回调
    public class func async(_ queue: DispatchQueue = DispatchQueue.main, block: @escaping () -> Void) {
        queue.async { block() }
    }

    /// 后台队列, 异步执行
    ///
    /// - Parameter block: 回调
    public class func asyncBackground(_ block: @escaping () -> Void) {
        async(DispatchQueue.global(qos: .background), block: block)
    }

    /// 延迟执行
    ///
    /// - Parameters:
    ///   - seconds: 延迟时间
    ///   - queue: 队列名字, 默认是主队列
    ///   - block: 回调
    public class func delay(_ seconds: TimeInterval, queue: DispatchQueue = DispatchQueue.main, block: @escaping () -> Void) {
        queue.asyncAfter(deadline: DispatchTime.now() + seconds) { () -> Void in
            block()
        }
    }
}

// MARK: 合并多个请求，创建Group

public extension DispatchGroup {
    /// 一键创建Group，合并网络请求
    /// - Parameters:
    ///   - didEnter: 这里处理所有Enter和level
    ///   - work: 所有请求结束，将在 main线程 执行这个work
    public static func create(
        _ didEnter: (_ group: DispatchGroup) -> Void,
        execute work: @escaping @convention(block) () -> Void) {
        let group = DispatchGroup()
        didEnter(group)
        group.notify(queue: .main, execute: work)
    }
}
