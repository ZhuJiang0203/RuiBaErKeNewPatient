//
//  CustomLoadTip.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/1.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class CustomLoadTip: UIView {
    
    // 显示加载提示框
    class func showLoadTip(_ toView: UIView?, tip: String? = kLoading) -> CustomLoadTip {
      
        var superVw: UIView = UIApplication.shared.keyWindow!
        var frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        if toView != nil {
            superVw = toView!
            frame = toView!.bounds
        }
        
        let tip = CustomLoadTip(frame: frame, toView: superVw, tip: tip)
        superVw.addSubview(tip)
        
        return tip
    }
    
    func hideLoadTipWithSuccess(tip: String? = kLoadSuccessTip) {
        
        superview?.bringSubview(toFront: self)
        
        // 展示成功提示
        tipLbl.text = tip
        
        
        self.imgVw.isHidden = true
        self.circleImgVw.isHidden = false
        self.successOK.isHidden = false
        self.successOK.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.25, animations: {
            self.successOK.transform = CGAffineTransform.identity
            }, completion: { (_) in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                    
                    UIView.animate(withDuration: 0.25, animations: {
                        self.backView.alpha = 0
                        }, completion: { (_) in
                            self.removeFromSuperview()
                    })
                }
        })
    }
    
    func hideLoadTipWithError(tip: String? = kLoadFaileTip) {
        
        superview?.bringSubview(toFront: self)
        
        // 展示失败原因
        tipLbl.text = tip
        
        self.imgVw.isHidden = true
        self.circleImgVw.isHidden = false
        
        self.errorRight.isHidden = false
        self.errorRight.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.25, animations: {
            self.errorRight.transform = CGAffineTransform.identity
            }, completion: { (_) in
                
                self.errorLeft.isHidden = false
                self.errorLeft.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                UIView.animate(withDuration: 0.25, animations: {
                    self.errorLeft.transform = CGAffineTransform.identity
                    }, completion: { (_) in
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                            
                            UIView.animate(withDuration: 0.25, animations: {
                                self.backView.alpha = 0
                                }, completion: { (_) in
                                    self.removeFromSuperview()
                            })
                        }
                })
                
        })
    }
    

    init(frame: CGRect, toView: UIView, tip: String?) {
        super.init(frame: frame)
        
        addSubview(maskingView)
        maskingView.addSubview(backView)
        backView.addSubview(tipLbl)
        backView.addSubview(imgVw)
        backView.addSubview(circleImgVw)
        circleImgVw.addSubview(successOK)
        circleImgVw.addSubview(errorLeft)
        circleImgVw.addSubview(errorRight)
        
        
        maskingView.frame = toView.bounds
        let backViewW: CGFloat = 125
        let backViewH: CGFloat = 100
        backView.frame.size = CGSize(width: backViewW, height: backViewH)
        backView.center = CGPoint(x: maskingView.frame.width/2, y: maskingView.frame.height/2)
        let tipLblH: CGFloat = 40
        let tipLblY: CGFloat = backViewH - tipLblH
        tipLbl.frame = CGRect(x: 0, y: tipLblY, width: backViewW, height: tipLblH)
        tipLbl.text = tip

        var imgVwCenter = CGPoint.zero
        if tip != nil && tip!.characters.count > 0 { // 有内容
            imgVwCenter = CGPoint(x: backView.frame.width/2, y: backView.frame.height/2 - 10)
            tipLbl.isHidden = false
        } else { // 没内容
            imgVwCenter = CGPoint(x: backView.frame.width/2, y: backView.frame.height/2)
            tipLbl.isHidden = true
        }
        imgVw.center = imgVwCenter
        circleImgVw.center = imgVwCenter

        
        

        // 设置动画
        // 1.创建动画对象
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        // 2.设置动画属性
        animation.toValue = 2*M_PI
        animation.duration = 0.5
        animation.repeatCount = MAXFLOAT
        // !!! removedOnCompletion默认：true --->（只要动画执行完毕就会移除动画）!!!
        animation.isRemovedOnCompletion = false
        // 3.将动画添加到layer上
        imgVw.layer.add(animation, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var maskingView: UIView = {
        let vw = UIView()
        vw.backgroundColor = rgbaSameColor(0, a: 0.0)
        return vw
    }()

    fileprivate lazy var backView: UIView = {
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: 125, height: 100))
        vw.layer.cornerRadius = 15
        vw.clipsToBounds = true
        vw.backgroundColor = rgbaSameColor(0, a: 0.7)
        return vw
    }()
    
    fileprivate lazy var imgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.image = UIImage(named: "LoadTipIcon")
        imgVw.sizeToFit()
        return imgVw
    }()
    
    fileprivate lazy var circleImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.image = UIImage(named: "LoadTipSuccessCircle")
        imgVw.isHidden = true
        imgVw.sizeToFit()
        return imgVw
    }()
    
    fileprivate lazy var successOK: UIImageView = {
        let imgVw = UIImageView(frame: CGRect(x: 11, y: 13, width: 20, height: 14))
        imgVw.image = UIImage(named: "LoadTipSuccessOK")
        imgVw.contentMode = .scaleAspectFit
        imgVw.isHidden = true
        return imgVw
    }()
    
    fileprivate lazy var errorLeft: UIImageView = {
        let imgVw = UIImageView(frame: CGRect(x: 13, y: 13, width: 14, height: 14))
        imgVw.image = UIImage(named: "LoadTipErrorLeft")
        imgVw.contentMode = .scaleAspectFit
        imgVw.isHidden = true
        return imgVw
    }()
    
    fileprivate lazy var errorRight: UIImageView = {
        let imgVw = UIImageView(frame: CGRect(x: 13, y: 13, width: 14, height: 14))
        imgVw.image = UIImage(named: "LoadTipErrorRight")
        imgVw.contentMode = .scaleAspectFit
        imgVw.isHidden = true
        return imgVw
    }()
    

    
    private lazy var tipLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.textAlignment = .center
        return lbl
    }()
}
