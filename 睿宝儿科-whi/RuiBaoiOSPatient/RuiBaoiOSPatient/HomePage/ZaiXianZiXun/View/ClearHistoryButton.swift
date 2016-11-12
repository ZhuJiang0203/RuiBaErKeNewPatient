//
//  ClearHistoryButton.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/13.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class ClearHistoryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle(kClearHistoryRecord, for: UIControlState.normal)
        setTitleColor(rgb50, for: UIControlState.normal)
        setTitleColor(rgb153, for: UIControlState.disabled)
        titleLabel?.font = font15

        setBackgroundImage(UIImage(named: "clearBtnNormol"), for: UIControlState.normal)
        setBackgroundImage(UIImage(named: "clearBtnSelected"), for: UIControlState.highlighted)
        setBackgroundImage(UIImage(named: "clearBtnDisabled"), for: UIControlState.disabled)
        setImage(UIImage(named: "clearBtnImg"), for: UIControlState.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        LLog(self.frame.size.width)
        
        let superW: CGFloat = self.frame.size.width //140
        let superH: CGFloat = 30
        let imgW: CGFloat = 15
        let imgH: CGFloat = 16
        let imgY = (superH - imgH)/2
        let lblW: CGFloat = superW - kMargin*3 - imgW //kClearHistoryRecord.calculateTheSizeOfTheString(font15, maxWidth: 100).width

        let imgX: CGFloat = kMargin //(superW - imgW - kMargin - lblW)/2
        let lblX: CGFloat = imgX + imgW + kMargin
        
        
        imageView?.frame = CGRect(x: imgX, y: imgY, width: imgW, height: imgH)
        titleLabel?.frame = CGRect(x: lblX, y: 0, width: lblW, height: superH)
    }
}
