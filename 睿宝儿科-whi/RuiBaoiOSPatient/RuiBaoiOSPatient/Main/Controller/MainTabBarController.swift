//
//  MainTabBarController.swift
//  XLWBSwift20160314
//
//  Created by whj on 16/3/14.
//  Copyright © 2016年 mifengyiliao. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let myTabBar = MyTabBar()

    
    /********* 方法一：创建子控制器 ********/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        // 0. 确定中英文环境
        ChangeLanguage.shareChangeLanguage().toChangeLanguage()
        
        // 0.1 确定皮肤颜色
        AppSkinColor.shareAppSkinColor().toChangeAppSkin()
        
        // 0.2 设置整个应用的外观
        setUpApplicationTotalUIColor()
        
        // 1. 添加子控制器
        addChildViewControllers()
        
        // 1.1 添加自定义tabBar
        addMyTabBar()
        
        // 2. 默认选中的界面
        selectedIndex = 0
        
        // 3. 加载患者头像
        toLoadDoctorIconURLString()
    }
    
    // 方法一：
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for child in self.tabBar.subviews {
            if !(child.isKind(of: MyTabBar.self)) {
                child.removeFromSuperview()
            }
        }
    }
    
    override var selectedIndex: Int {
        didSet {
            LLog(selectedIndex)

            if selectedIndex >= 0 && selectedIndex <= 4 {
                myTabBar.buttonClick(myTabBar.buttons[selectedIndex])
            }
        }
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
    
    // MARK:- 1. 添加子控制器
    fileprivate func addChildViewControllers() {

        let vcs = [HomePageController(), ConsultationListController(), MedicalRecordController(), ShoppingMallController(), ProfileController()]
        for i in 0..<vcs.count {
            addChildViewController(vcs[i], navigationItemTitle: kMainTabBarTitles[i])
        }
    }
    
    func addChildViewController(_ childController: UIViewController, navigationItemTitle: String) {
        
        childController.title = navigationItemTitle
        
        let navVC = BaseNavigationController()
        navVC.addChildViewController(childController)
        addChildViewController(navVC)
    }
    
    
    // MARK:- 1.1 添加自定义tabBar
    fileprivate func addMyTabBar() {

        // 必须用异步主线程（不知道原因）
//        dispatch_async(dispatch_get_main_queue(), {
//            
//            // 方法二：
//            for child in self.tabBar.subviews {
//                child.alpha = 0
//            }
        
            // 1. 添加自定义tabBar
            myTabBar.frame = self.tabBar.bounds
            myTabBar.delegate = self
            self.tabBar.addSubview(myTabBar)
        
            // 2.添加对应个数的按钮
            let count = self.viewControllers?.count ?? 0
            for i in 0..<count {
                myTabBar.addTabBarButtonWithTitleAndIconString(kMainTabBarTitles[i], iconString: tabBarItemIcons[i])
            }
//        })
    }
    
    
    
    
    // MARK:- 3. 加载患者头像
    func toLoadDoctorIconURLString() {
        
        let iconKey = defaults.string(forKey: kPatientIconKey)!
        let url = "files/url/\(iconKey)"
        LLog(url)
        
        NetworkTools.shareNetworkTools().get(url, parameters: nil, progress: { (progress) -> Void in
            LLog(progress)
            }, success: { (_, responseObject) -> Void in
                
                LLog(responseObject)
                
                if (responseObject != nil) {
                    
                    if let dict = responseObject as? Dictionary<String, AnyObject> {
                        
                        if let status = dict["status"] as? String {
                            
                            if status == "SUCCESS" {
                            
                                if let values = dict["values"] as? Dictionary<String, AnyObject> {
                                   
                                    if let filePath = values["filePath"] as? String {
                                        LLog(filePath)

                                        // 医生头像url
                                        defaults.setValue(filePath, forKey: kPatientIconURLStringKey)
                                    }
                                }
                            }
                        }
                    }
                }
        }) { (_, error) -> Void in
            LLog(error)
        }
    }
}


extension MainTabBarController: MyTabBarDelegate {
    func didSelectedOneButtonOfTabBar(_ tabBar: MyTabBar, btn: MJTabBarButton) {
        // 选中最新的控制器
        selectedIndex = btn.tag
    }
}


