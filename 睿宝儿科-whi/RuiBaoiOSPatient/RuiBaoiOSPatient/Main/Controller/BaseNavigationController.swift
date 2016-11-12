//
//  BaseNavigationController.swift
//  XLWBSwift20160314
//
//  Created by whj on 16/3/14.
//  Copyright © 2016年 mifengyiliao. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 隐藏默认的 NavigationBar
        navigationBar.isHidden = true
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            // 添加 返回按钮
            if let vc = viewController as? BaseViewController {
                vc.customNavigationBar.addSubview(vc.backButton)
            }
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}
