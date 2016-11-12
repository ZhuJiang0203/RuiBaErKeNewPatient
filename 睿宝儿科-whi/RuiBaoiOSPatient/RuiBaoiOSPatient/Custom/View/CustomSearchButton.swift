//
//  CustomSearchButton.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/5.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class CustomSearchButton: UIButton {
    
    class func setupCustomSearchButton(_ frame: CGRect) -> CustomSearchButton {
        return CustomSearchButton(frame: frame)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = rgbSameColor(244)
        layer.cornerRadius = 2.5
        clipsToBounds = true
        
        titleLabel?.backgroundColor = UIColor.red
        imageView?.image = UIImage(named: "iconfont-sousuokuangsousuo")
        titleLabel?.text = kPleaseInputKeyWord
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnH: CGFloat = 30
        let imgX: CGFloat = 8
        let imgWH: CGFloat = 12
        let imgY = (btnH - imgWH)/2
        imageView?.frame = CGRect(x: imgX, y: imgY, width: imgWH, height: imgWH)
        titleLabel?.frame = CGRect(x: (imageView?.frame)!.maxX + 8, y: 0, width: 100, height: 30)
    }
}
