//
//  NSDate+Extension.swift
//  Demo
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 小码哥. All rights reserved.
//

import UIKit

extension Date {
    static func dateWithStr(_ dateStr: String?) -> String? {
        if dateStr == nil {
            return ""
        }
        if dateStr!.characters.count != 19 {
            return dateStr
        }
        // 1. 创建时间格式化工具类
        let formatter = DateFormatter()
        // 2. 设置时间格式
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // 3. 设置时区(如果是真机一定要设置, 否则会出现未知问题)
        formatter.locale = Locale(identifier: "zh_CN")
        // 4. 将字符串转换为NSDate
        let data = formatter.date(from: dateStr!)
        // 5. 计算时间差
        if data == nil {
            return ""
        }
        return data!.computationTimeDifference()
    }
    
    // MARK: - 计算时间差
    func computationTimeDifference() -> String {
        // 5.1 创建日历类
        let calendar = Calendar.current
        // 5.2 处理时间
        if calendar.isDateInToday(self) { // 当天
            // 距离此时此刻的时间差（秒）
            let difference = Date().timeIntervalSince(self)
            if difference < 60 {
                return kJust
            } else if difference < 60*60 {
                return "\(Int(difference/60))\(kMinutesAgo)"
            } else {
                return "\(Int(difference/60/60))\(kHoursAgo)"
            }
        } else {
            // 5.2.1 创建时间格式化工具类
            let formatter2 = DateFormatter()
            // 5.2.2 设置时间格式
            formatter2.dateFormat = setUpDateFormat(calendar)
            // 5.2.3 设置时区(如果是真机一定要设置, 否则会出现未知问题)
            formatter2.locale = Locale(identifier: "zh_CN")
            // 5.2.4 将NSDate转换为字符串
            return  formatter2.string(from: self)
        }
    }
    
    // MARK: - 设置时间格式
    func setUpDateFormat(_ calendar: Calendar) -> String {
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(self) { // 昨天
            formatterStr = kYesterday
        } else {
            // 比较两个时间之间的差值
            let comps = (calendar as NSCalendar).components(NSCalendar.Unit.year, from: self, to: Date(), options:[])
            if comps.year == 0 { // 当年
                formatterStr = "MM-dd"
            } else { // 去年 或 更久
                formatterStr = "yyyy-MM-dd"
            }
        }
        return formatterStr
    }
    
    // MARK:- 时间戳->时间
    static func timeStampToString(_ timeStamp: String) -> String {
        
        var string = NSString(string: timeStamp)
        LLog(string)

        if string.length > 12 {
            string = string.substring(to: 10) as NSString
        }
        LLog(string)
        
        let timeSta: TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd"
        
        let date = Date(timeIntervalSince1970: timeSta)
        
        print(dfmatter.string(from: date))
        return dfmatter.string(from: date)
    }
    
    // MARK:- 时间戳->年龄
    static func setUpAgeWithBirthDay(_ timeStamp: String) -> String {

        // 生日时间
        var string = NSString(string: timeStamp)
        if string.length > 12 {
            string = string.substring(to: 10) as NSString
        }
        
        let timeSta: TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy"
        let date = Date(timeIntervalSince1970: timeSta)
        let birthString = dfmatter.string(from: date)
        let birthInt = Int(birthString) ?? 0
        
        // 当前日期
        let nowDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let nowString = formatter.string(from: nowDate)
        let nowInt = Int(nowString) ?? 0

        return "\(nowInt - birthInt)\(kAge)"
    }
    
    
    // MARK:- 时间戳->时间
    static func chatCellTimeStampToString(_ timeStamp: String) -> String {
        
        var string = NSString(string: timeStamp)
        LLog(string)
        
        if string.length > 12 {
            string = string.substring(to: 10) as NSString
        }
        LLog(string)
        
        let timeSta: TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = Date(timeIntervalSince1970: timeSta)
        
        print(dfmatter.string(from: date))
        return dfmatter.string(from: date)
    }
    
    
//    /****************** 添加提醒（本地通知） *****************/
//    func addRemindOfLocalNotification(_ remindText: String? = kNothing) -> UILocalNotification? {
//        
//        var seconds: TimeInterval = 0
//        switch remindText ?? "" {
//        case kWhenTheEventOccurs: // 事件发生时
//            seconds = 0
//        case k5MinutesAgo: // 5 分钟前
//            seconds = 5*60
//        case k15MinutesAgo: // 15 分钟前
//            seconds = 15*60
//        case k30MinutesAgo: // 30 分钟前
//            seconds = 30*60
//        case k1HoursAgo: // 1 小时前
//            seconds = 1*60*60
//        case k2HoursAgo: // 2 小时前
//            seconds = 2*60*60
//        case k1DaysAgo: // 1 天前
//            seconds = 1*24*60*60
//        case k2DaysAgo: // 2 天前
//            seconds = 2*24*60*60
//        case k1WeeksAgo: // 1 周前
//            seconds = 7*24*60*60
//        default:
//            seconds = 0
//        }
//
//        // 创建本地通知
//        let notification = UILocalNotification()
//
//        notification.fireDate = self.addingTimeInterval(seconds)
//        // MARK:- TODO
//        // 为什么一分钟重复一次呢？？？？（）待处理
////        notification.repeatInterval = NSCalendarUnit.Day // 一个世纪
//        notification.repeatInterval = NSCalendar.Unit(rawValue: 0) //NSCalendarUnit.Year // 一年
//        notification.timeZone = TimeZone.current // 使用本地时区
//        notification.applicationIconBadgeNumber += 1
//        notification.soundName = UILocalNotificationDefaultSoundName // "myMusic.caf"
//        
//        notification.alertBody = "通知内容" // 提示信息 弹出提示框
//        notification.alertAction = "打开"
//        
//        UIApplication.shared.scheduleLocalNotification(notification)
//        
//        return notification
//    }

}
