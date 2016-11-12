//
//  LoginViewController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/25.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    private var exchangeLanguageButton: UIButton?
    private var appIcon: UIImageView?
    /// accountLoginView、thirdLoginView的父控件
    private var loginView: UIView?
    private var accountLoginView: UIView?
    private var thirdLoginView: UIView?
    private var WXButton: UIButton?
    private var SinaButton: UIButton?
    private var QQButton: UIButton?
    private var EdgeInsetsLeft: CGFloat = -40
    
//    private var isGoingToThirdLoginView = false
    
    // 用户名
    fileprivate var userName: UITextField!
    // 密码
    fileprivate var password: UITextField!
    // 登录按钮
    fileprivate var loginButton: UIButton!
    // 登录模块X坐标、宽度
    var loginViewX: CGFloat = 0
    var loginViewW: CGFloat = 0
    // 环信账号、密码
    private var hxUsername = ""
    private var hxPassword = ""
    private var customLoadTip: CustomLoadTip?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch kScreenHeight {
        case 667: // 6
            loginViewX = 37
        case 736: // 6p
            loginViewX = 47
        default: // 4、5
            loginViewX = 30
        }
        loginViewW = kScreenWidth - 2*loginViewX
        
        
        /********************* 如果是睿宝，则打开下面代码 *******************/
        defaults.setValue("1", forKey: kAppSkinNumberKey)
        // 确定皮肤颜色
        AppSkinColor.shareAppSkinColor().toChangeAppSkin()
        
        // 设置整个应用的外观
        setUpApplicationTotalUIColor()
        

        let backImageView = UIImageView(frame: view.bounds)
        backImageView.image = UIImage(named: "LoginViewBackView")
        backImageView.isUserInteractionEnabled = true
        view.insertSubview(backImageView, at: 0)
 
        /// 确定中英文环境
        determineChineseOrEnglishEnvironment()
        
        /// 设置导航栏
        setupNavigationBarSomeThings()
        
        /// 应用图标
        setupAppIcon()
        
        /// 创建 账号登录、第三方登录 模块
        setupAccountLoginAndThirdLoginView()

        /// 创建第三方登录模块
        setupThirdLoginButtons()
    }
    
    // MARK: - 0.2 设置整个应用的外观
    fileprivate func setUpApplicationTotalUIColor() {
        
        // ???
        UIApplication.shared.statusBarStyle = .lightContent
        
        // 设置UINavigationBar、UITabBar相关属性
        UINavigationBar.appearance().barTintColor = appMainColor
        var attributes: Dictionary<String, AnyObject> = Dictionary()
        attributes[NSForegroundColorAttributeName] = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = rgbSameColor(249)
        UITabBar.appearance().tintColor = appMainColor
    }

   
    /// 确定中英文环境
    private func determineChineseOrEnglishEnvironment() {
        
        // 确定中英文环境
        ChangeLanguage.shareChangeLanguage().toChangeLanguage()
    }
    
    // MARK:- 设置导航栏
    private func setupNavigationBarSomeThings() {
        
        customNavigationBar.isHidden = true

        var exchangeLanguageButtonW: CGFloat = 65
        let exchangeLanguageButtonH: CGFloat = 25
        let exchangeLanguageButtonX: CGFloat = kScreenWidth - kMargin - exchangeLanguageButtonW
        let exchangeLanguageButtonY: CGFloat = 39
        exchangeLanguageButton = UIButton(frame: CGRect(x: exchangeLanguageButtonX, y: exchangeLanguageButtonY, width: exchangeLanguageButtonW, height: exchangeLanguageButtonH))
        exchangeLanguageButton!.setTitle("English", for: .normal)
        exchangeLanguageButton!.setTitle("简体中文", for: .selected)
        exchangeLanguageButton!.setTitleColor(rgbColor(249, g: 117, b: 140), for: .normal)
        exchangeLanguageButton!.titleLabel?.font = font14
        exchangeLanguageButton!.layer.cornerRadius = exchangeLanguageButtonH/2
        exchangeLanguageButton!.clipsToBounds = true
        exchangeLanguageButton!.layer.borderColor = rgbColor(249, g: 117, b: 140).cgColor
        exchangeLanguageButton!.layer.borderWidth = 0.5
        exchangeLanguageButton!.isSelected = ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental()
        exchangeLanguageButtonW = exchangeLanguageButton!.isSelected ? 80 : 65
        /// 根据 English/简体中文 确定按钮 最终 宽度、x坐标
        exchangeLanguageButton!.frame.size.width = exchangeLanguageButtonW
        exchangeLanguageButton!.frame.origin.x = kScreenWidth - kMargin - exchangeLanguageButtonW
        exchangeLanguageButton!.addTarget(self, action: #selector(LoginViewController.goToChangeLanguage), for: .touchUpInside)
        view.addSubview(exchangeLanguageButton!)
    }
    
    /// 切换中英文环境
    @objc private func goToChangeLanguage() {
        
        exchangeLanguageButton!.isSelected = !exchangeLanguageButton!.isSelected
        defaults.set(exchangeLanguageButton!.isSelected, forKey: kIsEnglishKey)

        let window = UIApplication.shared.delegate!.window!
        let vc = LoginViewController()
        let navVC = BaseNavigationController(rootViewController: vc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    // MARK:- 应用图标
    private func setupAppIcon() {
        var appIconWH: CGFloat = 100
        var appIconY: CGFloat = 90
        switch kScreenHeight {
        case 568: // 5
            appIconY = 120
            appIconWH = 100
        case 667: // 6
            appIconY = 140
            appIconWH = 120
        case 736: // 6p
            appIconY = 150
            appIconWH = 130
        default: // 4
            appIconY = 90
            appIconWH = 100
        }
        let appIconX: CGFloat = (kScreenWidth - appIconWH)/2

        appIcon = UIImageView(frame: CGRect(x: appIconX, y: appIconY, width: appIconWH, height: appIconWH))
        appIcon!.image = UIImage(named: "AppIconLogin")
        view.addSubview(appIcon!)
    }

    // MARK:- 创建登录模块
    private func setupAccountLoginAndThirdLoginView() {
        
        var marginY: CGFloat = 50
        switch kScreenHeight {
        case 568: // 5
            marginY = 80
        case 667: // 6
            marginY = 100
        case 736: // 6p
            marginY = 110
        default: // 4
            marginY = 50
        }
        
        let loginViewY = appIcon!.frame.maxY + marginY
        let loginViewH: CGFloat = 166
        
        /********************* 账登录模块 ********************/
        loginView = UIView(frame: CGRect(x: loginViewX, y: loginViewY, width: loginViewW, height: loginViewH))
        view.addSubview(loginView!)
        
        
        
        /********************* 账号 登录模块 ********************/
        accountLoginView = UIView(frame: CGRect(x: 0, y: 0, width: loginViewW, height: loginViewH))
//        accountLoginView!.backgroundColor = UIColor.blue
        loginView!.addSubview(accountLoginView!)
        /// 创建 账号登录模块 子控件
        setupAccountLoginViewSubViews()
        
        
        /********************* 第三方 登录模块 ********************/
        thirdLoginView = UIView(frame: CGRect(x: 0, y: 0, width: loginViewW, height: loginViewH))
//        thirdLoginView!.backgroundColor = UIColor.orange
        thirdLoginView!.isHidden = true
        loginView!.addSubview(thirdLoginView!)
        /// 创建 第三方登录模块 子控件
        setupThirdLoginViewLoginViewSubViews()
    }
    
    /// 创建登录模块子控件
    private func setupAccountLoginViewSubViews() {
        
        let subViewH: CGFloat = 42
        
        userName = UITextField(frame: CGRect(x: 0, y: 0, width: loginViewW, height: subViewH))
        userName.placeholder = kCellPhoneNumberMedicalRecordNumber
        userName.clearButtonMode = UITextFieldViewMode.whileEditing
        userName.layer.cornerRadius = kRadius
        userName.clipsToBounds = true
        userName.layer.borderColor = rgbColor(227, g: 196, b: 202).cgColor
        userName.layer.borderWidth = 0.5
        userName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        userName.leftViewMode = UITextFieldViewMode.always
        userName.textColor = rgb51
        userName.font = font16
        userName.delegate = self
        accountLoginView!.addSubview(userName)
        
        password = UITextField(frame: CGRect(x: 0, y: userName.frame.maxY + kMargin, width: loginViewW, height: subViewH))
        password.placeholder = kLoginPasswordPlacehoder
        password.layer.cornerRadius = kRadius
        password.clipsToBounds = true
        password.layer.borderColor = rgbColor(227, g: 196, b: 202).cgColor
        password.layer.borderWidth = 0.5
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        password.leftViewMode = UITextFieldViewMode.always
        password.rightView = setupPasswordRightView(subViewH: subViewH)
        password.rightViewMode = UITextFieldViewMode.always
        password.textColor = rgb51
        password.font = font16
        password.delegate = self
        password.isSecureTextEntry = true
        accountLoginView!.addSubview(password)
        
        loginButton = UIButton(frame: CGRect(x: 0 , y: password.frame.maxY + kMargin, width: loginViewW, height: subViewH))
        loginButton.setBackgroundImage(UIImage(named: "SubmitButtonBackImageCornerRadius"), for: .normal)
        loginButton!.setBackgroundImage(UIImage.init(named: "SubmitButtonBackImageCornerRadiusGray"), for: .disabled)
        loginButton!.isEnabled = false
        loginButton.setTitle(kLoginLogin, for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.addTarget(self, action: #selector(LoginViewController.toLogin), for: .touchUpInside)
        accountLoginView!.addSubview(loginButton)
        
        let forgetPasswordButton = UIButton(frame: CGRect(x: 0, y: loginButton.frame.maxY, width: loginViewW, height: 20))
        forgetPasswordButton.setTitle(kForgetPassword, for: .normal)
        forgetPasswordButton.setTitleColor(rgbColor(149, g: 142, b: 144), for: .normal)
        forgetPasswordButton.titleLabel?.font = font13
        forgetPasswordButton.contentHorizontalAlignment = .right
        forgetPasswordButton.addTarget(self, action: #selector(LoginViewController.forgetPasswordButtonClicked), for: .touchUpInside)
        accountLoginView!.addSubview(forgetPasswordButton)

    }
    
    private func setupPasswordRightView(subViewH: CGFloat) -> UIView {

        let rightViewW: CGFloat = 50
        let rightViewH: CGFloat = 22
        let rightViewX: CGFloat = loginViewW - rightViewW
        let rightViewY: CGFloat = (subViewH - rightViewH)/2
        let rightView = UIView(frame: CGRect(x: rightViewX, y: rightViewY, width: rightViewW, height: rightViewH))
//        rightView.backgroundColor = UIColor.orange

        let customSwitch = CustomSwitch(frame: CGRect(x: 0, y: 0, width: rightViewW - kMargin, height: rightViewH))
        customSwitch.delegate = self
        rightView.addSubview(customSwitch)
       
        return rightView
    }
    
    @objc private func toLogin() {
        
        
        customLoadTip = CustomLoadTip.showLoadTip(nil)

        /********************* 如果是睿宝，则打开下面代码 *******************/
        defaults.setValue("1", forKey: kAppSkinNumberKey)
        
        // 测试
        defaults.setValue("1006", forKey: kOrganizationIDKey)
        defaults.setValue("1", forKey: kPracticeIDKey)
        defaults.setValue("1", forKey: kPatientIDKey)
        defaults.setValue("312312312", forKey: kPatientTockenKey)
        defaults.setValue("84", forKey: kPatientIconKey)
        defaults.setValue("睿宝医生", forKey: kPatientNameKey)
        defaults.setValue("RuiBaoDoctor", forKey: kPatientEnglishNameKey)
        defaults.setValue("好大夫", forKey: kPatientUserNameKey)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            // 注册环信
            self.setupRegisterHuanXin()
        }
    }
    
    
    
    // MARK:- 注册环信
    private func setupRegisterHuanXin() {

        // 环信 用户名、密码
        hxUsername = "3-pt177"//organizationID + "-pt" + doctorID
        hxPassword = "patient3177"//"patient\(organizationID)\(doctorID)"
        
        let isSuccess = LoginHuanXin.shareLoginHuanXin().setupRegisterHuanXin(hxUsername: hxUsername, hxPassword: hxPassword)
        if isSuccess == true {
            customLoadTip?.hideLoadTipWithSuccess()
        } else {
            customLoadTip?.hideLoadTipWithError()
        }
        
//        let error =  EMClient.shared().register(withUsername: hxUsername, password: hxPassword)
//        
//        if (error == nil) {
//            
//            LLog(error)
//            
//            LLog("注册成功")
//            
//            // 保存到本地
//            defaults.setValue("true", forKey: kIsResignHuanXin)
//            
//            // 登录环信
//            setupLoginHuanXin()
//        } else {
//            LLog(error?.code)
//            LLog(error?.errorDescription)
//            
//            if error?.code == EMErrorUserAlreadyExist {
//                // 登录环信
//                setupLoginHuanXin()
//            } else {
//                customLoadTip?.hideLoadTipWithError()
//            }
//        }
    }
    
//    // MARK:- 登录环信
//    fileprivate func setupLoginHuanXin() {
//        
//        
//        /**
//         * 自动登录在以下几种情况下会被取消：
//         *
//         * 用户调用了 SDK 的登出动作；
//         * 用户在别的设备上更改了密码，导致此设备上自动登录失败；
//         * 用户的账号被从服务器端删除；
//         * 用户从另一个设备登录，把当前设备上登录的用户踢出。
//         *
//         * 所以，在您调用登录方法前，应该先判断是否设置了自动登录，如果设置了，则不需要您再调用。
//         *
//         */
//        
//        // MARK:- ！！！此状态是保存在沙盒中的，并没有保存到环信的服务器 ！！！
//        //        let isAutoLogin = EMClient.sharedClient().options.isAutoLogin
//        //        LLog(isAutoLogin)
//        //        if (!isAutoLogin) { // 没有设置自动登录
//        
//        let error =  EMClient.shared().login(withUsername: hxUsername, password: hxPassword)
//        if (error == nil) { // 登录成功
//            LLog(error)
//            LLog("登录成功")
//            
//            /**
//             * 自动登录：即首次登录成功后，不需要再次调用登录方法，在下次 APP 启动时，SDK 会自动为您登录。并且如果您自动登录失败，也可以读取到之前的会话信息。
//             
//             * SDK 中自动登录属性默认是关闭的，需要您在登录成功后设置，以便您在下次 APP 启动时不需要再次调用环信登录，并且能在没有网的情况下得到会话列表。
//             */
//            EMClient.shared().options.isAutoLogin = true
//            // 切换到MainTabBarController
//            changeTOMainTabBarController()
//        } else {
//            customLoadTip?.hideLoadTipWithError()
//            LLog(error?.code)
//            LLog(error?.errorDescription)
//        }
//        //        } else { // 登录失败
//        //            // 切换到MainTabBarController
//        //            changeTOMainTabBarController()
//        //        }
//    }
//    
//    // MARK:- 切换到MainTabBarController
//    fileprivate func changeTOMainTabBarController() {
//        
//        self.customLoadTip?.hideLoadTipWithSuccess()
//        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
//            
//            let window = UIApplication.shared.delegate!.window!
//            let vc:MainTabBarController = MainTabBarController()
//            window?.rootViewController = vc
//            window?.makeKeyAndVisible()
//        }
//    }
    
    
    
    // MARK:- 创建 第三方登录模块 子控件
    private func setupThirdLoginViewLoginViewSubViews() {
        
        let subViewH: CGFloat = 42
        
        WXButton = UIButton(frame: CGRect(x: 0, y: 0, width: loginViewW, height: subViewH))
        WXButton!.setTitle(kWeChatLogin, for: .normal)
        WXButton!.setTitleColor(rgbColor(136, g: 126, b: 132), for: .normal)
        WXButton!.setTitleColor(UIColor.white, for: .highlighted)
        WXButton!.setImage(UIImage.init(named: "ThirdLoginWX"), for: .normal)
        WXButton!.setImage(UIImage.init(named: "ThirdLoginWXSelected"), for: .highlighted)
        WXButton!.setBackgroundImage(UIImage.init(named: "ThirdLoginBackImageNormal"), for: .normal)
        WXButton!.setBackgroundImage(UIImage.init(named: "SubmitButtonBackImageCornerRadius"), for: .highlighted)
        WXButton!.imageEdgeInsets = UIEdgeInsets(top: 0, left: EdgeInsetsLeft, bottom: 0, right: 0)
        WXButton!.addTarget(self, action: #selector(LoginViewController.WXButtonClicked), for: .touchUpInside)
        thirdLoginView!.addSubview(WXButton!)
        
        SinaButton = UIButton(frame: CGRect(x: 0, y: WXButton!.frame.maxY + kMargin, width: loginViewW, height: subViewH))
        SinaButton!.setTitle(kMicroBlogLogin, for: .normal)
        SinaButton!.setTitleColor(rgbColor(136, g: 126, b: 132), for: .normal)
        SinaButton!.setTitleColor(UIColor.white, for: .highlighted)
        SinaButton!.setImage(UIImage.init(named: "ThirdLoginSina"), for: .normal)
        SinaButton!.setImage(UIImage.init(named: "ThirdLoginSinaSelected"), for: .highlighted)
        SinaButton!.setBackgroundImage(UIImage.init(named: "ThirdLoginBackImageNormal"), for: .normal)
        SinaButton!.setBackgroundImage(UIImage.init(named: "SubmitButtonBackImageCornerRadius"), for: .highlighted)
        SinaButton!.imageEdgeInsets = UIEdgeInsets(top: 0, left: EdgeInsetsLeft, bottom: 0, right: 0)
        SinaButton!.addTarget(self, action: #selector(LoginViewController.SinaButtonClicked), for: .touchUpInside)
        thirdLoginView!.addSubview(SinaButton!)
        
        QQButton = UIButton(frame: CGRect(x: 0, y: SinaButton!.frame.maxY + kMargin, width: loginViewW, height: subViewH))
        QQButton!.setTitle(kQQLogin, for: .normal)
        QQButton!.setTitleColor(rgbColor(136, g: 126, b: 132), for: .normal)
        QQButton!.setTitleColor(UIColor.white, for: .highlighted)
        QQButton!.setImage(UIImage.init(named: "ThirdLoginQQ"), for: .normal)
        QQButton!.setImage(UIImage.init(named: "ThirdLoginQQSelected"), for: .highlighted)
        QQButton!.setBackgroundImage(UIImage.init(named: "ThirdLoginBackImageNormal"), for: .normal)
        QQButton!.setBackgroundImage(UIImage.init(named: "SubmitButtonBackImageCornerRadius"), for: .highlighted)
        QQButton!.imageEdgeInsets = UIEdgeInsets(top: 0, left: EdgeInsetsLeft, bottom: 0, right: 0)
        QQButton!.addTarget(self, action: #selector(LoginViewController.QQButtonClicked), for: .touchUpInside)
        thirdLoginView!.addSubview(QQButton!)
    }
    
    // MARK:- 微信登录
    @objc private func WXButtonClicked() {
        clickWeChatLogin()
    }
    
    // MARK:- 新浪微博登录
    @objc private func SinaButtonClicked() {
        clickSinaLogin()
    }
    
    // MARK:- QQ登录
    @objc private func QQButtonClicked() {
        clickQQLogin()
    }
    
    
    
    
    // MARK:- 忘记密码？
    @objc private func forgetPasswordButtonClicked() {
        
//        toLogin()
        

        let vc = RegisterViewController()
        vc.type = 2
        navigationController?.pushViewController(vc, animated: true)
    }


    
    // MARK:- 创建第三方登录模块
    private func setupThirdLoginButtons() {
        
        let loginRegisterH: CGFloat = 22
        let otherStyleLoginRegisterView = UIView(frame: CGRect(x: loginViewX, y: loginView!.frame.maxY + 22, width: loginViewW, height: loginRegisterH))
        view.addSubview(otherStyleLoginRegisterView)
        
        let registerButtonW: CGFloat = kRegister.calculateTheSizeOfTheString(font16, maxWidth: 200).width
        let registerButtonX: CGFloat = loginViewW - registerButtonW
        let registerButton = UIButton(frame: CGRect(x: registerButtonX, y: 0, width: registerButtonW, height: loginRegisterH))
        registerButton.setTitle(kRegister, for: .normal)
        registerButton.setTitleColor(rgb102, for: .normal)
        registerButton.titleLabel?.font = font16
//        registerButton.backgroundColor = UIColor.red
        registerButton.addTarget(self, action: #selector(LoginViewController.registerButtonClicked), for: .touchUpInside)
        otherStyleLoginRegisterView.addSubview(registerButton)
        
        let otherStyleLoginButtonW: CGFloat = registerButtonX - kMargin15
        let otherStyleLoginButton = UIButton(frame: CGRect(x: 0, y: 0, width: otherStyleLoginButtonW, height: loginRegisterH))
        otherStyleLoginButton.setTitle(kOtherWaysToLogin, for: .normal)
        otherStyleLoginButton.setTitleColor(rgb102, for: .normal)
        otherStyleLoginButton.titleLabel?.font = font16
        otherStyleLoginButton.contentHorizontalAlignment = .right
        otherStyleLoginButton.addTarget(self, action: #selector(LoginViewController.otherStyleLoginButtonClicked), for: .touchUpInside)
        otherStyleLoginRegisterView.addSubview(otherStyleLoginButton)
        
        let line = UIView(frame: CGRect(x: registerButtonX - kMargin15/2, y: 0, width: 0.5, height: loginRegisterH))
        line.backgroundColor = rgb102
        otherStyleLoginRegisterView.addSubview(line)
    }
    
    // MARK:- 注册
    @objc private func registerButtonClicked() {
        let vc = RegisterViewController()
        vc.type = 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- 其他方式登录
    @objc private func otherStyleLoginButtonClicked() {
        
        /// 方法一（不符合要求）
//        /// accountLoginView、thirdLoginView切换
//        isGoingToThirdLoginView = !isGoingToThirdLoginView
//        let fromView = isGoingToThirdLoginView ? accountLoginView! : thirdLoginView!
//        let toView = isGoingToThirdLoginView ? thirdLoginView! : accountLoginView!
//        
//        UIView.transition(from: fromView, to: toView, duration: 0.5, options: .transitionFlipFromLeft) { (_) in
//            LLog("23456")
//        }
        
        /// 方法二（符合要求）
        UIView.transition(with: loginView!, duration: 1.5, options: .transitionFlipFromLeft, animations: {
            self.accountLoginView!.isHidden = !self.accountLoginView!.isHidden
            self.thirdLoginView!.isHidden = !self.thirdLoginView!.isHidden
            }) { (isOk) in
                LLog(isOk)
        }
    }
    
    /// QQ登录
    func clickQQLogin() {
        
        let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatform(withName: UMShareToQQ)
        snsPlatform?.loginClickHandler(self, UMSocialControllerService.default(), true, {response in
            
            if response?.responseCode == UMSResponseCodeSuccess { // 登录成功
                
                CustomLoadTip.showLoadTip(nil).hideLoadTipWithSuccess()
                //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kLogSuccess), object: nil)
                
                
                
                // 获取信息与自己的登录系统对接数据
                let dataDic: NSDictionary = UMSocialAccountManager.socialAccountDictionary() as NSDictionary
                print("QQ ------  dataDic = \(dataDic)")
                
                let snsAccount = dataDic.value(forKey: (snsPlatform?.platformName)!)
                print("QQ ------- snsAccount = \(snsAccount)")
                
                
                self.toLogin()
                
            } else if response?.responseCode == UMSResponseCodeCancel { // 取消登录
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kLogCancle), object: nil)
            } else { // 登录失败
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kLogFailed), object: nil)
            }
        })
    }
    
    /// 微信登录
    func clickWeChatLogin() {
        
        let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatform(withName: UMShareToWechatSession)
        snsPlatform?.loginClickHandler(self, UMSocialControllerService.default(), true, {response in
            if response?.responseCode == UMSResponseCodeSuccess {
                
                // 获取信息与自己的登录系统对接数据
                let dataDic: NSDictionary = UMSocialAccountManager.socialAccountDictionary() as NSDictionary
                print("WeChat ------ dataDic = \(dataDic)")
                
                let snsAccount = dataDic.value(forKey: (snsPlatform?.platformName)!)
                print("WeChat ------  snsAccount = \(snsAccount)")
                
                self.toLogin()

            }
        })
    }
    
    /// 新浪微博登录
    func clickSinaLogin() {
        
        let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatform(withName: UMShareToSina)
        snsPlatform?.loginClickHandler(self, UMSocialControllerService.default(), true, {response in
            if response?.responseCode == UMSResponseCodeSuccess {
                
                // 获取信息与自己的登录系统对接数据
                let dataDic: NSDictionary = UMSocialAccountManager.socialAccountDictionary() as NSDictionary
                print("Sina ------  dataDic = \(dataDic)")
                
                let snsAccount = dataDic.value(forKey: (snsPlatform?.platformName)!)
                print("Sina ------- snsAccount = \(snsAccount)")
                
                self.toLogin()

            }
        })
    }
}


extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /// 6 - 1 = 5
        if userName!.hasText &&
            password!.hasText &&
            password!.text!.characters.count >= 5 {
            loginButton!.isEnabled = true
        } else {
            loginButton!.isEnabled = false
        }
        
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = appMainColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = rgbColor(208, g: 190, b: 185).cgColor
    }
}



extension LoginViewController: CustomSwitchDelegate {
    func buttonOfCustomSwitchClicked(btn: CustomSwitch) {
        password.isSecureTextEntry = btn.isSelected
    }
}


