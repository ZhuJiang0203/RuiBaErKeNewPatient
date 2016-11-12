//
//  ExpressMaskingView.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/30.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

@objc
protocol ExpressMaskingViewDelegate: NSObjectProtocol {
    @objc optional func toTellTheDelegaterToDoSomeThing()
}

enum ExpressMaskingViewPicture {
    case noData
    case reloadFail
}

class ExpressMaskingView: UIView {
    
    //    var state: MaskingViewPicture?
    //    var allHeight: CGFloat = 0
    weak var delegate: ExpressMaskingViewDelegate?
    
    class func setUpMaskingView(_ frame: CGRect, type: ExpressMaskingViewPicture) -> ExpressMaskingView! {
        return ExpressMaskingView(frame: frame, type: type)
    }
    
    init(frame: CGRect, type: ExpressMaskingViewPicture) {
        super.init(frame: frame)
        
        backgroundColor = rgb244
        
        
        addSubview(backView)
        backView.addSubview(icon)
        backView.addSubview(tip)
        backView.addSubview(btn)
        
        let backViewW: CGFloat = 101
        let backViewH: CGFloat = 191
        let backViewX = (kScreenWidth - backViewW)/2
        var backViewY = (kScreenHeight - backViewH)/2
        if frame.size.height > 100 {
            backViewY = (frame.size.height - backViewH)/2
        }
        backView.frame = CGRect(x: backViewX, y: backViewY, width: backViewW, height: backViewH)
        icon.frame = CGRect(x: 0, y: 0, width: 101, height: 101)
        tip.frame = CGRect(x: 0, y: 121, width: 101, height: 20)
        btn.frame = CGRect(x: 0.5, y: 161, width: 100, height: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var backView: UIView = {
        let backView = UIView()
        //        backView.backgroundColor = UIColor.clearColor()
        return backView
    }()
    
    
    fileprivate lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "LoadNodataOrFaile")
        return icon
    }()
    
    fileprivate lazy var tip: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbSameColor(170)
        lbl.font = font15
        lbl.text = "暂时为空喔"
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ReloadRestLoadNodataOrFaile"), for: .normal)
        btn.addTarget(self, action: #selector(ExpressMaskingView.btnClicked), for: .touchUpInside)
        return btn
    }()
    
    func btnClicked() {
        delegate?.toTellTheDelegaterToDoSomeThing!()
    }
}
