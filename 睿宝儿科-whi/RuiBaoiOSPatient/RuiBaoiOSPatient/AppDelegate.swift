//
//  AppDelegate.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isBack = false // 是否在后台

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
//        let vv = uivi
//        casdcsdac
//        dfas
        
        // 确定中英文环境
        ChangeLanguage.shareChangeLanguage().toChangeLanguage()

        
        // -3. applicationIconBadgeNumber 清零
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        // -2. 环信
        setupHuanXin()
        
        // -1. 设置SVProgressHUD相关属性
//        setupSVProgressHUD()
        
        // 0. 实时监测网络设置
        AFNetworkReachability.shareNetworkTools().networkReachabilityStatus()
        
        // 1. 设置整个应用的外观
        setUpApplicationTotalUIColor()
        
        // 2. 设置根控制器
        setUpRootViewController()
        
        // 3. 设置键盘inputAccessory
        setupInputAccessory()
        
        // 4. 是否显示引导页
        isShowGuidePage()
        
        // 5. 设置友盟appkey、配置第三方APPID
        setupUMSocial()
        
        
        /// 接受分享、登录通知
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.shareSuccess), name: NSNotification.Name(rawValue: kShareSuccess), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.shareFailed), name: NSNotification.Name(rawValue: kShareFailed), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.shareCancle), name: NSNotification.Name(rawValue: kShareCancle), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.logSuccess), name: NSNotification.Name(rawValue: kLogSuccess), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.logFailed), name: NSNotification.Name(rawValue: kLogFailed), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.logCancle), name: NSNotification.Name(rawValue: kLogCancle), object: nil)
        
        
        
        // 6. 根据系统语言，默认 英文/中文
        var isEnglish = false
        let systemLanguage = NSLocale.preferredLanguages.first ?? ""
        if systemLanguage.hasPrefix("en") {
            isEnglish = true
        }
        defaults.set(isEnglish, forKey: kIsEnglishKey)

        
        
        
        
        return true
    }
    
    /// 分享成功、失败、取消
    @objc private func shareSuccess() {
        CustomMBProgressHUD.showSuccess(kShareSuccessTip, view: nil)
    }
    @objc private func shareFailed() {
        CustomMBProgressHUD.showFailed(kShareFaileTip, view: nil)
    }
    @objc private func shareCancle() {
        CustomMBProgressHUD.showTipAndHideImmediately(kCancleShareTip, details: nil, view: nil)
    }
    /// 登录成功、失败、取消
    @objc private func logSuccess() {
        CustomMBProgressHUD.showSuccess(kLoginSuccess, view: nil)
    }
    @objc private func logFailed() {
        CustomMBProgressHUD.showSuccess(kLoginFail, view: nil)
    }
    @objc private func logCancle() {
        CustomMBProgressHUD.showSuccess(kCancleLogin, view: nil)
    }
    

    
    // MARK:- 环信
    fileprivate func setupHuanXin() {
        // 注册环信AppKey、apnsCertName
        let options = EMOptions(appkey: kHuanXinAPPKEY)
        // apnsCertName:推送证书名
        options?.apnsCertName = nil
        EMClient.shared().initializeSDK(with: options)
        
        // 添加回调监听代理:
        EMClient.shared().add(self, delegateQueue: nil)
        EMClient.shared().chatManager.add(self, delegateQueue: nil)
        // 初始化EaseUI
//        EaseSDKHelper.shareHelper().easemobApplication(application, didFinishLaunchingWithOptions: launchOptions, appkey: kHuanXinAPPKEY, apnsCertName: nil, otherConfig: [kSDKConfigEnableConsoleLogger: NSNumber(bool: true)])
    }
    
    // 移除代理，防止内存泄漏
    deinit {
        NotificationCenter.default.removeObserver(self)
        EMClient.shared().removeDelegate(self)
    }
    
    // MARK:- 设置SVProgressHUD相关属性
//    private func setupSVProgressHUD() {
//        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Custom)
//        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
//        SVProgressHUD.setBackgroundColor(rgbaSameColor(0, a: 0.7))
//        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Clear)
//    }
    

    
    // MARK: - 设置整个应用的外观
    func setUpApplicationTotalUIColor() {
        
        // 状态栏颜色
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        
        // 设置UINavigationBar、UITabBar相关属性
        UINavigationBar.appearance().barTintColor = appMainColor
        // titleTextAttributes
        var attributes: Dictionary<String, AnyObject> = Dictionary()
        attributes[NSForegroundColorAttributeName] = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = attributes
        // tintColor
        UINavigationBar.appearance().tintColor = UIColor.white
        
        UITabBar.appearance().barTintColor = rgbSameColor(249)
        UITabBar.appearance().tintColor = appMainColor
    }
    
    // MARK: - 设置根控制器
    fileprivate func setUpRootViewController() {
        
        let userID = defaults.value(forKey: kPatientIDKey) as? String
        LLog(userID)
        if userID == nil || userID?.characters.count == 0 {
            // 切换到登录界面
            changeToLoginController(false)
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = MainTabBarController()
            window?.makeKeyAndVisible()
        }
    }
    
    // MARK:- 切换到登录界面
    fileprivate func changeToLoginController(_ showAlert: Bool) {
        
        // 清空本地账号数据
        defaults.setValue("", forKey: kPatientIDKey)
//        defaults.setValue("", forKey: kPatientTockenKey)
//        defaults.setValue("", forKey: kPatientIconKey)
//        defaults.setValue("", forKey: kPatientNameKey)
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = LoginController()
        let vc = LoginViewController()
        let navVC = BaseNavigationController(rootViewController: vc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        if showAlert == true {
            let alertController = UIAlertController(title: kLoggedOnOtherDevicesTip, message: kAnAccountCanOnlyLoggedOnOneDeviceTip, preferredStyle: UIAlertControllerStyle.alert)
            let noAction = UIAlertAction(title: kISeeTip, style: UIAlertActionStyle.cancel) { (action) in
                LLog(kISeeTip);
            }
            alertController.addAction(noAction)
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK:- 设置键盘inputAccessory
    func setupInputAccessory() {
        let iQManger = IQKeyboardManager.shared()
        iQManger.isEnabled = true
        // 键盘离UITextField、UITextView的距离
        iQManger.keyboardDistanceFromTextField = 20
        iQManger.toolbarTintColor = UIColor.blue
        LLog(kOver)
        iQManger.toolbarDoneBarButtonItemText = kOver
        iQManger.placeholderFont = font13 // 默认就是13
    }
    // MARK: - 是否显示引导页
    func isShowGuidePage() {
        if isUpdataVersion() { // 是否更新了版本号
            // 引导页
            window?.addSubview(GuidePageView())
        }
    }
    
    // MARK: - 是否更新了版本号
    fileprivate func isUpdataVersion() -> Bool {
        // 1. 获取当前版本号
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        // 2. 取出沙盒保存的版本号
        // "??"作用：如果前面的值是nil，那么就返回后面的值，否则 "??" 后面的代码不执行
        let sandBoxVersion = defaults.value(forKey: "kCFBundleShortVersionString") as? String ?? ""
        LLog("~" + sandBoxVersion + "!")
        // 3. 比较两个版本号
        // 升序、降序、相等
        if currentVersion.compare(sandBoxVersion) == ComparisonResult.orderedDescending {
            // 3.1 保存当前版本号到沙盒
            defaults.setValue(currentVersion, forKey: "kCFBundleShortVersionString")
            return true
        }
        return false
    }
    
    // MARK:- 设置友盟appkey、配置第三方APPID
    func setupUMSocial() {
        // 设置友盟appkey
        UMSocialData.setAppKey(kUmengAppKey)

        // 配置第三方APPID
        // 设置微信AppId、appSecret，分享url
        UMSocialWechatHandler.setWXAppId(kWeiXinAppID, appSecret: kWeiXinAppSecret, url: kWeiXinAppURL)
        // 设置手机QQ 的AppId，Appkey，和分享URL
        UMSocialQQHandler.setQQWithAppId(kQQAPPID, appKey: kQQAPPKEY, url: kQQAPPURL)
        // 打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
        UMSocialSinaSSOHandler.openNewSinaSSO(withAppKey: kWeiBoAppKey, secret: kWeiBoAppSecret, redirectURL: kWeiBoAppAdress)

        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina])
    }
    
    // MARK:- 配置系统回调 ？？？
    private func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: AnyObject) -> Bool {

        let result = UMSocialSnsService.handleOpen(url)
        if (result == false) {
            // 调用其他SDK，例如支付宝SDK等
        }
        return result;
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialSnsService.handleOpen(url)
        if (result == false) {
            // 调用其他SDK，例如支付宝SDK等
        }
        return result;
    }
    

    
    
    
    
    
    
    
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    // MARK:- app进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        isBack = true
        EMClient.shared().applicationDidEnterBackground(application)
    }
    
    // MARK:- app将要从后台返回
    func applicationWillEnterForeground(_ application: UIApplication) {
        isBack = false
        UIApplication.shared.applicationIconBadgeNumber = 0
        EMClient.shared().applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}



// MARK:- EMChatManagerDelegate 收到消息
extension AppDelegate: EMClientDelegate {
    /*!
     *  自动登录失败时的回调
     *
     *  @param aError 错误信息
     */
    func didAutoLoginWithError(_ aError: EMError!) {
        if aError == nil {
            LLog("自动登录成功")
        } else {
            LLog("自动登录失败")
        }
    }
    
    /**
     *  SDK连接服务器的状态变化时会接收到该回调
     *
     *  有以下几种情况, 会引起该方法的调用:
     *  1. 登录成功后, 手机无法上网时, 会调用该回调
     *  2. 登录成功后, 网络状态变化时, 会调用该回调
     */
    func didConnectionStateChanged(_ aConnectionState: EMConnectionState) {
        
    }
    
    /*!
     *  当前登录账号在其它设备登录时会接收到该回调
     */
    func didLoginFromOtherDevice() {
        // 切换到登录界面
        changeToLoginController(true)
    }
    
    /*!
     *  当前登录账号已经被从服务器端删除时会收到该回调
     */
    func didRemovedFromServer() {
        // 切换到登录界面
        changeToLoginController(true)
    }
    
}

// MARK:- EMChatManagerDelegate 收到消息
extension AppDelegate: EMChatManagerDelegate {
    
    /*!
     *  \~chinese
     *  收到消息
     *
     *  @param aMessages  消息列表<EMMessage>
     *
     *  \~english
     *  Received messages
     *
     *  @param aMessages  Message list<EMMessage>
     */
    
    private func didReceiveMessages(_ aMessages: [AnyObject]!) {
        if isBack == true { // 在后台
            UIApplication.shared.applicationIconBadgeNumber += 1
        }
    }
}


