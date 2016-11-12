//
//  ShengMingTiZheng.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/15.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  生命体征

import UIKit

class ShengMingTiZheng: NSObject {
    
    var jiLuTime = "" // 急诊时间
    var tiWen = "" // 体温
    var maiBoHuXi = "" // 脉搏/呼吸
    var weightHeight = "" // 体重/身高
    var xueYangBaoHeDu = "" // 血氧饱和度
    var shouSuoYaShuZhangYa = "" // 收缩压/舒张压
    
    class func getShengMingTiZheng(_ dic: NSDictionary) -> ShengMingTiZheng {
        
        LLog(dic)
        
        let model = ShengMingTiZheng()
        
        // 记录时间
        if let ss = dic["encounterDate"] as? NSNumber {
            let time = ss.stringValue
            let tt  = Date.chatCellTimeStampToString(time)
            var timestring = ""
            if tt.characters.count == 19 {
                
//                let y = (tt as NSString).substringToIndex(4)
//                let m = (tt as NSString).substringWithRange(NSMakeRange(5, 2))
//                let d = (tt as NSString).substringWithRange(NSMakeRange(8, 2))
//                timestring = "\(y)\(kY)\(m)\(kM)\(d)\(kD)"
                
                timestring = (tt as NSString).substring(to: 10)
            }
            model.jiLuTime = timestring
        }
        
        // 体温
        var dushu = ""
        if let ss = dic["temperaturePosition"] as? NSNumber {
            switch ss.stringValue {
            case "1":
                dushu = "腋窝"
            case "2":
                dushu = "舌下"
            case "3":
                dushu = "直肠"
            case "4":
                dushu = "鼓膜"
            case "5":
                dushu = "额头"
            case "6":
                dushu = "皮肤"
            default:
                dushu = ""
            }
        }
        if let ss = dic["temperature"] as? NSNumber {
            dushu = dushu + ss.stringValue + "°C"
        }
        model.tiWen = dushu
        
        // 脉搏/呼吸
        var value = ""
        if let ss = dic["pules"] as? NSNumber {
            value = ss.stringValue + "/"
        }
        if let ss = dic["breathe"] as? NSNumber {
            value = value + ss.stringValue + " \(kFrequencyMinute)"
        }
        model.maiBoHuXi = value
        
        // 体重/身高
        var wh = ""
        if let ss = dic["weight"] as? NSNumber {
            wh = ss.stringValue + "kg/"
        }
        if let ss = dic["height"] as? NSNumber {
            wh = wh + ss.stringValue + "cm"
        }
        model.weightHeight = wh
        
        // 血氧饱和度
        if let ss = dic["spO2"] as? NSNumber {
            model.xueYangBaoHeDu = ss.stringValue + "%"
        }
        
        // 收缩压/舒张压
        var sz = ""
        if let ss = dic["systolicPressure"] as? NSNumber {
            sz = ss.stringValue + "/"
        }
        if let ss = dic["diastolicPressure"] as? NSNumber {
            sz = sz + ss.stringValue + "mmHg"
        }
        model.shouSuoYaShuZhangYa = sz
        
        
        return model
    }
}
