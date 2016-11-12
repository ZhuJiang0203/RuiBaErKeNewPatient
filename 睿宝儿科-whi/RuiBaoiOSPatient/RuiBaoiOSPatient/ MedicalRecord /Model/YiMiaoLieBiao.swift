//
//  YiMiaoLieBiao.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/15.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  疫苗列表

import UIKit

class YiMiaoLieBiao: NSObject {

    // 疫苗名
    var yiMiaoName = ""
    // 方法
    var fangFa = ""
    // 位置
    var weiZhi = ""
    // 剂量
    var jiLinag = ""
    // 次数
    var ciShu = ""
    // 时间
    var yiMiaoTime = ""
    // 记录人
    var jiLuRen = ""

    
    class func getYiMiaoLieBiao(_ encounterVccine: NSDictionary) -> YiMiaoLieBiao {
        
        LLog(encounterVccine)
        
        let model = YiMiaoLieBiao()
        
        model.yiMiaoTime = encounterVccine[""] as? String ?? ""

        // 方法
        if let way = encounterVccine["way"] as? NSNumber {
            switch way {
            case 1:
                model.fangFa = "皮内注射"
            case 2:
                model.fangFa = "皮下注射"
            case 3:
                model.fangFa = "肌肉注射"
            case 4:
                model.fangFa = "口服"
            default:
                model.fangFa = ""
            }
        }
        
        // 位置
        if let position = encounterVccine["position"] as? NSNumber {
            switch position {
            case 1:
                model.weiZhi = "左手臂"
            case 2:
                model.weiZhi = "右手臂"
            case 3:
                model.weiZhi = "左腿"
            case 4:
                model.weiZhi = "右腿"
            case 5:
                model.weiZhi = "左臀"
            case 6:
                model.weiZhi = "右臀"
            default:
                model.weiZhi = "无"
            }
        }

        // 剂量
        if let dosage = encounterVccine["dosage"] as? NSNumber {
            model.jiLinag = "\(dosage)"
        }
        
        // 单位 ？？？（待调整）
        model.jiLinag = model.jiLinag + "ML"

        // 次数
        if let times = encounterVccine["times"] as? NSNumber {
            model.ciShu = "\(times)"
        }

        // 时间
        if let start = encounterVccine["date"] as? NSNumber {
            let time  = Date.chatCellTimeStampToString(start.stringValue)
            if time.characters.count == 19 {
                model.yiMiaoTime = (time as NSString).substring(to: 10)
            }
        }

        // 疫苗名称、记录人
        if ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental() == true { // 英文环境
            
            model.yiMiaoName = encounterVccine["name"] as? String ?? ""
            
            if let givenName = encounterVccine["employeeGivenName"] as? String {
                model.jiLuRen = givenName + " "
            }
            if let familyName = encounterVccine["employeeFamilyName"] as? String {
                model.jiLuRen = model.jiLuRen + familyName
            }
        } else { // 中文环境
            
            model.yiMiaoName = encounterVccine["nameCn"] as? String ?? ""
            
            if let familyName = encounterVccine["employeeFamilyNameCn"] as? String {
                model.jiLuRen = familyName
            }
            if let givenName = encounterVccine["employeeGivenNameCn"] as? String {
                model.jiLuRen = model.jiLuRen + givenName
            }
        }
        

        return model
    }
}
