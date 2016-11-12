//
//  UnbundlingController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  手机号解绑

import UIKit

class UnbundlingController: BaseViewController {
    
    /**
     * 0：默认，啥都不是
     * 1：手机解绑
     * 2：病历解绑
     */
    var type: Int = 0
    /// 手机号 或 病历号
    var number = ""

    fileprivate var passwordField: UITextField?
    fileprivate var okButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = rgbColor(252, g: 244, b: 234)
        
        /// 当前绑定手机号
        setupNowUnbundlingPhoneLabel()

        /// 请输入密码
        setupPasswordField()
        
        /// 确定
        setupOkButton()
        
    }
    
    // MARK:- 当前绑定手机号
    private func setupNowUnbundlingPhoneLabel() {
        
        let tipLabel = UILabel(frame: CGRect(x: kMargin15, y: 95, width: kScreenWidth - 2*kMargin15, height: 25))
        var tip = kCurrentBindingPhoneNumber
        if type == 2 {
            tip = kCurrentBindMedicalRecordNumber
        }
        let mutableString = NSMutableAttributedString(string: "\(tip)\(number)")
        mutableString.addAttributes([NSFontAttributeName : font13], range: NSMakeRange(0, tip.characters.count))
        mutableString.addAttributes([NSFontAttributeName : font18], range: NSMakeRange(tip.characters.count, number.characters.count))
        tipLabel.attributedText = mutableString
        tipLabel.textColor = rgb102
        view.addSubview(tipLabel)
    }
    
    // MARK:- 请输入密码
    private func setupPasswordField() {
        passwordField = UITextField(frame: CGRect(x: kMargin15, y: 132, width: kScreenWidth - kMargin15*2, height: kCellHeight))
        passwordField!.placeholder = kSetPasswordDigitLetter
        passwordField!.layer.cornerRadius = kRadius
        passwordField!.clipsToBounds = true
        passwordField!.layer.borderColor = rgbColor(208, g: 190, b: 185).cgColor
        passwordField!.layer.borderWidth = 0.5
        passwordField!.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin15, height: 0))
        passwordField!.leftViewMode = UITextFieldViewMode.always
        passwordField!.rightView = setupPasswordFieldRightView()
        passwordField!.rightViewMode = UITextFieldViewMode.always
        passwordField!.clearButtonMode = .whileEditing
        passwordField!.textColor = rgb51
        passwordField!.font = font16
        passwordField!.delegate = self
        passwordField!.isSecureTextEntry = true
        view.addSubview(passwordField!)
    }
    
    private func setupPasswordFieldRightView() -> UIView {
        let rightViewW: CGFloat = 50
        let rightViewH: CGFloat = 22
        let rightViewX: CGFloat = passwordField!.frame.width - rightViewW
        let rightViewY: CGFloat = (kCellHeight - rightViewH)/2
        let rightView = UIView(frame: CGRect(x: rightViewX, y: rightViewY, width: rightViewW, height: rightViewH))
        
        let customSwitch = CustomSwitch(frame: CGRect(x: 0, y: 0, width: rightViewW - kMargin, height: rightViewH))
        customSwitch.delegate = self
        rightView.addSubview(customSwitch)
        
        return rightView
    }
    
    // MARK:- 确定
    private func setupOkButton() {
        
        okButton = UIButton(frame: CGRect(x: kMargin15, y: passwordField!.frame.maxY + kMargin15, width: kScreenWidth - 2*kMargin15, height: 44))
        okButton!.setBackgroundImage(UIImage.init(named: "SubmitButtonBackImageCornerRadius"), for: .normal)
        okButton!.setBackgroundImage(UIImage.init(named: "SubmitButtonBackImageCornerRadiusGray"), for: .disabled)
        okButton!.isEnabled = false
        okButton!.setTitle(kEnsure, for: .normal)
        okButton!.setTitleColor(UIColor.white, for: .normal)
        okButton!.addTarget(self, action: #selector(UnbundlingController.okButtonClicked), for: .touchUpInside)
        view.addSubview(okButton!)
    }
    
    @objc private func okButtonClicked() {
        
        guard passwordField!.hasText else {
            CustomMBProgressHUD.showTipAndHideImmediately(kPleaseEnterValidPassword, details: nil, view: view)
            return
        }
    }
}

extension UnbundlingController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /// 6 - 1 = 5
        if passwordField!.hasText && passwordField!.text!.characters.count >= 5 {
            okButton!.isEnabled = true
        } else {
            okButton!.isEnabled = false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = appMainColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = rgbColor(208, g: 190, b: 185).cgColor
    }
}

extension UnbundlingController: CustomSwitchDelegate {
    func buttonOfCustomSwitchClicked(btn: CustomSwitch) {
        passwordField!.isSecureTextEntry = btn.isSelected
    }
}
