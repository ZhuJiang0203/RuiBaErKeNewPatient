//
//  HeaderFile.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit


// T: 泛型
func LLog<T>(_ message: T, fileName: String = #file, line: Int = #line, method: String = #function) {
    /// Swift没有宏定义，
    #if DEBUG
        let file = (fileName as NSString).lastPathComponent
        print("\(file)[\(line)]---\(method)~~~\(message)~~~")
    #endif
}


/// RGB
func rgbColor(_ r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

/// RGBA
func rgbaColor(_ r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
}

/// RGB值一样的颜色
func rgbSameColor(_ rgb: CGFloat) -> UIColor {
    return rgbColor(rgb, g: rgb, b: rgb)
}

/// RGB值一样的颜色
func rgbaSameColor(_ rgb: CGFloat, a:CGFloat) -> UIColor {
    return rgbaColor(rgb, g: rgb, b: rgb, a: a)
}

/// 随机色
func randomColor() -> UIColor {
    return rgbColor(CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
}

let rgb50 = rgbSameColor(50)
let rgb51 = rgbSameColor(51)
let rgb102 = rgbSameColor(102)
let rgb153 = rgbSameColor(153)
let lineColor = rgbSameColor(224)
let rgb244 = rgbSameColor(243)


/// 屏幕宽
let kScreenWidth = UIScreen.main.bounds.width
/// 屏幕高
let kScreenHeight = UIScreen.main.bounds.height
let kMargin: CGFloat = 10
let kMargin15: CGFloat = 15
let kCellHeight: CGFloat = 50
let kRowMargin: CGFloat = 4
let kRadius: CGFloat = 4

let font8 = UIFont.systemFont(ofSize: 8)
let font9 = UIFont.systemFont(ofSize: 9)
let font10 = UIFont.systemFont(ofSize: 10)
let font11 = UIFont.systemFont(ofSize: 11)
let font12 = UIFont.systemFont(ofSize: 12)
let font13 = UIFont.systemFont(ofSize: 13)
let font14 = UIFont.systemFont(ofSize: 14)
let font15 = UIFont.systemFont(ofSize: 15)
let font16 = UIFont.systemFont(ofSize: 16)
let font17 = UIFont.systemFont(ofSize: 17)
let font18 = UIFont.systemFont(ofSize: 18)
let font19 = UIFont.systemFont(ofSize: 19)
let font20 = UIFont.systemFont(ofSize: 20)
let font21 = UIFont.systemFont(ofSize: 21)
let font22 = UIFont.systemFont(ofSize: 22)
let font23 = UIFont.systemFont(ofSize: 23)


let defaults = UserDefaults.standard




// 没有网络、3G、WIFI
let kChangeToNoNetwork = "kChangeToNoNetwork"
let kChangeTo3GNetwork = "kChangeTo3GNetwork"
let kChangeToWIFINetwork = "kChangeToWIFINetwork"

// 排班发生改变（新增排班 或 删除排班 或 复制排班到其它日期）
let kScheduleChanged = "kScheduleChanged"
// 刷新有排班的日期
let kRefreshScheduleDate = "RefreshScheduleDate"

let kStartToTelePhone = "StartToTelePhone"

// 通知ConsultationController注销第一响应者
let kNotificatConsultationControllerResignFirst = "NotificatConsultationControllerResignFirst"


// 分享成功、失败、取消
let kShareSuccess = "kShareSuccess"
let kShareFailed = "kShareFailed"
let kShareCancle = "kShareCancle"
// 登录成功、失败、取消
let kLogSuccess = "kLogSuccess"
let kLogFailed = "kLogFailed"
let kLogCancle = "kLogCancle"


let kSearchArticlesArrayKey = "SearchArticlesArrayKey"
let kSearchDoctorsArrayKey = "SearchDoctorsArrayKey"
let kIsEnglishKey = "IsEnglishKey"




// appID
// 睿宝
let kAppID = "1109217521"
// 连康
//let kAppID = "1136976034"




// 第三方信息
// 友盟
let kUmengAppKey = "571474ba67e58e1867000be5"
// 微信
let kWeiXinAppID = "wxa5a3d9d22964afa1"
let kWeiXinAppSecret = "d7465f0f061c6a02a6085e3a5a4f7931"
let kWeiXinAppURL = "http://www.rainbowhealth.cn"
// 微博
let kWeiBoAppID = "1109217521"
let kWeiBoAppKey = "237480738"
let kWeiBoAppSecret = "efe3dd5eb715f143834ca19c1ae15a58"
let kWeiBoAppAdress = "https://www.apple.com/itunes/"
// QQ
let kQQAPPID = "1105295189"
let kQQAPPKEY = "uqX3eoXng3weZ01o"
let kQQAPPURL = "https://www.apple.com"
// 环信
let kHuanXinAPPKEY = "connehealth-patientanddoctor#connehealthpd"
let kHuanXinApnsCertName = ""






// 患者信息
let kOrganizationIDKey = "OrganizationIDKey" // 机构id
let kPracticeIDKey = "PracticeIDKey" // 诊所id
let kPatientIDKey = "kPatientIDKey" // 患者id
let kPatientTockenKey = "PatientTockenKey" // tocken
let kPatientIconKey = "PatientIconKey" // 头像
let kPatientIconURLStringKey = "PatientIconURLStringKey" // 头像
let kPatientIconImageKey = "PatientIconImageKey" // 头像
let kPatientSexKey = "PatientSexKey" // 性别
let kPatientAgeKey = "PatientSexKey" // 性别
let kPatientNameKey = "PatientNameKey" // 中文名字
let kPatientEnglishNameKey = "PatientEnglishNameKey" // 英文名字
let kPatientUserNameKey = "PatientUserNameKey" // 用户名
let kUserIconUIImageKey = "UserIconUIImageKey" // 用户头像



// 最近签到日期
let kRecentSignDateKey = "kRecentSignDateKey"
// 彩虹币总值
let kRainbowCoinValueKey = "kRainbowCoinValueKey"
// 连续签到天数
let kContinuitySignDaysKey = "kContinuitySignDaysKey"
// 通过签到获得彩虹币数组
let kRainbowCoinsArrayKey = "kRainbowCoinsArrayKey"
// 通过签到获得彩虹币对应的时间数组
let kGetRainbowCoinsTimeArrayKey = "kGetRainbowCoinsTimeArrayKey"




// 换肤
let kAppSkinNumberKey = "AppSkinNumberKey"

// 提醒打开 系统通知 的次数
let kReminderOpenSystemNotificationNumber = "ReminderOpenSystemNotificationNumber"







// 正式环境
let kBaseUrlString = "http://connehealth.cn/lkHealth.Mobile-1.0.0/rest/"
//let kBaseUrlString = "http://www.connehealth.cn:8080/lkHealth.Mobile-1.0.0/rest/"


// 测试环境
//let kBaseUrlString = "http://172.16.0.3:8080/lkHealth.Mobile-1.0.0/rest/"
//let kBaseUrlString = "http://172.16.0.14:8080/rest/"


//// 患者测试路径
//let kBaseUrlString = "http://101.201.212.34/rainbowapp.back-1.0.0/rest"
////let kBaseUrlString =  "http://172.16.0.3:8080/rainbowapp.back-1.0.0/rest"

let kIsResignHuanXin = "IsResignHuanXin"




