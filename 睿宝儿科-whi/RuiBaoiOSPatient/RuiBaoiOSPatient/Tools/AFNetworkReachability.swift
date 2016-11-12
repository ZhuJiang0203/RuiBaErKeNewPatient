//
//  AFNetworkReachability.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/11.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  实时监测网络状态

import UIKit
import AFNetworking

class AFNetworkReachability: NSObject {
    var stateOfNetwork = 0
     
    class func shareNetworkTools() -> AFNetworkReachability{
        return networkReachability
    }
    
    fileprivate static let networkReachability: AFNetworkReachability = {
        let networkReachability = AFNetworkReachability()
        return networkReachability
    }()

    func networkReachabilityStatus() {
        let mgr = AFNetworkReachabilityManager.shared()
        mgr.setReachabilityStatusChange { (status) in
            switch status {
            case AFNetworkReachabilityStatus.notReachable: // 没有网络
                self.stateOfNetwork = 11
                // 每次由无网络->有网络，都会先执行这里，再执行AFNetworkReachabilityStatus.ReachableViaWiFi。为了避免错误提示，故做下面延时操作。（待完善）
//                dispatch_after(dispatch_time(dispatch_time_t(DispatchTime.now), Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                    if self.stateOfNetwork == 11 {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kChangeToNoNetwork), object: nil)
                    }
//                }
            case AFNetworkReachabilityStatus.reachableViaWWAN: // 3G
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kChangeTo3GNetwork), object: nil)
                self.stateOfNetwork = 22
            case AFNetworkReachabilityStatus.reachableViaWiFi: // WIFI 
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kChangeToWIFINetwork), object: nil)
                self.stateOfNetwork = 33
            default: // 位置网络
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kChangeToNoNetwork), object: nil)
                self.stateOfNetwork = 11
            }
        }
        // 开始监控
        mgr.startMonitoring()
    }
}
