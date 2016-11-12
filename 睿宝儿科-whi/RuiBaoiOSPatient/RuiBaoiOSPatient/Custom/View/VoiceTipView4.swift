//
//  VoiceTipView4.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/31.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  发送图片

import UIKit

class VoiceTipView4: UIView {

    class func showVoiceTipView() {
        let window = UIApplication.shared.keyWindow!
        LLog(window)
        if tipView.superview != window {
            window.addSubview(tipView)
        }
    }
    
    class func dismissVoiceTipView() {
        let window = UIApplication.shared.keyWindow!
        if tipView.superview == window {
            tipView.removeFromSuperview()
        }
    }
    
    fileprivate static let tipView: VoiceTipView4 = {
        let tip = VoiceTipView4(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        tip.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0)
        return tip
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backView)
        backView.addSubview(imgVw)
        backView.addSubview(tipLbl)
        
        let backViewWH: CGFloat = 150
        let backViewX: CGFloat = (kScreenWidth - backViewWH)/2
        let backViewY: CGFloat = (kScreenHeight - backViewWH)/2
        backView.frame = CGRect(x: backViewX, y: backViewY, width: backViewWH, height: backViewWH)
        
        let imgVwWH: CGFloat = 60
        let imgVwX: CGFloat = (backViewWH - imgVwWH)/2
        let imgVwY: CGFloat = 25
        imgVw.frame = CGRect(x: imgVwX, y: imgVwY, width: imgVwWH, height: imgVwWH)
        let tipLblX: CGFloat = kMargin
        let tipLblW: CGFloat = backViewWH - 2*tipLblX
        tipLbl.frame = CGRect(x: tipLblX, y: imgVw.frame.maxY + 2*kMargin, width: tipLblW, height: 24)
        
        // 设置动画
        // 1.创建动画对象
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        // 2.设置动画属性
        animation.toValue = 2*M_PI
        animation.duration = 1.5
        animation.repeatCount = MAXFLOAT
        // !!! removedOnCompletion默认：true --->（只要动画执行完毕就会移除动画）!!!
        animation.isRemovedOnCompletion = false
        // 3.将动画添加到layer上
        imgVw.layer.add(animation, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var backView: UIView = {
        let vw = UIView()
        vw.layer.cornerRadius = 2.5
        vw.clipsToBounds = true
        vw.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0.5)
        return vw
    }()
    
    fileprivate lazy var imgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.image = UIImage(named: "SendRecording1")
        return imgVw
    }()
    
    fileprivate lazy var tipLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = kSendPictureSlower
        lbl.textColor = UIColor.white
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 2.5
        lbl.clipsToBounds = true
        return lbl
    }()
}
