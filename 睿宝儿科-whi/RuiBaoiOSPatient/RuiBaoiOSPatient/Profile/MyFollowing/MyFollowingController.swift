//
//  MyFollowingController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/20.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

let currentControllerName = "DiscoverViewController"

class MyFollowingController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = kMyCollection
        view.backgroundColor = rgb244
        
        /// 1. 添加顶部菜单
        view.addSubview(navSwitch)
       
        /// 2. 设置mainScrollView
        view.addSubview(mainScrollView)
        
        /// 3. 添加子控制器
        addChildViewControllers()
    }
    
    // MARK: - 1. 添加顶部菜单
    fileprivate lazy var navSwitch: NavSwitch = {
        let navSwitch = NavSwitch()
        navSwitch.notifiPrefix = currentControllerName as NSString!
        navSwitch.nameArr = [kConcernedDoctor, kConcernedArticle]
        navSwitch.delegate = self
        return navSwitch
    }()
    
    // MARK: - 2. 设置mainScrollView
    fileprivate lazy var mainScrollView: UIScrollView = {
        let mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 114, width: kScreenWidth, height: kScreenHeight - 64 - 50))
        mainScrollView.contentSize = CGSize(width: kScreenWidth*2, height: 0);
        mainScrollView.isPagingEnabled = true
        mainScrollView.isDirectionalLockEnabled = true
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.delegate = self
        return mainScrollView
    }()
    
    // MARK: - 3. 添加子控制器
    fileprivate func addChildViewControllers() {
        
        for i in 0..<2 {
            if (i == 0) {
                addChildViewController(FollowDoctorsController())
                // 添加控制器的view到mainScrollView
                addViewOfOneChildViewController(i)
            } else {
                addChildViewController(FollowArticlesController())
            }
        }
    }
    
    /// 添加控制器的view
    fileprivate func addViewOfOneChildViewController(_ index: Int) {
        let vc = childViewControllers[index]
        if (vc.view.superview != nil) {
            return
        }
        vc.view.frame = CGRect(x: kScreenWidth*CGFloat(index), y: 0, width: kScreenWidth, height: kScreenHeight - 64 - 40 - 10)
        mainScrollView.addSubview(vc.view)
    }
}

// MARK: - NavSwitchDelegate
extension MyFollowingController: NavSwitchDelegate {
    func oneButtonClickedOfNavSwitch(_ navSwitch: NavSwitch, btn: UIButton) {
        // 让mainScrollView滚动到相应位置
        mainScrollView.setContentOffset(CGPoint(x: kScreenWidth*CGFloat(btn.tag), y: 0), animated: true)
        // 改变滑块位置
        navSwitch.changeButtonLineState(btn)
        // 添加控制器的view到mainScrollView
        addViewOfOneChildViewController(btn.tag)
    }
}

// MARK: - UIScrollViewDelegate
extension MyFollowingController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 发通知（改变滑块位置、按钮状态）
        let str = "\(scrollView.contentOffset.x)"
        let info = ["notificationPrefix": currentControllerName, currentControllerName + "ScrollVwContextOffsetX": str]
        let notifyName = "\(currentControllerName)ScrollViewDidEndDraggingNotification"
        LLog(notifyName)
        NotificationCenter.default.post(name: Notification.Name(rawValue: notifyName), object: nil, userInfo: info)
        // 添加控制器的view到mainScrollView
        let i: Int = Int(scrollView.contentOffset.x/kScreenWidth)
        addViewOfOneChildViewController(i)
    }
}
