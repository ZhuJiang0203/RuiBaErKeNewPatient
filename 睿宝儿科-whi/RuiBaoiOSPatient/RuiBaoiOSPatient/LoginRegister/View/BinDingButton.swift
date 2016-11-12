//
//  BinDingButton.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class BinDingButton: UIButton {

    var iconWAndH: CGFloat = 0
    init(frame: CGRect, iconWH: CGFloat, iconImageNormal: String, iconImageSelected: String, text: String) {
        super.init(frame: frame)
        
        setImage(UIImage.init(named: iconImageNormal), for: .normal)
        setImage(UIImage.init(named: iconImageSelected), for: .selected)
        setImage(UIImage.init(named: iconImageSelected), for: .highlighted)
        setTitle(text, for: .normal)
        setTitleColor(rgbColor(136, g: 126, b: 132), for: .normal)
        titleLabel?.text = text
        titleLabel?.font = font16
        titleLabel?.textAlignment = .center
        imageView?.sizeToFit()

        iconWAndH = iconWH
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.center = CGPoint(x: frame.width/2, y: iconWAndH/2)
        titleLabel?.frame = CGRect(x: 0, y: iconWAndH, width: frame.width, height: frame.height - iconWAndH)
    }
}


