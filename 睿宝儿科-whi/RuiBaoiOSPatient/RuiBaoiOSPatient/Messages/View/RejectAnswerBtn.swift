//
//  RejectAnswerBtn.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/6/21.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  拒绝、接听

import UIKit

class RejectAnswerBtn: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(rgbColor(150, g: 154, b: 160), for: .normal)
        titleLabel?.font = font12
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnW: CGFloat = 50
        let ttY: CGFloat = 53
        let ttH: CGFloat = 14
        
        imageView?.frame = CGRect(x: 0, y: 0, width: btnW, height: btnW)
        titleLabel?.frame = CGRect(x: 0, y: ttY, width: btnW, height: ttH)
    }
}
