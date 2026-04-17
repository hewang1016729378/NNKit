//
//  Date+Extensions.swift
//  NNAcc
//
//  Created by ly on 2021/12/1.
//

import Foundation

extension Date {
    /// 时间戳转为格式化时间
    ///
    /// - Parameter stamp: 时间戳
    /// - Returns: 格式化时间
    static public func toMessageString(stamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: stamp)
        return toMessageString(date)
    }
    /// 时间戳转日期
    static public func toFormateString(stamp: TimeInterval, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let date = Date(timeIntervalSince1970: stamp)
        return Date.dateFormatString(date,dateFormat: dateFormat)
    }


    /// Date对象转e为格式化时间
    ///
    /// - Parameter date: date对象，默认为当前时间Date()
    /// - Returns: 格式化时间
    static public func toMessageString(_ date: Date = Date()) -> String {
        let currentComps = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        let yourComps = Calendar.current.dateComponents([.day, .weekday, .month, .year], from: date)
        let dataFmt = DateFormatter()

        // 我们认为获取当前时间总是有效的
        guard yourComps.year != nil,
              yourComps.month != nil,
              yourComps.day != nil else {
            return "无效时间"
        }

        if currentComps.year != yourComps.year { // 时间段跨年
            dataFmt.dateFormat = "yyyy年MM月dd日 HH:mm"
        } else {
            if currentComps.month! - yourComps.month! != 0 { // 时间段跨月
                dataFmt.dateFormat = "MM月dd日 HH:mm"
            } else {
                if currentComps.day == yourComps.day { // 当天时间
                    dataFmt.dateFormat = "HH:mm"
                } else if currentComps.day! - yourComps.day! == 1 { // 昨天时间
                    dataFmt.dateFormat = "昨天 HH:mm"
                } else {
                    if currentComps.day! - yourComps.day! <= 7 {
                        switch yourComps.weekday {
                        case 1:
                            dataFmt.dateFormat = "星期日 HH:mm"
                        case 2:
                            dataFmt.dateFormat = "星期一 HH:mm"
                        case 3:
                            dataFmt.dateFormat = "星期二 HH:mm"
                        case 4:
                            dataFmt.dateFormat = "星期三 HH:mm"
                        case 5:
                            dataFmt.dateFormat = "星期四 HH:mm"
                        case 6:
                            dataFmt.dateFormat = "星期五 HH:mm"
                        case 7:
                            dataFmt.dateFormat = "星期六 HH:mm"
                        default:
                            break
                        }
                    } else {
                        dataFmt.dateFormat = "MM月dd日 HH:mm"
                    }
                }
            }
        }
        return dataFmt.string(from: date)
    }

    public var timeStamp: Int {
        let timeInterval: TimeInterval = timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }

    // 转成当前时区的⽇期
    static public func dateFromGMT(_ date: Date) -> Date {
        let secondFromGMT = TimeInterval(TimeZone.current.secondsFromGMT(for: date))
        return date.addingTimeInterval(secondFromGMT)
    }

    static public func updateTimeToCurrentTime(date: Date) -> String {
        var dateString = ""
        let str1 = dateFormatString(Date(), dateFormat: "yyyy-MM-dd")
        let str2 = dateFormatString(date, dateFormat: "yyyy-MM-dd")
        if str1.compare(str2) == .orderedSame {
            dateString = dateFormatString(date, dateFormat: "HH:mm")
        } else if str1.compare(str2) == .orderedDescending {
            dateString = dateFormatString(date, dateFormat: "yyyy年MM月dd日 HH:mm")
        }
        return dateString
    }

    // 日期 -> 字符串
    static public func dateFormatString(_ date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }

    public var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }

    public var twoDaysAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }

    public var threeDaysAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }

    public var fourDaysAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }

    public var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }

    public var twoHoursAgo: Date {
        return Calendar.current.date(byAdding: .hour, value: -2, to: noon)!
    }

    public var fiveHoursAgo: Date {
        return Calendar.current.date(byAdding: .hour, value: -5, to: noon)!
    }

    public var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    public var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }

    static public func getNowTimeStr() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 自定义时间格式
        let time = dateformatter.string(from: Date())
        return time
    }
    /*
     * 获取某个Date的小时和分
     */
    public func getHourAndMinute() -> String{
        let dateFormatter = DateFormatter()
//        let utcTimeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.timeZone = utcTimeZone
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}



extension String {
    // MARK: - 字符串转时间戳
    static public func getTimestampWithTime(_ dateStr: NSString) -> NSString {
        var strTime: NSString = ""
        if dateStr.length > 19 {
            strTime = dateStr.substring(to: 19) as NSString
        } else {
            strTime = dateStr
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date: Date = formatter.date(from: strTime as String) ?? Date()
        let t = date.timeIntervalSince1970
        var timestamp: NSString = "\(t)" as NSString
        timestamp = timestamp.substring(to: timestamp.length - 2) as NSString

        return timestamp
    }
    
    /// 根据字符串返回日期
    /// - Parameter formart:
    /// - Returns: 
    public func getDateFromDateString(_ formart: NSString = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
         formatter.dateFormat = formart as String
        let date: Date = formatter.date(from: self as String) ?? Date()
        return date
    }


}
