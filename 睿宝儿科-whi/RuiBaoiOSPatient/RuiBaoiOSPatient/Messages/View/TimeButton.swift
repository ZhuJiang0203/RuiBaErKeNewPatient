//
//  TimeButton.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/17.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class TimeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "iconfont-shijian"), for: .normal)
        setTitleColor(rgb153, for: .normal)
        titleLabel?.font = font8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        
        LLog(frame)
        imageView?.frame = CGRect(x: 0, y: 1.5, width: 8, height: 8)
        titleLabel?.frame = CGRect(x: 13, y: 0, width: frame.size.width - 13, height: 11)
    }
}
