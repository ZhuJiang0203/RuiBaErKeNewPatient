//
//  ConsulationView.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/8.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

@objc
protocol ConsulationViewDelegate: NSObjectProtocol {
    @objc optional func oneButtonOfConsulationViewClicked(_ btn: UIButton)
    @objc optional func beginRecordAction(_ btn: UIButton)
    @objc optional func endRecordAction(_ btn: UIButton)
    @objc optional func cancelRecordAction(_ btn: UIButton)
}

class ConsulationView: UIView {
    
    weak var delegate: ConsulationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = rgbColor(244, g: 244, b: 246)
        
        addSubview(line)
        addSubview(voice)
        addSubview(textField)
        textField.addSubview(voiceBtn)
//        addSubview(picturesBtn)
        addSubview(addBtn)
        
        let btnWH: CGFloat = 30
        voice.frame = CGRect(x: kMargin, y: kMargin, width: btnWH, height: btnWH)
        let fieldX: CGFloat = voice.frame.maxX + kMargin
        let fieldW: CGFloat = kScreenWidth - 4*kMargin - 2*btnWH
        textField.frame = CGRect(x: fieldX, y: kMargin, width: fieldW, height: btnWH)
        voiceBtn.frame = textField.bounds
//        picturesBtn.frame = CGRectMake(CGRectGetMaxX(textField.frame) + kMargin, kMargin, btnWH, btnWH)
        addBtn.frame = CGRect(x: textField.frame.maxX + kMargin, y: kMargin, width: btnWH, height: btnWH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(210)
        line.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5)
        return line
    }()

    fileprivate lazy var voice: UIButton = {
        let voice = UIButton()
        voice.tag = 0
        voice.setImage(UIImage(named: "Group 9-1"), for: .normal)
        voice.setImage(UIImage(named: "Group 7"), for: .selected)
        voice.addTarget(self, action: #selector(ConsulationView.oneButtonClicked(_:)), for: .touchUpInside)
        return voice
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.backgroundColor = UIColor.white
        return textField
    }()
    
    fileprivate lazy var voiceBtn: UIButton = {
        let voiceBtn = UIButton()
        voiceBtn.setTitle(kHoldDownToTalk, for: .normal)
        voiceBtn.setTitle(kLoosenTheEnd, for: .highlighted)
        voiceBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        voiceBtn.setTitleColor(rgb50, for: .normal)
        voiceBtn.setBackgroundImage(UIImage(named: "voiceBackground"), for: .normal)
        voiceBtn.layer.cornerRadius = 2.5
        voiceBtn.clipsToBounds = true
        voiceBtn.layer.borderColor = rgb153.cgColor
        voiceBtn.layer.borderWidth = 0.5
        voiceBtn.addTarget(self, action: #selector(ConsulationView.voiceBtnTouchUpInside(_:)), for: .touchUpInside)
        voiceBtn.addTarget(self, action: #selector(ConsulationView.voiceBtnTouchDown(_:)), for: .touchDown)
        voiceBtn.addTarget(self, action: #selector(ConsulationView.voiceBtnTouchUpOutside(_:)), for: .touchUpOutside)
        voiceBtn.isHidden = true
        return voiceBtn
    }()

    fileprivate lazy var picturesBtn: UIButton = {
        let picturesBtn = UIButton()
        picturesBtn.tag = 0
        picturesBtn.setImage(UIImage(named: "iconfont-biaoqing"), for: .normal)
        picturesBtn.addTarget(self, action: #selector(ConsulationView.oneButtonClicked(_:)), for: .touchUpInside)
        return picturesBtn
    }()

    fileprivate lazy var addBtn: UIButton = {
        let addBtn = UIButton()
        addBtn.tag = 1
        addBtn.setImage(UIImage(named: "iconfont-tianjia"), for: .normal)
        addBtn.addTarget(self, action: #selector(ConsulationView.oneButtonClicked(_:)), for: .touchUpInside)
        return addBtn
    }()
    
    func oneButtonClicked(_ btn: UIButton) {
        if btn.tag == 0 {
            btn.isSelected = !btn.isSelected
        } else {
            voice.isSelected = false
        }
        voiceBtn.isHidden = !btn.isSelected
        delegate?.oneButtonOfConsulationViewClicked!(btn)
    }
    
    func voiceBtnTouchDown(_ btn: UIButton) {
        delegate?.beginRecordAction?(btn)
    }
    
    func voiceBtnTouchUpInside(_ btn: UIButton) {
        delegate?.endRecordAction?(btn)
    }
    
    func voiceBtnTouchUpOutside(_ btn: UIButton) {
        delegate?.cancelRecordAction?(btn)
    }
}
