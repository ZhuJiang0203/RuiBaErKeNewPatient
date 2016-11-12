//
//  JiBingLieBiao.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/15.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  疾病列表

import UIKit

class JiBingLieBiao: NSObject {

    // 疾病名称
    var jiBingName = ""
    // 编码
    var ICD = ""
    // 类型
    var type = ""
    // 描述
    var descri = ""
    // 开始
    var startTime = ""
    // 结束
    var endTime = ""
    // 记录人
    var jiLuRen = ""

    
    class func getJiBingLieBiao(_ assessment: NSDictionary) -> JiBingLieBiao {
        
        LLog(assessment)
        
        let model = JiBingLieBiao()
    
        // 疾病名称
        model.jiBingName = assessment["problemName"] as? String ?? ""
        
        // 编码
        if let icd = assessment["icdNo"] as? String {
            model.ICD = "\(icd)"
        }
        
        // 类型
        if let type = assessment["type"] as? NSNumber {
            
            var typeString = ""
            switch type.stringValue {
            case "1":
                typeString = "急性"
            case "2":
                typeString = "慢性"
            default:
                typeString = "中医诊断"
            }
            model.type = typeString
        }
        
        // 描述
        if let des = assessment["memo"] as? String {
            model.descri = des
        }
        
        // 开始时间
        if let start = assessment["startDate"] as? NSNumber {
            let time  = Date.chatCellTimeStampToString(start.stringValue)
            if time.characters.count == 19 {
                model.startTime = (time as NSString).substring(to: 10)
            }
        }
        
        // 结束时间
        if let end = assessment["endDate"] as? NSNumber {
            let time  = Date.chatCellTimeStampToString(end.stringValue)
            if time.characters.count == 19 {
                model.endTime = (time as NSString).substring(to: 10)
            }
        }
        
        // 记录人
        if ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental() == true { // 英文环境
            if let givenName = assessment["employeeGivenName"] as? String {
                model.jiLuRen = givenName + " "
            }
            if let familyName = assessment["employeeFamilyName"] as? String {
                model.jiLuRen = model.jiLuRen + familyName
            }
        } else { // 中文环境
            if let familyName = assessment["employeeFamilyNameCn"] as? String {
                model.jiLuRen = familyName
            }
            if let givenName = assessment["employeeGivenNameCn"] as? String {
                model.jiLuRen = model.jiLuRen + givenName
            }
        }

        
        return model
    }
}
