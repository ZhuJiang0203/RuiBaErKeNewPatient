//
//  YongYaoLieBiao.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/15.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  用药列表

import UIKit


// 使用方法
private var methodes = ["口服", "吸入", "舌下", "外涂", "喷鼻", "喷咽", "外洗",
                        "皮内注射", "皮下注射", "静脉注射", "静脉滴注", "肌肉注射", "肌肉滴注", "皮试后",
                        "皮下", "皮试", "滴眼", "滴耳", "贴剂", "局部", "经皮给药",
                        "眼部", "右耳", "左耳", "双耳", "右眼", "左眼", "双眼"]
// 使用频次
private var pincis = ["每天1次", "每天2次", "每天3次", "每天4次", "一周1次", "一周2次", "12小时1次",
                      "1小时1次", "2小时1次", "3小时1次", "4小时1次", "6小时1次", "8小时1次", "每晚",
                      "每晨", "隔天1次", "每两天1次", "每周1次", "每周", "适量", "用法口授,遵照医嘱",
                      "标记", "用法", "立即", "根据医嘱", "其他"]
// 单位
private var danweis = ["mg"]

// 时间
private var times = ["睡前", "晨起", "饭前", "饭后", "立即", "需要时", "空腹时",
                     "根据医嘱", "上午", "下午", "其他"]
// 持续
private var persists = ["1天", "2天", "3天", "4天", "5天",
                        "6天", "7天", "8天", "9天", "10天",
                        "11天", "12天", "13天", "14天", "15天",
                        
                        "16天", "17天", "18天", "19天", "20天",
                        "21天", "22天", "23天", "24天", "25天",
                        "26天", "27天", "28天", "29天", "30天",
                        
                        "1周", "2周", "3周", "4周", "5周",
                        "6周", "7周", "8周", "9周", "10周",
                        "11周", "12周", "1月", "2月", "3月"]



class YongYaoLieBiao: NSObject {

    // 药品名
    var yongYaoName = ""
    // 用法
    var yongFa = ""
    // 开始时间
    var startTime = ""
    // 结束时间
    var endTime = ""
    // 记录人
    var jiLuRen = ""
    
    
    class func getYongYaoLieBiao(_ encounterDrug: NSDictionary) -> YongYaoLieBiao {
        
        LLog(encounterDrug)
        
        let model = YongYaoLieBiao()
        
        // 用法
        // 使用方法
        if let fangfa = encounterDrug["method"] as? String {
            model.yongFa = methodes[Int(fangfa)! - 1] + " "
        }
        LLog(model.yongFa)
        // 使用频次
        if let pinci = encounterDrug["timesUse"] as? NSNumber {
            model.yongFa = model.yongFa + pincis[Int(pinci) - 1] + " "
        }
        LLog(model.yongFa)
        // 每次使用剂量
        if let jiLiang = encounterDrug["dosage"] as? NSNumber {
            model.yongFa = model.yongFa + "\(jiLiang)"
        }
        LLog(model.yongFa)
        // 单位 ？？？（待调整）
        model.yongFa = model.yongFa + "mg "
        LLog(model.yongFa)

        // 时间（饭后）
        if let time = encounterDrug["time"] as? NSNumber {
            model.yongFa = model.yongFa + times[Int(time) - 1] + " "
        }
        LLog(model.yongFa)
        // 持续（1周）
        if let chixu = encounterDrug["persist"] as? NSNumber {
            model.yongFa = model.yongFa + persists[Int(chixu) - 1] + " "
        }
        LLog(model.yongFa)
        
        // 开始时间
        if let start = encounterDrug["startDate"] as? NSNumber {
            let time  = Date.chatCellTimeStampToString(start.stringValue)
            if time.characters.count == 19 {
                model.startTime = (time as NSString).substring(to: 10)
            }
        }
        
        // 结束时间
        if let end = encounterDrug["endDate"] as? NSNumber {
            let time  = Date.chatCellTimeStampToString(end.stringValue)
            if time.characters.count == 19 {
                model.endTime = (time as NSString).substring(to: 10)
            }
        }
        
        // 药物名称、记录人
        if ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental() == true { // 英文环境

            model.yongYaoName = encounterDrug["name"] as? String ?? ""

            if let givenName = encounterDrug["employeeGivenName"] as? String {
                model.jiLuRen = givenName + " "
            }
            if let familyName = encounterDrug["employeeFamilyName"] as? String {
                model.jiLuRen = model.jiLuRen + familyName
            }
        } else { // 中文环境

            model.yongYaoName = encounterDrug["nameCn"] as? String ?? ""

            if let familyName = encounterDrug["employeeFamilyNameCn"] as? String {
                model.jiLuRen = familyName
            }
            if let givenName = encounterDrug["employeeGivenNameCn"] as? String {
                model.jiLuRen = model.jiLuRen + givenName
            }
        }

        
        return model
    }
}
