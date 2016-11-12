//
//  NetworkTools.swift
//  XMGWeibo
//
//  Created by apple on 15/9/29.
//  Copyright © 2015年 小码哥. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {

//    private static let tools: NetworkTools = {
//        let url = NSURL(string: kBaseUrlString)!
//        
//        LLog(url)
//        let manager = NetworkTools(baseURL: url)
//        
////        let manager = NetworkTools()
//
//        // 设置了AFN可以接收得数据类型
//        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
//        
//        let token = defaults.stringForKey(kPatientTockenKey)!
//        manager.requestSerializer.setValue(token, forHTTPHeaderField: "token")
//        
//        return manager
//    }()
    
    class func shareNetworkTools() -> NetworkTools {
        
        let url = URL(string: kBaseUrlString)!
        
        let manager = NetworkTools(baseURL: url)
        
        // 设置了AFN可以接收得数据类型
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        
        let token = defaults.string(forKey: kPatientTockenKey)!
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "token")
        
        LLog(token)

        return manager
    }
    
    
    
    
    
    
    
    
    class func shareImageNetworkTools() -> NetworkTools{
        
        let url = URL(string: kBaseUrlString)!
        let manager = NetworkTools(baseURL: url)
        
        // 设置了AFN可以接收得数据类型
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "image/jpeg", "text/javascript", "text/plain") as? Set<String>
        
        let token = defaults.string(forKey: kPatientTockenKey)!
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "token")
        
        manager.responseSerializer = AFHTTPResponseSerializer()

        
        return manager
    }
    
//    private static let imageTools: NetworkTools = {
//        let url = NSURL(string: kBaseUrlString)!
//        let manager = NetworkTools(baseURL: url)
//        
//        // 设置了AFN可以接收得数据类型
//        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "image/jpeg", "text/javascript", "text/plain") as? Set<String>
//        
//        let token = defaults.stringForKey(kPatientTockenKey)!
//        manager.requestSerializer.setValue(token, forHTTPHeaderField: "token")
//
//        manager.responseSerializer = AFHTTPResponseSerializer()
//        
//        return manager
//    }()
}
