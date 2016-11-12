//
//  BombBoxView.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/4.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  弹框

import UIKit

protocol BombBoxViewDelegate: NSObjectProtocol {
    func okButtonOfBombBoxViewClicked()
    func cancleButtonOfBombBoxViewClicked()
}

class BombBoxView: UIView {
    
    fileprivate var tip: String?
    weak var delegate: BombBoxViewDelegate?
    
    
    class func setupBombBoxView(_ tipContent: String) -> BombBoxView {
        return BombBoxView(tipContent: tipContent)
    }
    
    init(tipContent: String) {
        tip = tipContent
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        addSubview(masking)
        addSubview(bombBox)
        bombBox.addSubview(tipLabel)
        tipLabel.text = tip
        bombBox.addSubview(ok)
        bombBox.addSubview(cancle)
        
        masking.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        let bombBoxW: CGFloat = 266
        let bombBoxH: CGFloat = 154
        bombBox.frame = CGRect(x: (kScreenWidth - bombBoxW)/2, y: (kScreenHeight - bombBoxH)/2, width: bombBoxW, height: bombBoxH)
        let marginX: CGFloat = 26
        tipLabel.frame = CGRect(x: marginX, y: 34, width: bombBoxW - 2*marginX, height: 44)
        let btnW: CGFloat = 90
        let btnH: CGFloat = 30
        let btnY: CGFloat = tipLabel.frame.maxY + 22
        ok.frame = CGRect(x: marginX, y: btnY, width: btnW, height: btnH)
        let cancleX = bombBoxW - marginX - btnW
        cancle.frame = CGRect(x: cancleX, y: btnY, width: btnW, height: btnH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate lazy var masking: UIView = {
        let masking = UIView()
        masking.backgroundColor = rgbaColor(255, g: 255, b: 255, a: 0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(CustomAlertView.signOut))
        masking.addGestureRecognizer(tap)
        return masking
    }()
    
    fileprivate lazy var bombBox: UIImageView = {
        let bombBox = UIImageView()
        bombBox.image = UIImage(named: "Rectangle 810")
        return bombBox
    }()

    fileprivate lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.textColor = rgb50
        tipLabel.numberOfLines = 0
        tipLabel.font = font15
        return tipLabel
    }()
    
    fileprivate lazy var ok: UIButton = {
        let ok = UIButton()
        ok.setTitle(kEnsure, for: .normal)
        ok.setTitleColor(UIColor.white, for: .normal)
        ok.titleLabel?.font = font16
        ok.backgroundColor = appColor
        ok.addTarget(self, action: #selector(BombBoxView.okClicked), for: .touchUpInside)
        return ok
    }()
    
    func okClicked() {
        delegate?.okButtonOfBombBoxViewClicked()
    }

    fileprivate lazy var cancle: UIButton = {
        let cancle = UIButton()
        cancle.setTitle(kCancle, for: .normal)
        cancle.setTitleColor(UIColor.white, for: .normal)
        cancle.titleLabel?.font = font16
        cancle.backgroundColor = rgbColor(254, g: 128, b: 128)
        cancle.addTarget(self, action: #selector(BombBoxView.cancleClicked), for: .touchUpInside)
        return cancle
    }()
    
    func cancleClicked() {
        delegate?.cancleButtonOfBombBoxViewClicked()
    }
}
