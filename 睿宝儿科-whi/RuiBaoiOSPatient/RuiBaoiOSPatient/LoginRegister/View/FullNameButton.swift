//
//  FullNameButton.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class FullNameButton: UIButton {

    init(frame: CGRect, text: String) {
        super.init(frame: frame)
        
        setImage(UIImage.init(named: "FullNameNormal"), for: .normal)
        setImage(UIImage.init(named: "FullNameSelected"), for: .selected)
        setTitle(text, for: .normal)
        setTitleColor(rgb51, for: .normal)
        titleLabel?.text = text
        titleLabel?.font = font16
        titleLabel?.textAlignment = .center
        imageView?.sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageWH: CGFloat = 16
        
        imageView?.center = CGPoint(x: imageWH/2, y: frame.height/2)
        titleLabel?.frame = CGRect(x: imageWH, y: 0, width: frame.width - imageWH, height: frame.height)
    }
}
