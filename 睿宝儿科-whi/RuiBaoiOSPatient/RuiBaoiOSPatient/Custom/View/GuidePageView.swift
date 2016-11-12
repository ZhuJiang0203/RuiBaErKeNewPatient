//
//  GuidePageView.swift
//  XLWBSwift20160314
//
//  Created by whj on 16/3/24.
//  Copyright © 2016年 mifengyiliao. All rights reserved.
//
//  引导页

import UIKit

class GuidePageView: UIView {
    
    var page41: GuidePage41!
    var page42: GuidePage42!
    var page51: GuidePage51!
    var page52: GuidePage52!
    var page61: GuidePage61!
    var page62: GuidePage62!
    var page6p1: GuidePage6p1!
    var page6p2: GuidePage6p2!
    
    // 第几页 在执行动画，或 刚执行完动画
    var animationOfPage = 0
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        backgroundColor = UIColor.clear

        // 创建mainScrollView
        addSubview(mainScrollView)
        mainScrollView.contentSize = CGSize(width: kScreenWidth*2, height: 0)
        
        switch kScreenHeight {
        case 480:
            page41 = GuidePage41()
            mainScrollView.addSubview(page41)
            page42 = GuidePage42()
            page42.delegate = self
            mainScrollView.addSubview(page42)
        case 568:
            page51 = GuidePage51()
            mainScrollView.addSubview(page51)
            page52 = GuidePage52()
            page52.delegate = self
            mainScrollView.addSubview(page52)
        case 667:
            page61 = GuidePage61()
            mainScrollView.addSubview(page61)
            page62 = GuidePage62()
            page62.delegate = self
            mainScrollView.addSubview(page62)
        default: // 736
            page6p1 = GuidePage6p1()
            mainScrollView.addSubview(page6p1)
            page6p2 = GuidePage6p2()
            page6p2.delegate = self
            mainScrollView.addSubview(page6p2)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 创建mainScrollView
    fileprivate lazy var mainScrollView: UIScrollView = {
        let mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        mainScrollView.backgroundColor = rgbaColor(36, g: 199, b: 137, a: 0.3)//rgbaSameColor(255, a: 0.3) // UIColor.whiteColor()
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.isPagingEnabled = true
        mainScrollView.delegate = self
        mainScrollView.bounces = false
        return mainScrollView
    }()
    
    // MARK: - 创建GuidePageView
    func removeGuidePageView() {
        
        UIView.animate(withDuration: 0.5, animations: {
          
            self.alpha = 0
            
        }, completion: { (_) in
        
                self.removeFromSuperview()
                
                let userID = defaults.value(forKey: kPatientIDKey) as? String
                LLog(userID)
                
                var wd = UIApplication.shared.keyWindow
                if userID == nil || userID?.characters.count == 0 {
                    // 切换到登录界面
                    wd = UIWindow(frame: UIScreen.main.bounds)
//                    let vc = LoginController()
                    let vc = LoginViewController()
                    let navVC = BaseNavigationController(rootViewController: vc)
                    wd?.rootViewController = navVC
                    wd?.makeKeyAndVisible()
                } else {
                    wd = UIWindow(frame: UIScreen.main.bounds)
                    let vc:MainTabBarController = MainTabBarController()
                    wd?.rootViewController = vc
                    wd?.makeKeyAndVisible()
                }
        }) 
    }
}

extension GuidePageView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x/kScreenWidth)
        
        if (index == 0 && animationOfPage == 0) || (index == 1 && animationOfPage == 1) {
            return
        }
        
        animationOfPage = index
        
        switch kScreenHeight {
        case 480:
            if index == 0 {
                // page1开始动画，page2还原
                page41.guidePage1StartMoving()
                page42.guidePage2Recovery()
            } else {
                // page2开始动画，page1还原
                page42.guidePage2StartMoving()
                page41.guidePage1Recovery()
            }
        case 568:
            if index == 0 {
                // page1开始动画，page2还原
                page51.guidePage1StartMoving()
                page52.guidePage2Recovery()
            } else {
                // page2开始动画，page1还原
                page52.guidePage2StartMoving()
                page51.guidePage1Recovery()
            }
        case 667:
            if index == 0 {
                // page1开始动画，page2还原
                page61.guidePage1StartMoving()
                page62.guidePage2Recovery()
            } else {
                // page2开始动画，page1还原
                page62.guidePage2StartMoving()
                page61.guidePage1Recovery()
            }
        default: // 736
            if index == 0 {
                // page1开始动画，page2还原
                page6p1.guidePage1StartMoving()
                page6p2.guidePage2Recovery()
            } else {
                // page2开始动画，page1还原
                page6p2.guidePage2StartMoving()
                page6p1.guidePage1Recovery()
            }
        }
    }
}

extension GuidePageView: GuidePage42Delegate, GuidePage52Delegate, GuidePage62Delegate, GuidePage6p2Delegate {
    func GuidePage42TurnOnLianKang() {
        removeGuidePageView()
    }
    func GuidePage52TurnOnLianKang() {
        removeGuidePageView()
    }
    func GuidePage62TurnOnLianKang() {
        removeGuidePageView()
    }
    func GuidePage6p2TurnOnLianKang() {
        removeGuidePageView()
    }
}
