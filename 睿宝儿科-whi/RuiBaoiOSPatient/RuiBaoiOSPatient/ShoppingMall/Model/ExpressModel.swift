//
//  ExpressModel.swift
//  querendingdan
//
//  Created by whj on 16/6/14.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class ExpressModel: NSObject {
    
    var expressID: String?
    var name: String?
    var phone: String?
    var provincialCityCounty: String? // 省市县
    var specificAddress: String?
    var selected: Bool = false
    // 是否是自取
    var isPickUp: Bool = false
    
    
    class func setupExpressModelsWithDictionarys(_ expresses: [NSDictionary]) -> [ExpressModel] {
        var models: [ExpressModel] = Array()
        
        for i in 0..<expresses.count {
            let dict = expresses[i]
            print(dict)
            
            let mdl = ExpressModel()
            if (dict["exPressAddressId"] != nil) {
                print(dict["exPressAddressId"]!)
                print("\(dict["exPressAddressId"]!)")
                mdl.expressID = "\(dict["exPressAddressId"]!)"
            }
            print(mdl.expressID)
            
            mdl.name = "\(dict["consigneeName"]!)"
            mdl.phone = "\(dict["mobile"]!)"
            print(mdl.phone)
            
            mdl.provincialCityCounty = "\(dict["region"]!)"
            mdl.specificAddress = "\(dict["detailAddress"]!)"

            
            models.append(mdl)
        }
        return models
    }
}
