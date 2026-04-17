//
//  ZJKillTimer.swift
//  ZJTimerDemo
//
//  Created by Javen on 2019/3/18.
//  Copyright © 2019 Javen. All rights reserved.
//

import UIKit

public class ZJKillTimer {
    /// 活动结束秒数
    public var secondsToEnd: Int = 0

    public var myTimer: ZJTimer!
    public var callBack: ((Int) -> Void)?

    public init(seconds: Int, callBack: ((Int) -> Void)?) {
        secondsToEnd = seconds
        myTimer = ZJTimer.scheduledTimer(timeInterval: TimeInterval(ZJKillTimer.interval), target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
        // 如果希望对Timer做自定义的操作，使用_Timer属性
        RunLoop.current.add(myTimer._timer, forMode: RunLoop.Mode.common)
        myTimer.fire()
        self.callBack = callBack
    }

    deinit {
        myTimer.invalidate()
    }

    @objc func timerRun() {
        secondsToEnd -= 1
        if secondsToEnd == 0 {
            myTimer.invalidate()
        }
        callBack?(secondsToEnd)
    }
}
extension ZJKillTimer{
     
    static  public var interval: Double = 1.0

}
