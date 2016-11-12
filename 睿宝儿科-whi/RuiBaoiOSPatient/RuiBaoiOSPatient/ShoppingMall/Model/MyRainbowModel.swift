//
//  MyRainbowModel.swift
//  querendingdan
//
//  Created by whj on 16/6/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class MyRainbowModel: NSObject {
    var rainbowID = ""
    // 0：消耗 1、签到 2、分享 3、转发文章 4、绑定手机号
    var rainbowType = "0"
    var rainbowTime = ""
    var rainbowNumber = "0"
    
    
    class func setupMyRainbowModelsWithDictionarys(_ rainbows: [NSDictionary]) -> [MyRainbowModel] {
        
        print(rainbows)
        
        var models: [MyRainbowModel] = Array()
        
        for i in 0..<rainbows.count {
            let dict = rainbows[i]
            print(dict)
            
            let mdl = MyRainbowModel()
            if (dict["id"] != nil) {
                mdl.rainbowID = "\(dict["id"]!)"
            }
            print(mdl.rainbowID)
            
            mdl.rainbowType = "\(dict["type"]!)"
            
            let tt = "\(dict["createOn"]!)"
            let ss = (tt as NSString).substring(to: tt.characters.count - 3)
            let sss = Date.chatCellTimeStampToString(ss)
            let ssss = Date.dateWithStr(sss) ?? ""

            
            mdl.rainbowTime = ssss
            print(mdl.rainbowTime)
            mdl.rainbowNumber = "\(dict["coinNumber"]!)"
            
            
            models.append(mdl)
        }
        return models
    }
    
    
    
    
//    /**
//     *  当一个对象要归档进沙盒中时，就会调用这个方法
//     *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
//     */
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(rainbowID, forKey: "rainbowID")
//        aCoder.encodeObject(rainbowType, forKey: "rainbowType")
//        aCoder.encodeObject(rainbowTime, forKey: "rainbowTime")
//        aCoder.encodeObject(rainbowNumber, forKey: "rainbowNumber")
//    }
//    
//    /**
//     *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
//     *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
//     */
//    
//    override init() {
//        super.init()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        rainbowID = aDecoder.decodeObjectForKey("rainbowID") as? String ?? ""
//        rainbowType = aDecoder.decodeObjectForKey("rainbowType") as? String ?? ""
//        rainbowTime = aDecoder.decodeObjectForKey("rainbowTime") as? String ?? ""
//        rainbowNumber = aDecoder.decodeObjectForKey("rainbowNumber") as? String ?? ""
//    }
//
}
