//
//  PopoverPresentationController.swift
//  XMGWeibo
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 小码哥. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    /// 定义属性保存菜单的尺寸
    var presentedFrame: CGRect = CGRect.zero

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
    }
    
    /// 自定义转场即将布局子控件的时候调用
    override func containerViewWillLayoutSubviews()
    {
        // 1.修改弹出菜单的尺寸
        // containerView: 容器视图, 弹出来得控制器就是放到这个视图上
        // presentedView(): 被弹出的控制器的View
//        presentedView()?.frame = presentedFrame
        
        // 2.添加子控件
//        containerView?.insertSubview(coverView, atIndex: 0)
        
    }
    
    // MARK: - 懒加载
    fileprivate lazy var coverView: UIView = {
        // 1.创建蒙板
       let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        view.frame = UIScreen.main.bounds
        
        // 2.监听蒙板的点击
        let tap = UITapGestureRecognizer(target: self, action: #selector(PopoverPresentationController.coverClick))
            view.addGestureRecognizer(tap)
        return view
    }()
    
    /// 监听蒙板的点击
    func coverClick() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
