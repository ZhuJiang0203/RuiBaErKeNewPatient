//
//  CustomShareView.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/12.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

@objc
protocol CustomShareViewDelegate: NSObjectProtocol {
    @objc optional func oneButtonClicked(_ btn: ShareButton, shareView: CustomShareView)
    @objc optional func cancleButtonClicked(_ shareView: CustomShareView)
}

var shareView: CustomShareView?
private let shareW: CGFloat = 266
private var shareH: CGFloat = 300

class CustomShareView: UIView {
    
    weak var delegate: CustomShareViewDelegate?
//    var icons = ["CopyLink", "ShareToPYQ", "ShareToWX", "ShareToWB", "ShareToQQ", "ShareToQQKJ"]
//    var tts = ["患者", "朋友圈", "微信", "微博", "QQ", "QQ空间"]
    var tts = [String]()
    
    class func shareShareView(_ ts: [String]) -> CustomShareView {
        let shareView = CustomShareView(ts: ts, frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))

        let window = UIApplication.shared.keyWindow
        window?.addSubview(shareView)
        
        return shareView
    }
    
    init(ts: [String], frame: CGRect) {
        tts = ts
        LLog(tts)
        super.init(frame: frame)
        
//        backgroundColor = rgbaSameColor(0, a: 0.35)

        // 添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(CustomShareView.cancleBtnClicked))
        addGestureRecognizer(tap)

        addSubview(backView)
        backView.addSubview(shareTip)
        backView.addSubview(addButtons())
        backView.addSubview(line)
        backView.addSubview(cancle)
        
        if tts.count < 4 {
            shareH = 220
        }
        let backViewX: CGFloat = (kScreenWidth - shareW)/2
        let backViewY: CGFloat = (kScreenHeight - shareH)/2
        backView.frame = CGRect(x: backViewX, y: backViewY, width: shareW, height: shareH)
        let marginXY: CGFloat = 20
        shareTip.frame = CGRect(x: marginXY, y: marginXY, width: 100, height: 20)
        let cancleH: CGFloat = 50
        let cancleY: CGFloat = shareH - kMargin - cancleH
        cancle.frame = CGRect(x: 0, y: cancleY, width: shareW, height: cancleH)
        line.frame = CGRect(x: marginXY, y: cancleY, width: shareW - 2*marginXY, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var backView: UIImageView = {
        let backView = UIImageView()
        backView.isUserInteractionEnabled = true
        backView.image = UIImage(named: "ShareBackView")
        return backView
    }()

    fileprivate lazy var shareTip: UILabel = {
        let lbl = UILabel()
        lbl.text = kShareTo
        lbl.textColor = rgb153
        lbl.font = font13
        return lbl
    }()
    
    func addButtons() -> UIView {
        let vw = UIView(frame: CGRect(x: 0, y: 50, width: shareW, height: 190))
        
        let btnW: CGFloat = 70
        let btnH: CGFloat = 95
        let maxOfLie = 3
        let btnMarginX: CGFloat = (shareW - btnW*CGFloat(maxOfLie))/(CGFloat(maxOfLie) + 1)
        for i in 0..<tts.count {
            let lieNumber = i%maxOfLie
            let lieRow = i/maxOfLie
            let btnX: CGFloat = btnMarginX + (btnMarginX + btnW)*CGFloat(lieNumber)
            let btnY: CGFloat = btnH*CGFloat(lieRow)
            let btn = ShareButton(frame: CGRect(x: btnX, y: btnY, width: btnW, height: btnH))
            btn.setTitle(tts[i], for: .normal)
            switch tts[i] {
            case kCopyLink:
                btn.tag = 0
                btn.setImage(UIImage(named: "CopyLink"), for: .normal)
            case kCircleOfFriends:
                btn.tag = 1
                btn.setImage(UIImage(named: "ShareToPYQ"), for: .normal)
            case kWeChat:
                btn.tag = 2
                btn.setImage(UIImage(named: "ShareToWX"), for: .normal)
            case "QQ":
                btn.tag = 3
                btn.setImage(UIImage(named: "ShareToQQ"), for: .normal)
            case kQQZone:
                btn.tag = 4
                btn.setImage(UIImage(named: "ShareToQQKJ"), for: .normal)
            case kMicroBlog:
                btn.tag = 5
                btn.setImage(UIImage(named: "ShareToWB"), for: .normal)
            default:
                LLog("")
            }
            btn.addTarget(self, action: #selector(CustomShareView.btnClicked(_:)), for: .touchUpInside)
            vw.addSubview(btn)
        }
        
        return vw
    }
    
    func btnClicked(_ btn: ShareButton) {
        delegate?.oneButtonClicked?(btn, shareView: self)
    }
    
    func cancleBtnClicked() {
        delegate?.cancleButtonClicked?(self)
    }

    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
    
    fileprivate lazy var cancle: UIButton = {
        let cancle = UIButton()
        cancle.setTitle(kCancle, for: .normal)
        cancle.titleLabel?.font = font13
        cancle.setTitleColor(rgb153, for: .normal)
        cancle.addTarget(self, action: #selector(CustomShareView.cancleBtnClicked), for: .touchUpInside)
        return cancle
    }()
}
