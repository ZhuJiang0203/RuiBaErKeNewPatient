
//
//  UITextField+Extension.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/7.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

extension UITextField {
    
//    public override func canBecomeFirstResponder() -> Bool {
//        
//        if !isFirstResponder() {
//            inputAccessoryView = setUpInputAccessoryView()
//        }
//        
//        if !isFirstResponder() {
//            return true
//        }
//        return false
//    }
    
    func setUpInputAccessoryView() -> UITabBar {
        let tabBar = UITabBar(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        
        let tipLabel = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        tipLabel.textAlignment = .center
        tipLabel.textColor = rgb153
        tipLabel.font = font12
        tipLabel.text = placeholder
        tabBar.addSubview(tipLabel)
        
        let overBtn = UIButton(frame: CGRect(x: kScreenWidth - 44, y: 0, width: 44, height: 44))
        overBtn.setTitle(kOver, for: .normal)
        overBtn.setTitleColor(rgb50, for: .normal)
        overBtn.addTarget(self, action: #selector(InputAccessoryView.signOut), for: .touchUpInside)
        tabBar.addSubview(overBtn)
        
        return tabBar
    }
    
    func signOut() {
        resignFirstResponder()
    }
}
