//
//  JiuZhenJiLu.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/15.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  接诊列表

import UIKit

class JiuZhenJiLu: NSObject {

    // 主诉
    var jiuZhenName = ""
    // 看诊时间
    var jiuZhenTime = ""
   
    // 记录号
    var jiLuHao = ""
    // 门诊类型
    var menZhenType = ""
    // 诊断
    var zhenDuan = ""
    // 记录人
    var jiLuRen = ""
    
    
    class func getJiuZhenJiLu(_ encounter: NSDictionary) -> JiuZhenJiLu {
        
        LLog(encounter)
        
        let model = JiuZhenJiLu()
        
        // 主诉
        model.jiuZhenName = encounter["chiefComplaint"] as? String ?? ""
    
        
        // 看诊日期
        if let ss = encounter["encounterDate"] as? NSNumber {
            let time = Date.chatCellTimeStampToString(ss.stringValue)
            if time.characters.count == 19 {
                model.jiuZhenTime = (time as NSString).substring(to: 10)
            }
        }
        
        // 记录号
        if let jiLuNo = encounter["encounterNo"] as? String {
            model.jiLuHao = jiLuNo
        }
        
        // 门诊类型
        if let type = encounter["encounterType"] as? NSNumber {
            
            var typeString = ""
            switch type.stringValue {
            case "1":
                typeString = "西医"
            case "2":
                typeString = "中医"
            default:
                typeString = "体检"
            }
            model.menZhenType = typeString
        }
        
        // 诊断
        if let zds = encounter["assessments"] as? [NSDictionary] {
            var zd = ""
            for dic in zds {
                let name = dic["problemName"] as? String ?? ""
                zd = zd + name + "、"
            }
            if zd.characters.count > 0 {
                zd = (zd as NSString).substring(to: zd.characters.count - 1)
            }
            model.zhenDuan = zd
        }
        
        // 记录人
        if ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental() == true { // 英文环境
            
            if let givenName = encounter["employeeGivenName"] as? String {
                model.jiLuRen = givenName + " "
            }
            if let familyName = encounter["employeeFamilyName"] as? String {
                model.jiLuRen = model.jiLuRen + familyName
            }
        } else { // 中文环境
                        
            if let familyName = encounter["employeeFamilyNameCn"] as? String {
                model.jiLuRen = familyName
            }
            if let givenName = encounter["employeeGivenNameCn"] as? String {
                model.jiLuRen = model.jiLuRen + givenName
            }
        }
        
        
        return model
    }
}
