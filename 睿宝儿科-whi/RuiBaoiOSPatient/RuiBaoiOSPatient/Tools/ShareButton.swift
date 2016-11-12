//
//  ShareButton.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/12.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class ShareButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.font = font13
        setTitleColor(rgb153, for: .normal)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: kMargin, y: 0, width: 50, height: 50)
        titleLabel?.frame = CGRect(x: 0, y: 50, width: 70, height: 35)
    }
}
