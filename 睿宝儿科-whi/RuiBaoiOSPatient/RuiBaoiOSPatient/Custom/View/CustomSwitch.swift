//
//  CustomSwitch.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/26.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

protocol CustomSwitchDelegate: NSObjectProtocol {
    func buttonOfCustomSwitchClicked(btn: CustomSwitch)
}

class CustomSwitch: UIButton {
    
    weak var delegate: CustomSwitchDelegate?
    var isCan = true

    override init(frame: CGRect) {
        super.init(frame: frame)

        
        let w: CGFloat = 40
        let h: CGFloat = 22
        

        layer.cornerRadius = h/2
        clipsToBounds = true
        isSelected = true
        backgroundColor = rgbColor(249, g: 117, b: 140)
        addTarget(self, action: #selector(CustomSwitch.customSwitchClicked), for: .touchUpInside)
        addTarget(self, action: #selector(CustomSwitch.customSwitchClicked), for: .touchDragInside)
        addTarget(self, action: #selector(CustomSwitch.customSwitchClicked), for: .touchDragOutside)
//        addTarget(self, action: #selector(CustomSwitch.customSwitchClicked), for: .touchDragEnter)
//        addTarget(self, action: #selector(CustomSwitch.customSwitchClicked), for: .touchDragExit)
        

        addSubview(circleView)
        addSubview(startView)
        
        let circleViewWH: CGFloat = 18
        circleView.frame.size = CGSize(width: circleViewWH, height: circleViewWH)
        circleView.center = CGPoint(x: h/2, y: h/2)
        circleView.layer.cornerRadius = circleViewWH/2
        circleView.clipsToBounds = true
        
        let startW: CGFloat = 9
        let startH: CGFloat = 8
        let startX: CGFloat = w - 5 - startW
        let startY: CGFloat = (h - startH)/2
        startView.frame = CGRect(x: startX, y: startY, width: startW, height: startH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var circleView: UIView = {
        let vw = UIView()
        vw.isUserInteractionEnabled = false
        vw.backgroundColor = UIColor.white
        return vw
    }()

    private lazy var startView: UIImageView = {
        let imgVw = UIImageView()
        imgVw.isUserInteractionEnabled = false
        imgVw.image = UIImage(named:"LoginStart")
        return imgVw
    }()

    
    @objc private func customSwitchClicked() {
        
        if isCan == false {
            return
        }
        
        isCan = false
        
        isSelected = !isSelected
        
        let circleViewCenterX: CGFloat = isSelected ? 11 : 29
        let backColor = isSelected ? rgbColor(249, g: 117, b: 140) : rgbColor(133, g: 125, b: 129)
        
        UIView.animate(withDuration: 0.25, animations: { 
            self.circleView.center.x = circleViewCenterX
            self.backgroundColor = backColor
            }) { (_) in
                self.isCan = true
        }
       
        delegate?.buttonOfCustomSwitchClicked(btn: self)
    }
}
