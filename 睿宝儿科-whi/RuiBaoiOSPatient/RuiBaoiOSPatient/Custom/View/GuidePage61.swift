//
//  GuidePage61.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/3.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class GuidePage61: UIView {

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        addSubview(backImageView)
        clipsToBounds = true
        
        backImageView.addSubview(phone)
        backImageView.addSubview(shadow)
        backImageView.addSubview(light)
        backImageView.addSubview(consulation)
        backImageView.addSubview(progress1)
        backImageView.addSubview(progress2)
        backImageView.addSubview(progress3)
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
            
            self.phone.frame.origin.x = 40.5
            self.icon.frame.origin.x = 137.5
            
        }) { (_) in
            
            self.shadow.isHidden = false
            self.light.isHidden = false
            
            self.consulation.isHidden = false
            self.consulation.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: duration, animations: {
                self.consulation.transform = CGAffineTransform.identity
                }, completion: { (_) in
                    UIView.animate(withDuration: duration, animations: {
                        self.progress1.frame.size.width = 160
                        
                        }, completion: { (_) in
                            
                            self.title1.isHidden = false
                            UIView.animate(withDuration: duration, animations: {
                                self.progress2.frame.size.width = 160
                                self.progress2.frame.origin.x = 86
                                self.title1.frame.size.width = 126
                                }, completion: { (_) in
                                    
                                    self.title2.isHidden = false
                                    UIView.animate(withDuration: duration, animations: {
                                        self.progress3.frame.size.width = 160
                                        self.title2.frame.size.width = 130
                                    })
                            })
                    })
            })
        }
    }
    
    // 还原
    func guidePage1Recovery() {
        
        phone.frame.origin.x = -294
        icon.frame.origin.x = kScreenWidth
        shadow.isHidden = true
        light.isHidden = true
        consulation.isHidden = true
        
        progress1.frame.size.width = 0
        progress2.frame.size.width = 0
        progress2.frame.origin.x = 246
        progress3.frame.size.width = 0
        title1.isHidden = true
        title2.isHidden = true
        title1.frame.size.width = 0
        title2.frame.size.width = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var backImageView: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        img.image = UIImage(named: "iPhoneguide61")
        return img
    }()
    
    // 手机
    fileprivate lazy var phone: UIImageView = {
        let img = UIImageView(frame: CGRect(x: -294, y: 339.5, width: 294, height: 55))
        img.image = UIImage(named: "GuidePage61Phone")
        return img
    }()
    
    // 阴影
    fileprivate lazy var shadow: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 128, y: 356.5, width: 118.5, height: 20))
        img.isHidden = true
        img.image = UIImage(named: "GuidePage61Shadow")
        return img
    }()
    
    // 光
    fileprivate lazy var light: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 63, y: 217, width: 250, height: 160))
        img.isHidden = true
        img.image = UIImage(named: "GuidePage61Light")
        return img
    }()
    
    // 聊天框
    fileprivate lazy var consulation: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 61.5, y: 76.5, width: 252.5, height: 164.5))
        img.image = UIImage(named: "GuidePage61Consulation")
        img.isHidden = true
        return img
    }()
    
    // 进度条1
    fileprivate lazy var progress1: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 132, y: 102, width: 0, height: 4))
        img.image = UIImage(named: "SpeedOfProgress6113")
        return img
    }()
    
    // 进度条2
    fileprivate lazy var progress2: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 246, y: 155, width: 0, height: 6))
        img.image = UIImage(named: "SpeedOfProgress612")
        return img
    }()
    
    // 进度条3
    fileprivate lazy var progress3: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 132, y: 210, width: 0, height: 4))
        img.image = UIImage(named: "SpeedOfProgress6113")
        return img
    }()
    
    // icon
    fileprivate lazy var icon: UIImageView = {
        let img = UIImageView(frame: CGRect(x: kScreenWidth, y: 269.5, width: 100, height: 100))
        img.image = UIImage(named: "GuidePage61Icon")
        /********************* 如果是睿宝，则打开下面代码 *******************/
        img.image = UIImage(named: "GuidePage61IconRuiBao")
        return img
    }()
    
    // 标题1
    fileprivate lazy var title1: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 124.5, y: 491, width: 0, height: 35))
        lbl.text = kConvenient
        lbl.textColor = rgbColor(36, g: 199, b: 137)
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textAlignment = .center
        lbl.isHidden = true
        return lbl
    }()
    
    // 标题2
    fileprivate lazy var title2: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 124.5, y: 526, width: 0, height: 25))
        lbl.text = kZeroDistanceDoctorsPatients
        lbl.textColor = rgbColor(36, g: 199, b: 137)
        lbl.font = font18
        lbl.textAlignment = .center
        lbl.isHidden = true
        return lbl
    }()

}
