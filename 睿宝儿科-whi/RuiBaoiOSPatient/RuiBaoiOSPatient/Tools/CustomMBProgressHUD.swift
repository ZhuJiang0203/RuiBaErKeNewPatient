//
//  CustomMBProgressHUD.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/15.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit
import MBProgressHUD

private var Tip: String?

class CustomMBProgressHUD: UIButton {

    class func showSuccess(_ tip: String?, view: UIView?) {
        if tip != nil {
            Tip = tip
        } else {
            Tip = kLoadSuccessTip
        }
        let superVw: UIView?
        if view != nil {
            superVw = view
        } else {
            superVw = UIApplication.shared.keyWindow
        }
        let hud = MBProgressHUD.showAdded(to: superVw!, animated: true)
        hud.mode = MBProgressHUDMode.customView
        hud.customView = UIImageView(image: UIImage(named: "success"))
        hud.labelText = Tip!
//        hud.label.text = Tip
        //延迟隐藏
        hud.hide(true, afterDelay: 2)
//        hud.hide(animated: true, afterDelay: 2)
    }
    
    class func showFailed(_ tip: String?, view: UIView?) {
        if tip != nil {
            Tip = tip
        } else {
            Tip = kLoadFaileTip
        }

        let superVw: UIView?
        if view != nil {
            superVw = view
        } else {
            superVw = UIApplication.shared.keyWindow
        }
        let hud = MBProgressHUD.showAdded(to: superVw!, animated: true)
        hud.mode = MBProgressHUDMode.customView
        hud.customView = UIImageView(image: UIImage(named: "error"))
        hud.labelText = Tip!
//        hud.label.text = Tip
        //延迟隐藏
        hud.hide(true, afterDelay: 2)
//        hud.hide(animated: true, afterDelay: 2)
    }
    
    class func showTipAndHideImmediately(_ tip: String?, details: String?, view: UIView?) {
        let superVw: UIView?
        if view != nil {
            superVw = view
        } else {
            superVw = UIApplication.shared.keyWindow
        }
        let hud = MBProgressHUD.showAdded(to: superVw!, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.labelText = tip!
//        hud.label.text = tip
        if details != nil && details!.characters.count > 0 {
            hud.detailsLabelText = details!
//            hud.detailsLabel.text = details
        }
        
        //延迟隐藏
        hud.hide(true, afterDelay: 2)
//        hud.hide(animated: true, afterDelay: 2)
    }
    
    class func showHUDAndTip(_ tip: String?, view: UIView?) {
        let superVw: UIView?
        if view != nil {
            superVw = view
        } else {
            superVw = UIApplication.shared.keyWindow
        }
        let hud = MBProgressHUD.showAdded(to: superVw!, animated: true)
        hud.labelText = tip!
//        hud.label.text = tip
    }
}
