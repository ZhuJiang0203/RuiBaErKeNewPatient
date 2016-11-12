//
//  GuoMinLieBiao.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/15.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  过敏列表

import UIKit

class GuoMinLieBiao: NSObject {
    
    // 过敏源
    var guoMinYuan = ""
    // 过敏程度
    var guoMinChengDu = ""
    // 过敏类型
    var guoMinType = ""
    // 反应
    var fanYing = ""
    // 开始
    var start = ""
    // 结束
    var end = ""
    // 记录人
    var jiLuRen = ""
    
    
    class func getGuoMinLieBiao(_ allergie: NSDictionary) -> GuoMinLieBiao {
        
        LLog(allergie)
        
        let model = GuoMinLieBiao()
        
        // 过敏源名称
        model.guoMinYuan = allergie["allergenName"] as? String ?? ""
        
        // 严重程度
        if let severity = allergie["severity"] as? NSNumber {
            var sev = ""
            switch severity.stringValue {
            case "1":
                sev = "轻微"
            case "2":
                sev = "中度"
            default:
                sev = "严重"
            }
            // 过敏程度
            model.guoMinChengDu = sev
        }
        
        // 过敏类型
        if let severity = allergie["allergyType"] as? NSNumber {
            var type = ""
            switch severity.stringValue {
            case "1":
                type = "环境"
            case "2":
                type = "药品"
            default:
                type = "食品"
            }
            // 过敏程度
            model.guoMinType = type
        }
        
        // 反应
        model.fanYing = allergie["reactions"] as? String ?? ""
        
        // 开始
        model.start = allergie["start"] as? String ?? ""

        // 结束
        model.end = allergie["end"] as? String ?? ""

        // 记录人
        if ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental() == true { // 英文环境
            if let givenName = allergie["employeeGivenName"] as? String {
                model.jiLuRen = givenName + " "
            }
            if let familyName = allergie["employeeFamilyName"] as? String {
                model.jiLuRen = model.jiLuRen + familyName
            }
        } else { // 中文环境
            if let familyName = allergie["employeeFamilyNameCn"] as? String {
                model.jiLuRen = familyName
            }
            if let givenName = allergie["employeeGivenNameCn"] as? String {
                model.jiLuRen = model.jiLuRen + givenName
            }
        }
        
    
        return model
    }
}
