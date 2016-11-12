//
//  MaskingView.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/9.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit


class MaskingView: UIView {

    class func setUpMaskingView(_ superFrame: CGRect, iconString: String, tipTxt: String, txtColor: UIColor = rgbColor(193, g: 196, b: 205)) -> MaskingView! {
        return MaskingView(superFrame: superFrame, iconString: iconString, tipTxt: tipTxt, txtColor: txtColor)
    }
    
    init(superFrame: CGRect, iconString: String, tipTxt: String, txtColor: UIColor) {
        super.init(frame: superFrame)
                
        addSubview(icon)
        addSubview(tip)
        
        icon.image = UIImage(named: iconString)
        icon.sizeToFit()
        let tipH: CGFloat = 40
        icon.center = CGPoint(x: frame.width/2, y: frame.height/2 - tipH/2)

        tip.frame = CGRect(x: 0, y: icon.frame.maxY, width: kScreenWidth, height: tipH)
        tip.text = tipTxt
        tip.textColor = txtColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.sizeToFit()
        return icon
    }()

    fileprivate lazy var tip: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbColor(193, g: 196, b: 205)
        lbl.textAlignment = .center
        lbl.font = font13
        return lbl
    }()
}
