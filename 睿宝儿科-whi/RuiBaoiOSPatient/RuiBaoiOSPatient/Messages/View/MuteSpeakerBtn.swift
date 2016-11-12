//
//  MuteSpeakerBtn.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/6/21.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  静音、扬声器

import UIKit

class MuteSpeakerBtn: UIButton {

    // 是扬声器吗？
    var isSpeaker = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(rgbColor(95, g: 101, b: 111), for: .normal)
        titleLabel?.font = font13
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnW = kScreenWidth/2
        
        var imgW: CGFloat = 28
        var imgH: CGFloat = 30
        var imgY: CGFloat = 0
        if isSpeaker == true {
            imgW = 30
            imgH = 27
            imgY = 1.5
        }
        let imgX = (btnW - imgW)/2

        
        imageView?.frame = CGRect(x: imgX, y: imgY, width: imgW, height: imgH)
        titleLabel?.frame = CGRect(x: 0, y: 36, width: btnW, height: 16)
    }

}
