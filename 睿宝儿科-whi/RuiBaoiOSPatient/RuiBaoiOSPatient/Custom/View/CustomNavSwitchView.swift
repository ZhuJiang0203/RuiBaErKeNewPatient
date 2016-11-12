//
//  CustomNavSwitchView.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/5.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

@objc
protocol CustomNavSwitchViewDelegate: NSObjectProtocol {
    @objc optional func oneButtonClickedOfCustomNavSwitchView(_ navSwitch: CustomNavSwitchView, btn: UIButton)
}

class CustomNavSwitchView: UIView {
    
    // 上一个按钮
    var previousBtn: UIButton?
    // 被选中的按钮
    var disabledBtn: UIButton?
    // 所有按钮
    var btns: [AnyObject] = Array()
    // 代理
    weak var delegate: CustomNavSwitchViewDelegate?
    // 2.再设置 nameArr
    var nameArr: [String]? {
        didSet {
            // 默认frame
            if frame.height == 0 {
                frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
            }
            
            /// 创建并设置按钮
            for i in 0..<nameArr!.count {
                setupButtonWithTag(i)
            }
        }
    }
    
    // MARK: - 创建并设置子按钮
    fileprivate func setupButtonWithTag(_ tagNumber: Int) {
        let btnMarginX: CGFloat = 7
        let text = nameArr![tagNumber]
        let btnW: CGFloat = CGFloat(text.characters.count)*12 + btnMarginX*2
        let btnH: CGFloat = 20
        let margin: CGFloat = 15
        var btnX: CGFloat = margin
        if previousBtn != nil {
            btnX = (previousBtn?.frame)!.maxX + kMargin
        }
        let btn = UIButton(frame: CGRect(x: btnX, y: kMargin, width: btnW, height: btnH))
        btn.tag = tagNumber // 绑定tag
        btn.setTitle(text, for: .normal)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 12)
        btn.contentMode = UIViewContentMode.center;
        btn.setTitleColor(rgb50, for: .normal)
        btn.setTitleColor(UIColor.white, for: .disabled)
        btn.setBackgroundImage(UIImage(named: "RectangleGray"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "RectangleGreen"), for: .disabled)
        btn.addTarget(self, action: #selector(CustomNavSwitchView.btnDidClick(_:)), for: .touchUpInside)
        scrollView.addSubview(btn)
        btns.append(btn)
        previousBtn = btn
        
        if tagNumber == (nameArr?.count)! - 1 {
            scrollView.contentSize = CGSize(width: btn.frame.maxX + margin, height: 0)
        }
        
        // 默认情况下，选中的是defaultBtn
        if (tagNumber == 0) {
            btn.isEnabled = false
            disabledBtn = btn;
        }
    }
    
    // MARK: - 监听按钮点击（当按钮被点击时，通知代理去做一些操作）
    func btnDidClick(_ btn: UIButton) {
        disabledBtn?.isEnabled = true
        btn.isEnabled = false
        disabledBtn = btn
        
        delegate?.oneButtonClickedOfCustomNavSwitchView!(self, btn: btn)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        // 添加子控件
        addSubview(scrollView)
        addSubview(line)
        scrollView.frame = frame
        line.frame = CGRect(x: 0, y: frame.height - 0.5, width: kScreenWidth, height: 0.5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
}


