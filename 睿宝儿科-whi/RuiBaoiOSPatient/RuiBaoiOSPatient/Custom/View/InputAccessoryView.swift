//
//  InputAccessoryView.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/7.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class InputAccessoryView: UITabBar {
    
    var tip: String?
    var ttv: UITextView?
    var ttf: UITextField?

    class func setUpInputAccessoryView(_ placeHoder: String?, textView: UITextView?, textField: UITextField?) -> InputAccessoryView {
        return InputAccessoryView.init(placeHoder: placeHoder, textView: textView, textField: textField)
    }
    
    init(placeHoder: String?, textView: UITextView?, textField: UITextField?) {
        tip = placeHoder
        ttv = textView
        ttf = textField
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        
        // 添加子控件
        addSubview(tipLabel)
        addSubview(overBtn)
        tipLabel.text = tip
        tipLabel.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 44)
        overBtn.frame = CGRect(x: kScreenWidth - 44, y: 0, width: 44, height: 44)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.textAlignment = .center
        tipLabel.textColor = rgb153
        tipLabel.font = font12
        return tipLabel
    }()
    
    fileprivate lazy var overBtn: UIButton = {
        let overBtn = UIButton()
        overBtn.setTitle(kOver, for: .normal)
        overBtn.setTitleColor(rgb50, for: .normal)
        overBtn.addTarget(self, action: #selector(InputAccessoryView.signOut), for: .touchUpInside)
        return overBtn
    }()
    
    func signOut() {
            ttv?.resignFirstResponder()
            ttf?.resignFirstResponder()
    }
}
