//
//  GuidePage52.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/3.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

@objc
protocol GuidePage52Delegate: NSObjectProtocol {
    @objc optional func GuidePage52TurnOnLianKang()
}

private var GuidePage52ToolsW: CGFloat = 201
private var GuidePage52ToolCenterY: CGFloat = 49

class GuidePage52: UIView {
    
    weak var delegate: GuidePage52Delegate?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        addSubview(backImageView)
        clipsToBounds = true
        
        backImageView.addSubview(phone)
        backImageView.addSubview(tools)
        tools.addSubview(tool1)
        tools.addSubview(tool2)
        tools.addSubview(tool3)
        tools.addSubview(tool4)
        backImageView.addSubview(title1)
        backImageView.addSubview(title2)
        backImageView.addSubview(button)
    }
    
    // MARK:- 动画
    func guidePage2StartMoving() {
                
        let duration: TimeInterval = 0.5
        
        // 手机
        self.phone.isHidden = false
        self.phone.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: duration, delay: duration, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.phone.transform = CGAffineTransform.identity
        }) { (_) in
            
            // 工具箱
            self.tools.isHidden = false
            self.tools.transform = CGAffineTransform(scaleX: 1.0, y: 0.01)
            UIView.animate(withDuration: duration, animations: {
                self.tools.transform = CGAffineTransform.identity
                
                }, completion: { (_) in
                    
                    // 标题
                    self.title1.isHidden = false
                    UIView.animate(withDuration: duration, animations: {
                        self.title1.frame.size.width = 108
                        }, completion: { (_) in
                            self.title2.isHidden = false
                            UIView.animate(withDuration: duration, animations: {
                                self.title2.frame.size.width = 108
                                }, completion: { (_) in
                                    LLog("")
                            })
                    })
                    
                    // 工具1、2、3、4
                    self.tool1.isHidden = false
                    self.tool1.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: duration/2, animations: {
                        self.tool1.transform = CGAffineTransform.identity
                        }, completion: { (_) in
                            
                            self.tool2.isHidden = false
                            self.tool2.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                            UIView.animate(withDuration: duration/2, animations: {
                                self.tool2.transform = CGAffineTransform.identity
                                }, completion: { (_) in
                                    
                                    self.tool3.isHidden = false
                                    self.tool3.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                                    UIView.animate(withDuration: duration/2, animations: {
                                        self.tool3.transform = CGAffineTransform.identity
                                        }, completion: { (_) in
                                            
                                            self.tool4.isHidden = false
                                            self.tool4.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                                            UIView.animate(withDuration: duration/2, animations: {
                                                self.tool4.transform = CGAffineTransform.identity
                                                }, completion: { (_) in
                                                    
                                                    // 开启连康
                                                    self.button.isHidden = false
                                                    UIView.animate(withDuration: duration, animations: {
                                                        self.button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                                                        }, completion: { (_) in
                                                            UIView.animate(withDuration: duration, animations: {
                                                                self.button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                                                }, completion: { (_) in
                                                                    UIView.animate(withDuration: duration, animations: {
                                                                        self.button.transform = CGAffineTransform.identity
                                                                    })
                                                            })
                                                    })
                                            })
                                    })
                            })
                    })
            })
        }
    }
    
    // 还原
    func guidePage2Recovery() {
        
        phone.isHidden = true
        tools.isHidden = true
        tool1.isHidden = true
        tool2.isHidden = true
        tool3.isHidden = true
        tool4.isHidden = true
        title1.isHidden = true
        title1.frame.size.width = 0
        title2.isHidden = true
        title2.frame.size.width = 0
        button.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var backImageView: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        img.image = UIImage(named: "iPhoneguide52")
        img.isUserInteractionEnabled = true
        return img
    }()
    
    // 手机
    fileprivate lazy var phone: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 86, y: 61.5, width: 148, height: 275))
        img.image = UIImage(named: "GuidePage52Phone")
        img.isHidden = true
        return img
    }()
    
    // 我的工具
    fileprivate lazy var tools: UIImageView = {
        let imgH: CGFloat = 87
        let imgY: CGFloat = 138
        let imgX = (kScreenWidth - GuidePage52ToolsW)/2
        let img = UIImageView(frame: CGRect(x: imgX, y: imgY, width: GuidePage52ToolsW, height: imgH))
        img.image = UIImage(named: "tool52s")
        img.isHidden = true
        return img
    }()
    
    // 我的工具1
    fileprivate lazy var tool1: UIImageView = {
        let imgW: CGFloat = GuidePage52ToolsW/4.0
        let imgX = imgW/2
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        img.image = UIImage(named: "tool521")
        img.center = CGPoint(x: imgX, y: GuidePage52ToolCenterY)
        img.isHidden = true
        return img
    }()
    
    // 我的工具2
    fileprivate lazy var tool2: UIImageView = {
        let imgW: CGFloat = GuidePage52ToolsW/4.0
        let imgX = imgW/2 + imgW
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        img.image = UIImage(named: "tool522")
        img.center = CGPoint(x: imgX, y: GuidePage52ToolCenterY)
        img.isHidden = true
        return img
    }()
    
    // 我的工具3
    fileprivate lazy var tool3: UIImageView = {
        let imgW: CGFloat = GuidePage52ToolsW/4.0
        let imgX = imgW/2 + imgW*2
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 13, height: 15))
        img.image = UIImage(named: "tool523")
        img.center = CGPoint(x: imgX, y: GuidePage52ToolCenterY)
        img.isHidden = true
        return img
    }()
    
    // 我的工具4
    fileprivate lazy var tool4: UIImageView = {
        let imgW: CGFloat = GuidePage52ToolsW/4.0
        let imgX = imgW/2 + imgW*3
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        img.image = UIImage(named: "tool524")
        img.center = CGPoint(x: imgX, y: GuidePage52ToolCenterY)
        img.isHidden = true
        return img
    }()
    
    // 标题1
    fileprivate lazy var title1: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 106, y: 418, width: 0, height: 30))
        lbl.text = kEfficient
        lbl.textColor = rgbColor(36, g: 199, b: 137)
        lbl.font = UIFont.boldSystemFont(ofSize: 21)
        lbl.textAlignment = .center
        lbl.isHidden = true
        return lbl
    }()
    
    // 标题2
    fileprivate lazy var title2: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 106, y: 448, width: 0, height: 22))
        lbl.text = kDoctorPersonalAssistant
        lbl.textColor = rgbColor(36, g: 199, b: 137)
        lbl.font = font15
        lbl.textAlignment = .center
        lbl.isHidden = true
        return lbl
    }()
    
    // 开启连康
    fileprivate lazy var button: UIButton = {
        
        let btn = UIButton(frame: CGRect(x: 95, y: 496, width: 130, height: 36.5))
        btn.setTitle(kOpenRuiBao, for: .normal)
        btn.setTitleColor(rgbColor(36, g: 199, b: 137), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.layer.cornerRadius = kRadius
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = rgbColor(36, g: 199, b: 137).cgColor
        btn.addTarget(self, action: #selector(GuidePage52.turnOnLianKang), for: .touchUpInside)
        btn.isHidden = true
        
        return btn
    }()
    
    // MARK:- 开启连康
    func turnOnLianKang() {
        delegate?.GuidePage52TurnOnLianKang!()
    }
}
