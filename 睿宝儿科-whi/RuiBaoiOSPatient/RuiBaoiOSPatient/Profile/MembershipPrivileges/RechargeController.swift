//
//  RechargeController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/21.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  充值

import UIKit

class RechargeController: BaseViewController {

    var scrollView: UIScrollView!
    var selectedBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = kRecharge
        
        // 创建scrollView
        setupScrollView()
    }
    
    // MARK:- 创建scrollView
    fileprivate func setupScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = rgb244
        view.addSubview(scrollView)
        
        // 金额模块
        setupAmountOfMoneyView()
        
        // 支付方式模块
        setupPaymentMethodView()
        
        // 确认充值
        setupConfirmToRechargeView()
    }
    
    /**
     金额模块
     */
    fileprivate func setupAmountOfMoneyView() {
    
        let moneyViewH: CGFloat = 44
        let moneyView = UIView(frame: CGRect(x: 0, y: 10, width: kScreenWidth, height: moneyViewH))
        moneyView.backgroundColor = UIColor.white
        scrollView.addSubview(moneyView)
        
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5))
        topLine.backgroundColor = rgbSameColor(237)
        moneyView.addSubview(topLine)
        
        let moneyH: CGFloat = 22
        let moneyY: CGFloat = (moneyViewH - moneyH)/2
        let moneyKey = UILabel(frame: CGRect(x: 15, y: moneyY, width: 200, height: moneyH))
        moneyKey.text = kAmountOfMoney
        moneyKey.textColor = rgb102
        moneyKey.font = font16
        moneyView.addSubview(moneyKey)
        
        let moneyValueW: CGFloat = 200
        let moneyValueX: CGFloat = kScreenWidth - 15 - moneyValueW
        let moneyValue = UITextField(frame: CGRect(x: moneyValueX, y: moneyY, width: moneyValueW, height: moneyH))
        moneyValue.textColor = rgb51
        moneyValue.font = font16
        moneyValue.textAlignment = .right
     
        // 光标颜色
        moneyValue.tintColor = rgbColor(249, g: 117, b: 140)
        
        // 占位文字，自定义占位文字颜色（方法一：创建一个富文本对象）
//        moneyValue.attributedPlaceholder = NSAttributedString(string: "请输入充值金额", attributes: [NSForegroundColorAttributeName : rgbSameColor(188)])
        // 占位文字，自定义占位文字颜色（方法二：利用Runtime获取私有的属性名称，利用KVC设置属性）
//        moneyValue.placeholder = "请输入充值金额"
//        moneyValue.setValue(UIColor.blueColor(), forKeyPath: "_placeholderLabel.textColor")
        
        moneyValue.placeholder = kEnterAmountRecharge

        // 键盘类型（只有整数）
        moneyValue.keyboardType = .numberPad
        // 键盘类型（带小数点）
        moneyValue.keyboardType = .decimalPad
        
        moneyView.addSubview(moneyValue)

        let bottomLine = UIView(frame: CGRect(x: 0, y: moneyViewH - 0.5, width: kScreenWidth, height: 0.5))
        bottomLine.backgroundColor = rgbSameColor(237)
        moneyView.addSubview(bottomLine)
    }
    
    /**
     支付方式模块
     */
    fileprivate func setupPaymentMethodView() {
        
        let payStyleH: CGFloat = 140
        let payStyle = UIView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: payStyleH))
        payStyle.backgroundColor = UIColor.white
        scrollView.addSubview(payStyle)
        
        let tip = UILabel(frame: CGRect(x: 15, y: 12, width: 200, height: 22))
        tip.text = kPaymentMethod
        tip.textColor = rgb102
        tip.font = font16
        payStyle.addSubview(tip)
        
        // 微信模块
        let wxViewH: CGFloat = 22
        let wxView = UIView(frame: CGRect(x: 0, y: tip.frame.maxY + 20, width: kScreenWidth, height: wxViewH))
        payStyle.addSubview(wxView)

        let wxIconView = UIImageView(frame: CGRect(x: 15, y: 0, width: 22, height: wxViewH))
        wxIconView.image = UIImage(named: "WeixXinPayIcon")
        wxView.addSubview(wxIconView)
        
        let wxTitle = UILabel(frame: CGRect(x: wxIconView.frame.maxX + 8, y: 0, width: 200, height: wxViewH))
        wxTitle.text = kWeChatPayment
        wxTitle.textColor = rgb50
        wxTitle.font = font16
        wxView.addSubview(wxTitle)

        let wxBtnW: CGFloat = 40
        let wxBtnX: CGFloat = kScreenWidth - wxBtnW
        let wxBtn = UIButton(frame: CGRect(x: wxBtnX, y: 0, width: wxBtnW, height: wxViewH))
        wxBtn.setImage(UIImage(named: "ExpressCellIcon"), for: .normal)
        wxBtn.setImage(UIImage(named: "ExpressCellIconSelected"), for: .selected)
        wxBtn.tag = 0
        wxBtn.addTarget(self, action: #selector(RechargeController.wxOrAlipayBtnClicked(_:)), for: .touchUpInside)
        wxView.addSubview(wxBtn)
        
        
        // 支付宝模块
        let alipayView = UIView(frame: CGRect(x: 0, y: wxView.frame.maxY + 17, width: kScreenWidth, height: wxViewH))
        payStyle.addSubview(alipayView)
        
        let alipayIconView = UIImageView(frame: CGRect(x: 15, y: 0, width: 22, height: wxViewH))
        alipayIconView.image = UIImage(named: "AlipayPayIcon")
        alipayView.addSubview(alipayIconView)
        
        let alipayTitle = UILabel(frame: CGRect(x: wxIconView.frame.maxX + 8, y: 0, width: 200, height: wxViewH))
        alipayTitle.text = kAlipayToPay
        alipayTitle.textColor = rgb50
        alipayTitle.font = font16
        alipayView.addSubview(alipayTitle)
        
        let alipayBtn = UIButton(frame: CGRect(x: wxBtnX, y: 0, width: wxBtnW, height: wxViewH))
        alipayBtn.setImage(UIImage(named: "ExpressCellIcon"), for: .normal)
        alipayBtn.setImage(UIImage(named: "ExpressCellIconSelected"), for: .selected)
        alipayBtn.tag = 1
        alipayBtn.addTarget(self, action: #selector(RechargeController.wxOrAlipayBtnClicked(_:)), for: .touchUpInside)
        alipayView.addSubview(alipayBtn)
        
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5))
        topLine.backgroundColor = rgbSameColor(237)
        payStyle.addSubview(topLine)
        
        let bottomLine = UIView(frame: CGRect(x: 0, y: payStyleH - 0.5, width: kScreenWidth, height: 0.5))
        bottomLine.backgroundColor = rgbSameColor(237)
        payStyle.addSubview(bottomLine)
    }
    
    @objc fileprivate func wxOrAlipayBtnClicked(_ btn: UIButton) {
        selectedBtn?.isSelected = false
        btn.isSelected = true
        selectedBtn = btn
    }

    /**
     *  确认充值
     */
    fileprivate func setupConfirmToRechargeView() {
        let confirmH: CGFloat = 48
        let confirmY: CGFloat = kScreenHeight - confirmH
        let confirm = UIButton(frame: CGRect(x: 0, y: confirmY, width: kScreenWidth, height: confirmH))
        confirm.setBackgroundImage(UIImage(named: "ToEvaluateControllerSubmitBackImage"), for: .normal)
        confirm.setTitle(kRechargeConfirmation, for: .normal)
        confirm.setTitleColor(UIColor.white, for: .normal)
        confirm.titleLabel?.font = font16
        confirm.addTarget(self, action: #selector(RechargeController.confirmClicked), for: .touchUpInside)
        view.addSubview(confirm)
    }
    
    @objc fileprivate func confirmClicked() {
    
    }
}
