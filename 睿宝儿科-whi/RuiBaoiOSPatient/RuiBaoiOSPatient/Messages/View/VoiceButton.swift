//
//  VoiceButton.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/26.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class VoiceButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "PlayingYUYIN3"), for: .normal)
        setTitleColor(rgb153, for: .normal)
        titleLabel?.font = font10
        titleLabel?.textAlignment = .right
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        LLog(frame)
        imageView?.frame = CGRect(x: 60, y: 11, width: 10, height: 14)
        titleLabel?.frame = CGRect(x: -72, y: 0, width: 40, height: 36)
    }
}
