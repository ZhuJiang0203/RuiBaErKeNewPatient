//
//  ChangeDeleteButton.swift
//  querendingdan
//
//  Created by whj on 16/6/14.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class ChangeDeleteButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.font = font13
        setTitleColor(rgb153, for: .normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnW = kScreenWidth/2
        let btnH: CGFloat = 40
        let imgWH: CGFloat = 15
        let titleW: CGFloat = 26
        let titleH: CGFloat = 18
        let imgTitleMargin: CGFloat = 5
        
        let imgX = (btnW - imgWH - imgTitleMargin - titleW)/2
        let imgY = (btnH - imgWH)/2
        let titleX = imgX + imgWH + imgTitleMargin
        let titleY = (btnH - titleH)/2
        
        imageView?.frame = CGRect(x: imgX, y: imgY, width: imgWH, height: imgWH)
        titleLabel?.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
    }
}
