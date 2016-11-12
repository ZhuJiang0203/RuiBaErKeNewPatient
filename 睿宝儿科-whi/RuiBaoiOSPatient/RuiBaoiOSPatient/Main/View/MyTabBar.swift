//
//  MyTabBar.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

@objc
protocol MyTabBarDelegate: NSObjectProtocol {
    @objc optional func didSelectedOneButtonOfTabBar(_ tabBar: MyTabBar, btn: MJTabBarButton)
}

class MyTabBar: UIView {
    
    weak var delegate: MyTabBarDelegate?
    /**
     *  记录当前选中的按钮
     */
    fileprivate var selectedButton: MJTabBarButton?
    
    var buttons = [MJTabBarButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let line = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5))
//        line.backgroundColor = rgbSameColor(237)
//        addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addTabBarButtonWithTitleAndIconString(_ title: String = "", iconString: String = "") {
        let btn = MJTabBarButton(type: .custom)
        btn.setTitle(title, for: UIControlState())
        btn.setTitleColor(rgbSameColor(174), for: .normal)
        btn.setTitleColor(appMainColor, for: .selected)
        btn.setImage(UIImage(named: iconString), for: UIControlState())
        btn.setImage(UIImage(named: "\(iconString)_selected"), for: .selected)
        btn.tag = subviews.count
        // UIControlEventTouchDown : 手指一按下去就会触发这个事件
        btn.addTarget(self, action: #selector(MyTabBar.buttonClick(_:)), for: .touchUpInside)
        addSubview(btn)
        buttons.append(btn)
        
        // 默认选中第0个按钮
        if subviews.count == 1 {
            buttonClick(btn)
        }
    }
    
    /**
     *  监听按钮点击
     */
    func buttonClick(_ button: MJTabBarButton) {
        
        if button == selectedButton {
            return
        }
        
    
        // 1.让当前选中的按钮取消选中
        selectedButton?.isSelected = false
        
        // 2.让新点击的按钮选中
        button.isSelected = true
        
        // 3.新点击的按钮就成为了"当前选中的按钮"
        selectedButton = button
        
        // 4. 来个 动画
        let duration: TimeInterval = 0.1
        UIView.animate(withDuration: duration, animations: {
            button.imageView!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { (_) in
                UIView.animate(withDuration: duration, animations: {
                    button.imageView!.transform = CGAffineTransform.identity
                })
        })
        
        // 0. 通知代理
        delegate?.didSelectedOneButtonOfTabBar?(self, btn: button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonW: CGFloat = frame.width/CGFloat(buttons.count)
        let buttonH: CGFloat = frame.height
        for i in 0..<buttons.count {
            let button = buttons[i]
//            button.tag = i
            let centerX: CGFloat = (CGFloat(i) + 0.5)*buttonW
            let centerY: CGFloat = buttonH/2
            button.frame.size = CGSize(width: buttonW, height: buttonH)
            button.center = CGPoint(x: centerX, y: centerY)
        }
    }
}
