//
//  BinDingView.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

protocol BinDingViewDelegate: NSObjectProtocol {
    func nextButtonClickedOfBinDingView(selectedBtn: BinDingButton, binDingView: BinDingView)
}

class BinDingView: UIView {

    weak var delegate: BinDingViewDelegate?
    var selectedBtn: BinDingButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = rgbColor(252, g: 244, b: 234)
        UIApplication.shared.statusBarStyle = .default

        
        var topY: CGFloat = 73
        var centerY: CGFloat = 21
        var bottomY: CGFloat = 33
       
        var btnH: CGFloat = 120
        var iconWH: CGFloat = 70
        
        
        switch kScreenHeight {
        case 568: // 5
            topY = 103
            centerY = 21
            bottomY = 43
            btnH = 120
            iconWH = 70
        case 667: // 6
            topY = 121
            centerY = 29
            bottomY = 54
            btnH = 142
            iconWH = 80

        case 736: // 6p
            topY = 134
            centerY = 33
            bottomY = 61
            btnH = 155
            iconWH = 90
        default: // 4
            topY = 73
            centerY = 21
            bottomY = 33
            btnH = 120
            iconWH = 70
        }
        
        let btnW = kScreenWidth/2
        var btnX: CGFloat = 0
        var btnY: CGFloat = 0
        
        
        for i in 0..<3 {
            
            if i == 0  {
                btnX = kScreenWidth/4
                btnY = topY
            } else if i == 1 {
                btnX = 0
                btnY = topY + btnH + centerY
            } else if i == 2 {
                btnX = kScreenWidth/2
                btnY = topY + btnH + centerY
            }
            
            let btn = BinDingButton(frame: CGRect(x: btnX, y: btnY, width: btnW, height: btnH), iconWH: iconWH, iconImageNormal: "BinDingNormal\(i)", iconImageSelected: "BinDingSelected\(i)", text: kBindingMedicalRecords[i])
            btn.tag = i
            btn.addTarget(self, action: #selector(BinDingView.btnClicked(btn:)), for: .touchUpInside)
            addSubview(btn)
        }
        
        addSubview(nextButton)
        
        let nextButtonX: CGFloat = 60
        let nextButtonW: CGFloat = kScreenWidth - 2*nextButtonX
        let nextButtonY: CGFloat = topY + centerY + bottomY + btnH*2
        let nextButtonH: CGFloat = 50
        nextButton.frame = CGRect(x: nextButtonX, y: nextButtonY, width: nextButtonW, height: nextButtonH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    @objc private func btnClicked(btn: BinDingButton) {
        selectedBtn?.isSelected = false
        btn.isSelected = true
        selectedBtn = btn
        
        nextButton.isEnabled = true
    }
    
    private lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.isEnabled = false
        btn.setBackgroundImage(UIImage.init(named: "SubmitButtonBackImageCornerRadius"), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "SubmitButtonBackImageCornerRadiusGray"), for: .disabled)
        btn.setTitle(kNextStep, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(BinDingView.nextButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    @objc private func nextButtonClicked() {
        
        delegate?.nextButtonClickedOfBinDingView(selectedBtn: selectedBtn!, binDingView: self)
    }


}
