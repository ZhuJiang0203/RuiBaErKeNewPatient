//
//  GuidePage41.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/3.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private var GuidePage41PhoneW: CGFloat = 251

class GuidePage41: UIView {
    
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
            self.phone.frame.origin.x = 34.5
            self.icon.frame.origin.x = 117.5
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
                        self.progress1.frame.size.width = 137
                        
                        }, completion: { (_) in
                            self.title1.isHidden = false
                            UIView.animate(withDuration: duration, animations: {
                                self.progress2.frame.size.width = 137
                                self.progress2.frame.origin.x = 20.5
                                self.title1.frame.size.width = 108
                                }, completion: { (_) in
                                    self.title2.isHidden = false
                                    UIView.animate(withDuration: duration, animations: {
                                        self.progress3.frame.size.width = 137
                                        self.title2.frame.size.width = 108
                                    })
                            })
                    })
            })
        }
    }
    
    // 还原
    func guidePage1Recovery() {
        
        phone.frame.origin.x = -GuidePage41PhoneW
        icon.frame.origin.x = kScreenWidth
        shadow.isHidden = true
        light.isHidden = true
        consulation.isHidden = true
        
        progress1.frame.size.width = 0
        progress2.frame.size.width = 0
        progress2.frame.origin.x = 157
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
        img.image = UIImage(named: "iPhoneguide41")
        return img
    }()
    
    // 手机
    fileprivate lazy var phone: UIImageView = {
        let img = UIImageView(frame: CGRect(x: -GuidePage41PhoneW, y: 260, width: GuidePage41PhoneW, height: 47))
        img.image = UIImage(named: "GuidePage41Phone")
        return img
    }()
    
    // 阴影
    fileprivate lazy var shadow: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 109.5, y: 274, width: 101, height: 17))
        img.isHidden = true
        img.image = UIImage(named: "GuidePage41Shadow")
        return img
    }()
    
    // 光
    fileprivate lazy var light: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 53.5, y: 155, width: 213, height: 137))
        img.isHidden = true
        img.image = UIImage(named: "GuidePage41Light")
        return img
    }()
    
    // 聊天框
    fileprivate lazy var consulation: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 52.5, y: 35, width: 215, height: 140))
        img.image = UIImage(named: "GuidePage41Consulation")
        img.isHidden = true
        return img
    }()
    
    // 进度条1
    fileprivate lazy var progress1: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 60, y: 22, width: 0, height: 3.5))
        img.image = UIImage(named: "SpeedOfProgress4113")
        return img
    }()
    
    // 进度条2
    fileprivate lazy var progress2: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 157, y: 67, width: 0, height: 5))
        img.image = UIImage(named: "SpeedOfProgress412")
        return img
    }()
    
    // 进度条3
    fileprivate lazy var progress3: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 60, y: 114, width: 0, height: 3.5))
        img.image = UIImage(named: "SpeedOfProgress4113")
        return img
    }()
    
    // icon
    fileprivate lazy var icon: UIImageView = {
        let img = UIImageView(frame: CGRect(x: kScreenWidth, y: 200, width: 85, height: 85))
        img.image = UIImage(named: "GuidePage41Icon")
        /********************* 如果是睿宝，则打开下面代码 *******************/
        img.image = UIImage(named: "GuidePage41IconRuiBao")
        return img
    }()
    
    // 标题1
    fileprivate lazy var title1: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 98.5, y: 364, width: 0, height: 30))
        lbl.text = kConvenient
        lbl.textColor = rgbColor(36, g: 199, b: 137)
        lbl.font = UIFont.boldSystemFont(ofSize: 21)
        lbl.textAlignment = .center
        lbl.isHidden = true
        return lbl
    }()
    
    // 标题2
    fileprivate lazy var title2: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 98.5, y: 394, width: 0, height: 22))
        lbl.text = kZeroDistanceDoctorsPatients
        lbl.textColor = rgbColor(36, g: 199, b: 137)
        lbl.font = font15
        lbl.textAlignment = .center
        lbl.isHidden = true
        return lbl
    }()
}
