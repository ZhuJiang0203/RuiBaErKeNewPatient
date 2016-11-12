//
//  ShiYanShiJianCha.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/15.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  实验室检查

import UIKit

class ShiYanShiJianCha: NSObject {

    // 类型
    var jianChaName = ""
    // 时间
    var jianChaTime = ""
//    // 异常指标
//    var yiChangZhiBiao = ""
    // 结果
    var jieGuo = ""
    
    
    class func getShiYanShiJianCha(_ laboratory: NSDictionary) -> ShiYanShiJianCha {
        
        LLog(laboratory)
        
        let model = ShiYanShiJianCha()
       
        // 血常规、尿常规等
        model.jianChaName = laboratory["projectCn"] as? String ?? ""
        
        // 日期
        if let ss = laboratory["date"] as? NSNumber {
            let time  = Date.chatCellTimeStampToString(ss.stringValue)
            if time.characters.count == 19 {
                model.jianChaTime = (time as NSString).substring(to: 10)
            }
        }
       
        // 结果
        model.jieGuo = laboratory["result"] as? String ?? ""

        return model
    }
}
