//
//  KeyboardSelecteView.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/8.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class KeyboardSelecteView: UIView {

    var iconString: String?
    var textString: String?
    
    class func setupKeyboardSelecteView(_ frame: CGRect, icon: String?, text: String?) -> KeyboardSelecteView {
        return KeyboardSelecteView.init(frame: frame, icon: icon, text: text)
    }

    init(frame: CGRect, icon: String?, text: String?) {
        iconString = icon
        textString = text
        super.init(frame: frame)
        
        // 创建子控件
//        addSubview(<#T##view: UIView##UIView#>)
//        addSubview(<#T##view: UIView##UIView#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    pin
    
}
