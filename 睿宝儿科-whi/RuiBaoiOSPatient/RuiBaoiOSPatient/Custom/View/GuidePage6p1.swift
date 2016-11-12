//
//  GuidePage6p1.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/3.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private var GuidePage61PhoneW: CGFloat = 325

class GuidePage6p1: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        addSubview(backImageView)
        clipsToBounds = true
        
        backImageView.addSubview(phone)
        backImageView.addSubview(shadow)
        backImageView.addSubview(light)
        backImageView.addSubview(consulation)
        consulation.addSubview(progress1)
        consulation.addSubview(progress2)
        consulation.addSubview(progress3)
        backImageView.addSubview(icon)
        backImageView.addSubview(title1)
        backImageView.addSubview(title2)
        
        // 动画
        guidePage1StartMoving()
    }
    
    // MARK:- 动画
    func guidePage1StartMoving() {
        
        let duration: TimeInterval = 0.5
        
        UIView.animate(withDuration: duration, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.phone.frame.origin.x = 44.5
            self.icon.frame.origin.x = 152
        }) { (_) in
            
            self.shadow.isHidden = false
            self.light.isHidden = false
            
            // 聊天框
            self.consulation.isHidden = false
            self.consulation.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: duration, animations: {
                self.consulation.transform = CGAffineTransform.identity
                }, completion: { (_) in
                    
                    // 进度条、文本框
                    UIView.animate(withDuration: duration, animations: {
                        self.progress1.frame.size.width = 177
                        
                        }, completion: { (_) in
                            self.title1.isHidden = false
                            UIView.animate(withDuration: duration, animations: {
                                self.progress2.frame.size.width = 177
                                self.progress2.frame.origin.x = 27
                                self.title1.frame.size.width = 140
                                }, completion: { (_) in
                                    self.title2.isHidden = false
                                    UIView.animate(withDuration: duration, animations: {
                                        self.progress3.frame.size.width = 177
                                        self.title2.frame.size.width = 150
                                    })
                            })
                    })
            })
        }
    }
    
    // 还原
    func guidePage1Recovery() {
        
        phone.frame.origin.x = -GuidePage61PhoneW
        icon.frame.origin.x = kScreenWidth
        shadow.isHidden = true
        light.isHidden = true
        consulation.isHidden = true
        
        progress1.frame.size.width = 0
        progress2.frame.size.width = 0
        progress2.frame.origin.x = 204
        progress3.frame.size.width = 0
        title1.isHidden = true
        title1.frame.size.width = 0
        title2.isHidden = true
        title2.frame.size.width = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var backImageView: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        img.image = UIImage(named: "iPhoneguide6p1")
        return img
    }()
    
    // 手机
    fileprivate lazy var phone: UIImageView = {
        let img = UIImageView(frame: CGRect(x: -GuidePage61PhoneW, y: 375, width: GuidePage61PhoneW, height: 61))
        img.image = UIImage(named: "GuidePage6p1Phone")
        return img
    }()
    
    // 阴影
    fileprivate lazy var shadow: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 141.5, y: 393.4, width: 131, height: 22))
        img.isHidden = true
        img.image = UIImage(named: "GuidePage6p1Shadow")
        return img
    }()
    
    // 光
    fileprivate lazy var light: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 69.5, y: 239.5, width: 275, height: 177))
        img.isHidden = true
        img.image = UIImage(named: "GuidePage6p1Light")
        return img
    }()
    
    // 聊天框
    fileprivate lazy var consulation: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 67.5, y: 84, width: 279, height: 186))
        img.image = UIImage(named: "GuidePage6p1Consulation")
        img.isHidden = true
        return img
    }()
    
    // 进度条1
    fileprivate lazy var progress1: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 78, y: 28, width: 0, height: 4.5))
        img.image = UIImage(named: "SpeedOfProgress6p113")
        return img
    }()
    
    // 进度条2
    fileprivate lazy var progress2: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 204, y: 86.5, width: 0, height: 5))
        img.image = UIImage(named: "SpeedOfProgress6p12")
        return img
    }()
    
    // 进度条3
    fileprivate lazy var progress3: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 78, y: 148, width: 0, height: 4.5))
        img.image = UIImage(named: "SpeedOfProgress6p113")
        return img
    }()
    
    // icon
    fileprivate lazy var icon: UIImageView = {
        let img = UIImageView(frame: CGRect(x: kScreenWidth, y: 297, width: 110, height: 110))
        img.image = UIImage(named: "GuidePage6p1Icon")
        /********************* 如果是睿宝，则打开下面代码 *******************/
        img.image = UIImage(named: "GuidePage6p1IconRuiBao")
        return img
    }()
    
    // 标题1
    fileprivate lazy var title1: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 137, y: 542, width: 0, height: 38.5))
        lbl.text = kConvenient
        lbl.textColor = rgbColor(36, g: 199, b: 137)
        lbl.font = UIFont.boldSystemFont(ofSize: 27)
        lbl.textAlignment = .center
        lbl.isHidden = true
        return lbl
    }()
    
    // 标题2
    fileprivate lazy var title2: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 137, y: 580.5, width: 0, height: 27.5))
        lbl.text = kZeroDistanceDoctorsPatients
        lbl.textColor = rgbColor(36, g: 199, b: 137)
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.isHidden = true
        return lbl
    }()
    
}
