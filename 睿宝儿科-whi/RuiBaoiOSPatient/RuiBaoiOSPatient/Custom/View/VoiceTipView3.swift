//
//  VoiceTipView3.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/26.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  说话时间太短

import UIKit

class VoiceTipView3: UIView {
    class func showVoiceTipView() {
        let window = UIApplication.shared.keyWindow!
        LLog(window)
        if tipView.superview != window {
            window.addSubview(tipView)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.75 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            dismissVoiceTipView()
        }
    }
    
    class func dismissVoiceTipView() {
        let window = UIApplication.shared.keyWindow!
        if tipView.superview == window {
            tipView.removeFromSuperview()
        }
    }
    
    fileprivate static let tipView: VoiceTipView3 = {
        let tip = VoiceTipView3(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
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
        
        let imgVwW: CGFloat = 16
        let imgVwH: CGFloat = 90
        let imgVwX: CGFloat = (backViewWH - imgVwW)/2
        let imgVwY: CGFloat = 15
        imgVw.frame = CGRect(x: imgVwX, y: imgVwY, width: imgVwW, height: imgVwH)
        let tipLblX: CGFloat = kMargin
        let tipLblW: CGFloat = backViewWH - 2*tipLblX
        tipLbl.frame = CGRect(x: tipLblX, y: imgVw.frame.maxY + kMargin, width: tipLblW, height: 24)
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
        imgVw.image = UIImage(named: "ConsulationTimeTooSmall")
        return imgVw
    }()
    
    fileprivate lazy var tipLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = kTalkTimeTooShort
        lbl.textColor = UIColor.white
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 2.5
        lbl.clipsToBounds = true
        return lbl
    }()
}
