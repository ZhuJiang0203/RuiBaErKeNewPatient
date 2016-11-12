//
//  VoiceTipView1.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/26.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  松开手指，取消发送

import UIKit

class VoiceTipView1: UIView {

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
    
    fileprivate static let tipView: VoiceTipView1 = {
        let tip = VoiceTipView1(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
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
        
        let imgVwWH: CGFloat = 75
        let imgVwX: CGFloat = (backViewWH - imgVwWH)/2
        let imgVwY: CGFloat = 15
        imgVw.frame = CGRect(x: imgVwX, y: imgVwY, width: imgVwWH, height: imgVwWH)
        let tipLblX: CGFloat = kMargin
        let tipLblW: CGFloat = backViewWH - 2*tipLblX
        tipLbl.frame = CGRect(x: tipLblX, y: imgVw.frame.maxY + 2*kMargin, width: tipLblW, height: 24)
        
        
        // 动画
        let img1 = UIImage(named: "SRecording1")!
        let img2 = UIImage(named: "SRecording2")!
        let img3 = UIImage(named: "SRecording3")!
        let img4 = UIImage(named: "SRecording4")!
        let img5 = UIImage(named: "SRecording5")!
        let img6 = UIImage(named: "SRecording6")!
        let img7 = UIImage(named: "SRecording7")!
        let img8 = UIImage(named: "SRecording8")!
        let img9 = UIImage(named: "SRecording9")!
        let animationImages = [img1, img2, img3, img4, img5, img6, img7, img8, img9]
        imgVw.animationImages = animationImages
        imgVw.animationDuration = 1;
        imgVw.startAnimating()
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
        imgVw.image = UIImage(named: "SRecording1")
        return imgVw
    }()
    
    fileprivate lazy var tipLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = kLoosenFingerCancleSend
        lbl.textColor = UIColor.white
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.textAlignment = .center
        lbl.backgroundColor = rgbaColor(155, g: 57, b: 57, a: 0.8)
        lbl.layer.cornerRadius = 2.5
        lbl.clipsToBounds = true
        return lbl
    }()
}
