//
//  ShopRecordButton.swift
//  querendingdan
//
//  Created by whj on 16/6/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class ShopRecordButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.font = font13
        setTitleColor(UIColor.white, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnW = kScreenWidth/2
        let btnH: CGFloat = 56
        let imgW: CGFloat = 14
        let imgH: CGFloat = 18
        let titleW: CGFloat = 70
        let titleH: CGFloat = 20
        let imgTitleMargin: CGFloat = 9
        
        let imgX = (btnW - imgW - imgTitleMargin - titleW)/2
        let imgY = (btnH - imgH)/2
        let titleX = imgX + imgW + imgTitleMargin
        let titleY = (btnH - titleH)/2
        
        imageView?.frame = CGRect(x: imgX, y: imgY, width: imgW, height: imgH)
        titleLabel?.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
    }
}
