//
//  RecordSectionModel.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/7/19.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class RecordSectionModel: NSObject {
   
    // 生命体征
    var shengMingTiZhengs = [ShengMingTiZheng]()
    // 过敏列表
    var guoMinLieBiaos = [GuoMinLieBiao]()
//    // 既往史
//    var jiWangShi = JiWangShi()
//    // 家族史
//    var jiaZuShi = JiaZuShi()
    // 疾病列表
    var jiBingLieBiaos = [JiBingLieBiao]()
    // 用药列表
    var yongYaoLieBiaos = [YongYaoLieBiao]()
    // 疫苗列表
    var yiMiaoLieBiaos = [YiMiaoLieBiao]()
    // 实验室检查
    var shiYanShiJianChas = [ShiYanShiJianCha]()
    // 就诊记录
    var jiuZhenJiLus = [JiuZhenJiLu]()

    
    class func setupRecordSectionModelWithDictionary(_ dictionary: NSDictionary) -> RecordSectionModel {

        LLog(dictionary)
        
        let sectionModel = RecordSectionModel()
        
        
        // 生命体征
        if let vitalSigns = dictionary["vitalSigns"] as? [NSDictionary] {
            for dic in vitalSigns {
                let model = ShengMingTiZheng.getShengMingTiZheng(dic)
                sectionModel.shengMingTiZhengs.append(model)
            }
        }

        
        // 过敏列表
        if let allergies = dictionary["allergies"] as? [NSDictionary] {
            for allergie in allergies {
                let model = GuoMinLieBiao.getGuoMinLieBiao(allergie)
                sectionModel.guoMinLieBiaos.append(model)
            }
        }
        
        
        
//        // 既往史
//        if var previousHistory = dictionary["previousHistory"] as? String {
//            
//            if previousHistory.characters.count > 7 {
//                previousHistory = previousHistory.stringByReplacingOccurrencesOfString("<p>", withString: "")
//                previousHistory = previousHistory.stringByReplacingOccurrencesOfString("</p>", withString: "")
//            }
//            sectionModel.jiWangShi.jiWangShiString = previousHistory
//        }
//        
//        
//        
//        // 家族史
//        if var familyHistory = dictionary["familyHistory"] as? String {
//
//            if familyHistory.characters.count > 7 {
//                familyHistory = familyHistory.stringByReplacingOccurrencesOfString("<p>", withString: "")
//                familyHistory = familyHistory.stringByReplacingOccurrencesOfString("</p>", withString: "")
//            }
//            sectionModel.jiaZuShi.JiaZuShiString = familyHistory
//        }
        

        
        // 疾病列表
        if let assessments = dictionary["assessments"] as? [NSDictionary] {

            for assessment in assessments {
                let model = JiBingLieBiao.getJiBingLieBiao(assessment)
                sectionModel.jiBingLieBiaos.append(model)
            }
        }
        
        
        
        // 用药列表
        if let encounterDrugs = dictionary["encounterDrugs"] as? [NSDictionary] {

            for encounterDrug in encounterDrugs {
                let model = YongYaoLieBiao.getYongYaoLieBiao(encounterDrug)
                sectionModel.yongYaoLieBiaos.append(model)
            }
        }
        
        
        
        
        // 疫苗列表
        if let encounterVccines = dictionary["encounterVccines"] as? [NSDictionary] {

            for encounterVccine in encounterVccines {
                let model = YiMiaoLieBiao.getYiMiaoLieBiao(encounterVccine)
                sectionModel.yiMiaoLieBiaos.append(model)
            }
        }
        
        
        
        
        // 实验室检查
        if let laboratorys = dictionary["laboratorys"] as? [NSDictionary] {

            for laboratory in laboratorys {
                let model = ShiYanShiJianCha.getShiYanShiJianCha(laboratory)
                sectionModel.shiYanShiJianChas.append(model)
            }
        }
        
        
        
        // 就诊列表
        if let encounters = dictionary["encounters"] as? [NSDictionary] {

            for encounter in encounters {
                let model = JiuZhenJiLu.getJiuZhenJiLu(encounter)
                sectionModel.jiuZhenJiLus.append(model)
            }
        }
        
        
        return sectionModel
    }
}
