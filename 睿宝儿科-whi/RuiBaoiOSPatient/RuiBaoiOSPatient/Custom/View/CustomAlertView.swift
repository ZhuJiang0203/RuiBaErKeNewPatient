//
//  CustomAlertView.swift
//  XLWBSwift20160314
//
//  Created by whj on 16/4/6.
//  Copyright © 2016年 mifengyiliao. All rights reserved.
//
//
//  自定义类似于UIAlertController效果的控件

import UIKit

// 自定义协议需要实现 NSObjectProtocol协议
protocol CustomAlertViewDelegate: NSObjectProtocol {
    // 默认情况下，自定义协议的方法都是必须实现的
    func someButtonOfCustomAlertViewClicked(_ tagNumber: Int)
    func customAlertViewSignOut()
}

private let btnH: CGFloat = 50

class CustomAlertView: UIView {
    
    var tts: [String]
    weak var delegate: CustomAlertViewDelegate?

    class func setupCustomAlertView(_ titls: [String]) -> CustomAlertView {
        return CustomAlertView(titls: titls)
    }
    
    init(titls: [String]) {
        tts = titls
        LLog(tts)
        
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        // 子控件
        addSubview(masking)
        addSubview(backView)
        let backViewH: CGFloat = btnH*CGFloat(tts.count)
        backView.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: backViewH)
        backViewAddSunViews()

        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.masking.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0.2)
            self.backView.frame.origin.y = kScreenHeight - self.backView.frame.size.height
            }) { (_) -> Void in
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var masking: UIView = {
        let masking = UIView()
        masking.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        masking.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(CustomAlertView.signOut))
        masking.addGestureRecognizer(tap)
        return masking
    }()
    
    fileprivate lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = lineColor
        return backView
    }()
    
    fileprivate func backViewAddSunViews() {
        for i in 0..<tts.count {
            let btn = UIButton(frame: CGRect(x: 0, y: CGFloat(i)*btnH, width: kScreenWidth, height: btnH - 0.5))
            btn.backgroundColor = UIColor.white
            btn.setTitle(tts[i], for: .normal)
            btn.setTitleColor(rgb50, for: .normal)
            btn.titleLabel?.font = font15
            btn.titleLabel?.textAlignment = .center
            btn.tag = i
            btn.addTarget(self, action: #selector(CustomAlertView.btnClicked(_:)), for: .touchUpInside)
            backView.addSubview(btn)
        }
    }
    
    func btnClicked(_ btn: UIButton) {
        // 退出
        signOut()
        delegate?.someButtonOfCustomAlertViewClicked(btn.tag)
    }
    
    // MARK: - 退出
    func signOut() {
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.masking.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0)
            self.backView.frame.origin.y = kScreenHeight
            }) { (_) -> Void in
                self.removeFromSuperview()
                self.delegate!.customAlertViewSignOut()
        }
    }
}
