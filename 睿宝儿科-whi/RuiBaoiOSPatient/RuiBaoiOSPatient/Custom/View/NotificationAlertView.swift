//
//  NotificationAlertView.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/23.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

// 自定义协议需要实现 NSObjectProtocol协议
protocol NotificationAlertViewDelegate: NSObjectProtocol {
    // 默认情况下，自定义协议的方法都是必须实现的
    func noticeAlertViewDidClickedDone(_ alert: NotificationAlertView)
}

class NotificationAlertView: UIView {

    weak var delegate: NotificationAlertViewDelegate?

    // 显示加载提示框
    class func showNotificationAlertView() -> NotificationAlertView {
        let superVw = UIApplication.shared.keyWindow!
        let alert = NotificationAlertView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), toView: superVw)
        superVw.addSubview(alert)
        
        return alert
    }
    
    init(frame: CGRect, toView: UIView) {
        super.init(frame: frame)
        
        addSubview(maskingView)
        maskingView.addSubview(backView)
        backView.addSubview(imgVw)
        backView.addSubview(titleLbl)
        backView.addSubview(line)
        backView.addSubview(btn)
        
        maskingView.frame = frame
        let backW: CGFloat = 270
        let backH: CGFloat = 172
        let backX: CGFloat = (kScreenWidth - backW)/2
        let backY: CGFloat = (kScreenHeight - backH)/2
        backView.frame = CGRect(x: backX, y: backY, width: backW, height: backH)
        imgVw.center = CGPoint(x: backW/2, y: 38)
        let titleLblH = titleLbl.text!.calculateTheSizeOfTheString(font15, maxWidth: backW).height
        titleLbl.frame = CGRect(x: 16, y: imgVw.frame.maxY + 16, width: backW - 32, height: titleLblH)
        line.frame = CGRect(x: 0, y: titleLbl.frame.maxY + 16, width: backW, height: 0.5)
        btn.frame = CGRect(x: 0, y: line.frame.maxY, width: backW, height: 44)
        backView.frame.size.height = btn.frame.maxY
        
        UIView.animate(withDuration: 0.25, animations: {
            self.maskingView.backgroundColor = rgbaSameColor(0, a: 0.3)
        }) 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var maskingView: UIView = {
        let vw = UIView()
        vw.backgroundColor = rgbaSameColor(0, a: 0)
        return vw
    }()
    
    fileprivate lazy var backView: UIView = {
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: 125, height: 100))
        vw.layer.cornerRadius = 15
        vw.clipsToBounds = true
        vw.backgroundColor = UIColor.white
        return vw
    }()
    
    fileprivate lazy var imgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.image = UIImage(named: "confirmNotification")
        imgVw.sizeToFit()
        return imgVw
    }()
    
    fileprivate lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbColor(117, g: 122, b: 134)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = font15
        lbl.text = kTurnOffNotificationTip
        return lbl
    }()

    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(213)
        return line
    }()

    fileprivate lazy var btn: UIButton = {
        let btn = UIButton()
        btn.setTitle(kNextClickOK, for: .normal)
        btn.setTitleColor(rgbColor(3.0, g: 122.0, b: 255.0), for: .normal)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.addTarget(self, action: #selector(NotificationAlertView.doneBtnDidClicked), for: .touchUpInside)
        return btn
    }()
    
    func doneBtnDidClicked() {
        delegate?.noticeAlertViewDidClickedDone(self)
    }
}
