//
//  Int+Extension.swift
//  NNHost
//
//  Created by ly on 2022/1/15.
//

import Foundation

public extension Int {
    /* 这是一个内置函数
     lower : 内置为 0，可根据自己要获取的随机数进行修改。
     upper : 内置为 UInt32.max 的最大值，这里防止转化越界，造成的崩溃。
     返回的结果： [lower,upper) 之间的半开半闭区间的数。
     */
    static func randomIntNumber(lower: Int = 0, upper: Int = Int(UInt32.max)) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
    }

    /**
     生成某个区间的随机数
     */
    static func randomIntNumber(range: Range<Int>) -> Int {
        return randomIntNumber(lower: range.lowerBound, upper: range.upperBound)
    }
    
    /// 秒数转化为时间字符串 eg:"02:29:59"
    public func secondsConvertTime() -> String {
        // 天数计算
//        let days = self / (24 * 3600)

        // 小时计算
        let hours = self / 3600

        // 分钟计算
        let minutes = self % 3600 / 60

        // 秒计算
        let second = self % 60

        let timeString = String(format: "%02lu：%02lu：%02lu", hours, minutes, second)
        return timeString
    }
    
}

public extension Double {
    /// 四舍五入 到小数点后某一位
    public func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    /// 截断 到小数点后某一位
    public func truncate(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Double(Int(self * divisor)) / divisor
    }
}
