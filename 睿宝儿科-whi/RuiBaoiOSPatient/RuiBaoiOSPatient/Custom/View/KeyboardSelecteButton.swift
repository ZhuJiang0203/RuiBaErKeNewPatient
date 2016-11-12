//
//  KeyboardSelecteButton.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/8.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class KeyboardSelecteButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        layer.cornerRadius = 2.5
        clipsToBounds = true
        setTitleColor(rgb153, for: .normal)
        titleLabel?.font = font13
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 注意: 和OC不太一样的是Swift中可以直接修改一个对象的结构体的属性
        imageView?.center = CGPoint(x: frame.size.width/2, y: 27)
        titleLabel?.frame = CGRect(x: 0, y: 44, width: frame.size.width, height: 18)
    }
}
