//
//  ClinicModel.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/7/12.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  诊所

import UIKit

class ClinicModel: NSObject {

    // type == 1：机构，type == 2：诊所
    var type: String = ""
    
    // orgId：机构id
    var orgId: String = ""
    // id（type == 1：机构id，type == 2：诊所id）
    var Id: String = ""
    // name（type == 1：机构名称，type == 2：诊所名称）
    var name: String?
    var nameCn: String?
    
    
    
    
    class func setupClinicModelsWithDictionarys(_ clinics: [NSDictionary]) -> [ClinicModel] {
        var models: [ClinicModel] = Array()
        
        for i in 0..<clinics.count {
            let dict = clinics[i]
            LLog(dict)
            
            let clinic = ClinicModel()
            
            if let type = dict["type"] as? NSNumber {
                clinic.type = type.stringValue
            }
            
            if let orgId = dict["orgId"] as? NSNumber {
                clinic.orgId = orgId.stringValue
            }
            
            if let Id = dict["id"] as? NSNumber {
                clinic.Id = Id.stringValue
            }
            
            clinic.name = dict["name"] as? String
            clinic.nameCn = dict["nameCn"] as? String

            models.append(clinic)
        }
        return models
    }

}
