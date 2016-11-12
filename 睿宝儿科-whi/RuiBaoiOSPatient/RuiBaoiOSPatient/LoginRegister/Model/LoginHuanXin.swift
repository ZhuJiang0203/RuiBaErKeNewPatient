//
//  LoginHuanXin.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/31.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class LoginHuanXin: NSObject {

//    private var customLoadTip: CustomLoadTip?

    class func shareLoginHuanXin() -> LoginHuanXin{
        return hx
    }
    
    fileprivate static let hx: LoginHuanXin = {
        let hx = LoginHuanXin()
        return hx
    }()
    
    /// 注册 环信
    func setupRegisterHuanXin(hxUsername: String? = "", hxPassword: String? = "") -> Bool {
        
//        customLoadTip = CustomLoadTip.showLoadTip(nil)
        
        let organizationID = defaults.object(forKey: kOrganizationIDKey) as? String ?? ""
        let patientID = defaults.object(forKey: kPatientIDKey) as? String ?? ""
        // 环信 用户名、密码
        let hxUsername = organizationID + "-pt" + patientID
        let hxPassword = "patient\(organizationID)\(patientID)"
        

        
        let error =  EMClient.shared().register(withUsername: hxUsername, password: hxPassword)
        if (error == nil) { // 注册成功
            // 保存到本地
//            defaults.setValue("true", forKey: kIsResignHuanXin)
            // 登录环信
            return setupLoginHuanXin(hxUsername: hxUsername, hxPassword: hxPassword)
        } else {
            LLog(error?.code)
            LLog(error?.errorDescription)
            
            if error?.code == EMErrorUserAlreadyExist {
                // 登录环信
                return setupLoginHuanXin(hxUsername: hxUsername, hxPassword: hxPassword)
            } else {
                return false
//                customLoadTip?.hideLoadTipWithError()
            }
        }
    }
    
    /// 登录 环信
    func setupLoginHuanXin(hxUsername: String, hxPassword: String) -> Bool {
        
        /**
         * 自动登录在以下几种情况下会被取消：
         *
         * 用户调用了 SDK 的登出动作；
         * 用户在别的设备上更改了密码，导致此设备上自动登录失败；
         * 用户的账号被从服务器端删除；
         * 用户从另一个设备登录，把当前设备上登录的用户踢出。
         *
         * 所以，在您调用登录方法前，应该先判断是否设置了自动登录，如果设置了，则不需要您再调用。
         *
         */
        let error =  EMClient.shared().login(withUsername: hxUsername, password: hxPassword)
        if (error == nil) { // 登录成功
            LLog(error)
            LLog("登录成功")
            
            /**
             * 自动登录：即首次登录成功后，不需要再次调用登录方法，在下次 APP 启动时，SDK 会自动为您登录。并且如果您自动登录失败，也可以读取到之前的会话信息。
             
             * SDK 中自动登录属性默认是关闭的，需要您在登录成功后设置，以便您在下次 APP 启动时不需要再次调用环信登录，并且能在没有网的情况下得到会话列表。
             */
            EMClient.shared().options.isAutoLogin = true
            // 切换到MainTabBarController
            changeTOMainTabBarController()
            
            return true
        }
        
        LLog(error?.code)
        LLog(error?.errorDescription)
//            customLoadTip?.hideLoadTipWithError()
        return false
    }
    
    // MARK:- 切换到MainTabBarController
    fileprivate func changeTOMainTabBarController() {
        
//        self.customLoadTip?.hideLoadTipWithSuccess()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            
            let window = UIApplication.shared.delegate!.window!
            let vc:MainTabBarController = MainTabBarController()
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }
}
