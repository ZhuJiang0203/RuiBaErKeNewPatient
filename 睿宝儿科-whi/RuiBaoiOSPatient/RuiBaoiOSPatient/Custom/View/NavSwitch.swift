//
//  NavSwitch.swift
//  XLWBSwift20160314
//
//  Created by whj on 16/4/7.
//  Copyright © 2016年 mifengyiliao. All rights reserved.
//
// 
//  一个控制器上加N个子控制器，且可左右滚动

import UIKit

@objc
protocol NavSwitchDelegate: NSObjectProtocol {
    @objc optional func oneButtonClickedOfNavSwitch(_ navSwitch: NavSwitch, btn: UIButton)
}

private var NavSwitchH: CGFloat = 40

class NavSwitch: UIView {
    
    /***************** 有默认值，可以重写的属性 *****************/

    // 被选中的按钮
    var disabledBtn: UIButton?
    // 所有按钮
    var btns: [AnyObject] = Array()
    // 代理
    weak var delegate: NavSwitchDelegate?
    // 1.先设置 notifiPrefix
    var notifiPrefix: NSString!
    // 2.再设置 nameArr
    var nameArr: [String]? {
        didSet {
            // 默认frame
            if frame.height == 0 {
                frame = CGRect(x: 0, y: 64, width: kScreenWidth, height: NavSwitchH)
            }
            /// 监听控制器中主scrollView滚动结束的通知
            addNewNotification()
            
            /// 创建并设置按钮
            for i in 0..<nameArr!.count {
                setupButtonWithTag(i)
            }
            
            // 确定滑块的初始位置
            let content = nameArr?.first
            let sliderW: CGFloat = CGFloat((content?.characters.count)!)*14
            let sliderX: CGFloat = (kScreenWidth/CGFloat(nameArr!.count) - sliderW)/2
            let sliderH: CGFloat = 1
            let sliderY: CGFloat = frame.height - sliderH
            slider.frame.size.width = sliderW
            slider.frame = CGRect(x: sliderX, y: sliderY, width: sliderW, height: sliderH)
        }
    }
    
    // MARK: - 监听控制器中主scrollView滚动结束的通知
    func addNewNotification() {
        let notifyName = "\(notifiPrefix)ScrollViewDidEndDraggingNotification"
        LLog(notifyName)
        NotificationCenter.default.addObserver(self, selector: #selector(NavSwitch.changeBtnState(_:)), name: NSNotification.Name(rawValue: notifyName), object: nil)
    }
    
    // MARK: - 接收到通知后，改变按钮的状态
    func changeBtnState(_ notify: Notification) {
        LLog((notify as NSNotification).userInfo)
        let nofiPrefix = (notify as NSNotification).userInfo!["notificationPrefix"]
        let notificationName = "\(nofiPrefix!)ScrollVwContextOffsetX"
        LLog(notificationName)
        let offsetXString =  (notify as NSNotification).userInfo![notificationName]
        LLog(offsetXString)
        let offsetX = (offsetXString! as! NSString).floatValue
        let offset: Int = Int((CGFloat(offsetX) + kScreenWidth/2)/kScreenWidth)
        for i in 0..<btns.count {
            let btn = btns[i] as! UIButton
            if i == offset {
                if btn.isEnabled {
                    btn.isEnabled = false
                    changeButtonLineState(btn)
                    disabledBtn = btn
                }
            } else if !btn.isEnabled {
                btn.isEnabled = true
            }
        }
    }
    
    // MARK: - 改变滑动的位置
    func changeButtonLineState(_ btn: UIButton) {
        let subViewWidth: CGFloat = (btn.titleLabel?.frame.width)!
        let margin: CGFloat = (btn.frame.width - subViewWidth)/2
        let locationX: CGFloat = btn.frame.width*CGFloat(btn.tag) + margin
        LLog(locationX)
        if slider.frame.origin.x != locationX {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.slider.frame.size.width = subViewWidth
                self.slider.frame.origin.x = locationX
            })
        }
    }
    
    // MARK: - 创建并设置子按钮
    fileprivate func setupButtonWithTag(_ tagNumber: Int) {
        let btnW = kScreenWidth/CGFloat(nameArr!.count)
        let btnX: CGFloat = btnW*CGFloat(tagNumber)
        let btn = UIButton(frame: CGRect(x: btnX, y: 0, width: btnW, height: frame.height))
        btn.tag = tagNumber // 绑定tag
        btn.setTitle(nameArr![tagNumber], for: .normal)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        btn.contentMode = UIViewContentMode.center;
        btn.setTitleColor(rgbSameColor(51.0), for: .normal)
        btn.setTitleColor(rgbColor(249, g: 117, b: 140), for: .disabled)
        btn.addTarget(self, action: #selector(NavSwitch.btnDidClick(_:)), for: .touchUpInside)
        addSubview(btn)
        btns.append(btn)

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
    
        delegate?.oneButtonClickedOfNavSwitch!(self, btn: btn)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        // 添加子控件
        addSubview(line)
        addSubview(slider)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate lazy var line: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: NavSwitchH - 0.5, width: kScreenWidth, height: 0.5))
        line.backgroundColor = rgbSameColor(234)
        return line
    }()

    fileprivate lazy var slider: UIView = {
        let slider = UIView()
        slider.backgroundColor = rgbColor(249, g: 117, b: 140)
        return slider
    }()
}
