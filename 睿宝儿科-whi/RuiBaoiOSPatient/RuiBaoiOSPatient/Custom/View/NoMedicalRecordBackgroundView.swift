//
//  NoMedicalRecordBackgroundView.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/11/2.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

@objc
protocol NoMedicalRecordBackgroundViewDelegate: NSObjectProtocol {
    @objc optional func buttonOfNoMedicalRecordBackgroundViewClicked()
}

class NoMedicalRecordBackgroundView: UIView {
    
    weak var delegate: NoMedicalRecordBackgroundViewDelegate?

    class func setUpNoMedicalRecordBackgroundView(_ superFrame: CGRect, iconString: String = "NoMedicalRecordBackImageIcon", tipTxt: String = kCreateMedicalRecordsTip, tipFont: UIFont = font15, tipColor: UIColor = rgbColor(79, g: 9, b: 2), buttonBackImage: String = "NoMedicalRecordBackImageButton", buttonText: String = kBindMedicalRecord, btnFont: UIFont = font20, btnColor: UIColor = appMainColor) -> NoMedicalRecordBackgroundView! {
        return NoMedicalRecordBackgroundView(superFrame: superFrame, iconString: iconString, tipTxt: tipTxt, tipFont: tipFont, tipColor: tipColor, buttonBackImage: buttonBackImage, buttonText: buttonText, btnFont: btnFont, btnColor: btnColor)
    }
    
    init(superFrame: CGRect, iconString: String, tipTxt: String, tipFont: UIFont, tipColor: UIColor, buttonBackImage: String, buttonText: String, btnFont: UIFont, btnColor: UIColor) {
        
        super.init(frame: superFrame)
        
        addSubview(icon)
        addSubview(tip)
        addSubview(button)
        
        let imageTipMargin: CGFloat = 6.5
        let tipButtonMargin: CGFloat = 8.5
        let tipButtonW: CGFloat = 215
        let tipButtonX: CGFloat = (kScreenWidth - tipButtonW)/2
        let tipH: CGFloat = tipTxt.calculateTheSizeOfTheString(tipFont, maxWidth: tipButtonW).height
        let buttonH: CGFloat = 60

        
        icon.image = UIImage(named: iconString)
        icon.sizeToFit()
        icon.center = CGPoint(x: frame.width/2, y: frame.height/2 - (imageTipMargin + tipH + tipButtonMargin + buttonH + 64 + 49)/2)
        
        tip.frame = CGRect(x: tipButtonX, y: icon.frame.maxY + imageTipMargin, width: tipButtonW, height: tipH)
        tip.text = tipTxt
        tip.font = tipFont
        tip.textColor = tipColor
        
        button.frame = CGRect(x: tipButtonX, y: tip.frame.maxY + tipButtonMargin, width: tipButtonW, height: buttonH)
        button.setBackgroundImage(UIImage.init(named: buttonBackImage), for: .normal)
        button.setTitle(buttonText, for: .normal)
        button.titleLabel?.font = btnFont
        button.setTitleColor(btnColor, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -7, right: 0)
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
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(NoMedicalRecordBackgroundView.buttonClicked), for: .touchUpInside)
        return btn
    }()

    @objc private func buttonClicked() {
        delegate?.buttonOfNoMedicalRecordBackgroundViewClicked?()
    }
}
