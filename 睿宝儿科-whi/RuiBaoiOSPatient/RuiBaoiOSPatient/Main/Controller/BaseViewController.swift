//
//  BaseViewController.swift
//  XLWBSwift20160314
//
//  Created by whj on 16/3/14.
//  Copyright © 2016年 mifengyiliao. All rights reserved.
//

import UIKit
//import MBProgressHUD

class BaseViewController: UIViewController {
    
    /// 自定义导航条
    lazy var customNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 64))
    /// 自定义导航条目
    lazy var customNavigationItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = rgbSameColor(244)
        
        // 添加自定义导航条
        customNavigationBar.isTranslucent = false
        view.addSubview(customNavigationBar)
        // 将 自定义item 赋给 自定义bar
        customNavigationBar.items = [customNavigationItem]
        // 添加返回按钮
        
        // 去掉导航栏下面那条线
        customNavigationBar.shadowImage = UIImage()
        customNavigationBar.setBackgroundImage(UIImage(), for: .default)
        

        
        // ???
        edgesForExtendedLayout = UIRectEdge()

        // 网络提示
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.networkChangeToNoNetwork), name: NSNotification.Name(rawValue: kChangeToNoNetwork), object: nil)

        if AFNetworkReachability.shareNetworkTools().stateOfNetwork == 11 {
            CustomMBProgressHUD.showFailed(kNetworkTip, view: nil)
        }
        
        
        
        
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override var title: String? {
        didSet{
            customNavigationItem.title = title
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.networkChangeToNoNetwork), name: NSNotification.Name(rawValue: kChangeToNoNetwork), object: nil)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func networkChangeToNoNetwork() {
        CustomMBProgressHUD.showFailed(kNetworkTip, view: nil)
    }
    
    /**
     完全自定义返回按钮
     */
    lazy var backButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 20, width: 100, height: 44))
        btn.addTarget(self, action: #selector(BaseViewController.leftBackBarBttonItemClick), for: .touchUpInside)
        btn.setImage(UIImage(named: "RainbowBack"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0)
        return btn
    }()
   
    // 返回
    func leftBackBarBttonItemClick() {
        _ = navigationController?.popViewController(animated: true)
    }
}



extension BaseViewController: UIGestureRecognizerDelegate {

}
