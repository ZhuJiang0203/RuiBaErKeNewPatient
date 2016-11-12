//
//  RegisterViewController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/25.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

/**
 * 0：默认，啥也不是
 *
 * 1：手机号注册
 * 2：重置密码
 * 3：手机号绑定
 */


import UIKit

class RegisterViewController: BaseViewController {
    
    /**
     * 0：默认，啥也不是
     * 1：手机号注册
     * 2：重置密码
     * 3：手机号绑定
     */
    var type: Int = 0
    
    private var viewW: CGFloat = 0

    fileprivate var phoneField: UITextField?
    fileprivate var verificationCodeField: UITextField?
    fileprivate var passwordField: UITextField?
    fileprivate var okButton: UIButton?
    private var verification: UIButton?
    private var timer: Timer?
    private var time: Int = 60
    fileprivate var circleButton: UIButton?
    
    private var binDingView: BinDingView?
    private var customLoadTip: CustomLoadTip?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewW = kScreenWidth - 2*kMargin15
        
        view.backgroundColor = rgbColor(252, g: 244, b: 234)
        
        /// 请输入您的手机号
        setupPhoneField()
        
        /// 请输入验证码
        setupVerificationCodeField()

        /// 设置密码。。。
        setupPasswordField()
        
        /// 确定
        setupOkButton()
        
        /// true：手机号注册  false：重置密码
        if type == 1 {
            
            title = kPhoneNumberRegister
            /// 《睿宝隐私政策》
            setupRuiBaoYinSiYieXie()
        
        } else if type == 2 {
            
            title = kResetPassword

        } else if type == 3 {
            
            title = kPhoneNumberBinding

        } else if type == 4 {
            
        }
    }
    
    // MARK:- 请输入您的手机号
    private func setupPhoneField() {
        
        phoneField = UITextField(frame: CGRect(x: kMargin15, y: 95, width: viewW, height: kCellHeight))
        phoneField!.placeholder = kPleaseEnterCellPhoneNumber
        phoneField!.layer.cornerRadius = kRadius
        phoneField!.clipsToBounds = true
        phoneField!.layer.borderColor = rgbColor(208, g: 190, b: 185).cgColor
        phoneField!.layer.borderWidth = 0.5
        phoneField!.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin15, height: 0))
        phoneField!.leftViewMode = UITextFieldViewMode.always
        phoneField!.keyboardType = .numberPad
        phoneField!.clearButtonMode = .whileEditing
        phoneField!.textColor = rgb51
        phoneField!.font = font16
        phoneField!.delegate = self
        view.addSubview(phoneField!)
    }
    
    // MARK:- 请输入验证码
    private func setupVerificationCodeField() {
        verificationCodeField = UITextField(frame: CGRect(x: kMargin15, y: phoneField!.frame.maxY + kMargin15, width: viewW, height: kCellHeight))
        verificationCodeField!.placeholder = kPleaseEnterVerificationCode
        verificationCodeField!.layer.cornerRadius = kRadius
        verificationCodeField!.clipsToBounds = true
        verificationCodeField!.layer.borderColor = rgbColor(208, g: 190, b: 185).cgColor
        verificationCodeField!.layer.borderWidth = 0.5
        verificationCodeField!.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin15, height: 0))
        verificationCodeField!.leftViewMode = UITextFieldViewMode.always
        verificationCodeField!.rightView = setupVerificationCodeFieldRightView()
        verificationCodeField!.rightViewMode = UITextFieldViewMode.always
        verificationCodeField!.keyboardType = .numberPad
        verificationCodeField!.clearButtonMode = .whileEditing
        verificationCodeField!.textColor = rgb51
        verificationCodeField!.font = font16
        verificationCodeField!.delegate = self
        view.addSubview(verificationCodeField!)
    }
    
    private func setupVerificationCodeFieldRightView() -> UIView {
        
        let verificationW: CGFloat = 90
        let verificationX: CGFloat = viewW - verificationW
        verification = UIButton(frame: CGRect(x: verificationX, y: 0, width: verificationW, height: kCellHeight))
        verification!.setBackgroundImage(UIImage(named: "RegisterControllerVerSendCodeNormal"), for: .normal)
        verification!.setBackgroundImage(UIImage(named: "RegisterControllerVerSendCodeDisabled"), for: .disabled)
        verification!.setTitle(kVerify, for: .normal)
        verification!.setTitleColor(UIColor.white, for: .normal)
        verification!.titleLabel?.font = font16
        verification!.addTarget(self, action: #selector(RegisterViewController.sendVerificationCode), for: .touchUpInside)
        
        return verification!
    }
    
    // MARK:- 发送验证码
    @objc private func sendVerificationCode() {
        
        guard phoneField!.hasText else {
            CustomMBProgressHUD.showTipAndHideImmediately(kPleaseEnterMobilePhoneNumber, details: nil, view: view)
            return
        }
        
        /// verificationCodeField 成为第一响应者
        verificationCodeField!.becomeFirstResponder()
        
        /// 不可再点击
        verification!.isEnabled = false

        time -= 1
        verification!.setTitle("\(time)s", for: .normal)

        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(RegisterViewController.startCountDown), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .commonModes)
        }
    }
    
    /**
     * 开始倒计时
     */
    @objc private func startCountDown() {
        
        guard time > 0 else {
            return
        }
        
        time -= 1
        verification!.setTitle("\(time)s", for: .normal)
        
        if time <= 0 {
            /// 可点击
            verification!.isEnabled = true
            verification!.setTitle(kReSend, for: .normal)
            time = 60
            /// 停止倒计时
            endCountDown()
        }
    }
    
    /**
     * 停止倒计时
     */
    private func endCountDown() {
        timer?.invalidate()
        timer = nil
    }
 
    
    // MARK:- 设置密码。。。
    private func setupPasswordField() {
        passwordField = UITextField(frame: CGRect(x: kMargin15, y: verificationCodeField!.frame.maxY + kMargin15, width: viewW, height: kCellHeight))
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
        let rightViewX: CGFloat = viewW - rightViewW
        let rightViewY: CGFloat = (kCellHeight - rightViewH)/2
        let rightView = UIView(frame: CGRect(x: rightViewX, y: rightViewY, width: rightViewW, height: rightViewH))
        
        let customSwitch = CustomSwitch(frame: CGRect(x: 0, y: 0, width: rightViewW - kMargin, height: rightViewH))
        customSwitch.delegate = self
        rightView.addSubview(customSwitch)
        
        return rightView
    }
    
    // MARK:- 确定
    private func setupOkButton() {
        
        okButton = UIButton(frame: CGRect(x: kMargin15, y: passwordField!.frame.maxY + kMargin15, width: viewW, height: 44))
        okButton!.setBackgroundImage(UIImage.init(named: "SubmitButtonBackImageCornerRadius"), for: .normal)
        okButton!.setBackgroundImage(UIImage.init(named: "SubmitButtonBackImageCornerRadiusGray"), for: .disabled)
//        okButton!.isEnabled = false
        okButton!.setTitle(kEnsure, for: .normal)
        okButton!.setTitleColor(UIColor.white, for: .normal)
        okButton!.addTarget(self, action: #selector(RegisterViewController.okButtonClicked), for: .touchUpInside)
        view.addSubview(okButton!)
    }
    
    @objc private func okButtonClicked() {
        
//        guard phoneField!.hasText else {
//            CustomMBProgressHUD.showTipAndHideImmediately("请输入手机号", details: nil, view: view)
//            return
//        }
//        
//        guard verificationCodeField!.hasText else {
//            CustomMBProgressHUD.showTipAndHideImmediately("请输入验证码", details: nil, view: view)
//            return
//        }
//        
//        guard passwordField!.hasText else {
//            CustomMBProgressHUD.showTipAndHideImmediately(kPleaseEnterValidPassword, details: nil, view: view)
//            return
//        }
//        
//        guard circleButton!.isSelected == true else {
//            CustomMBProgressHUD.showTipAndHideImmediately("请阅读并同意", details: "《睿宝隐私政策》", view: view)
//            return
//        }
        
        
        if type == 1 { /// 手机号注册
            /********************* 如果是睿宝，则打开下面代码 *******************/
            defaults.setValue("1", forKey: kAppSkinNumberKey)
            
            // 测试
            defaults.setValue("1006", forKey: kOrganizationIDKey)
            defaults.setValue("1", forKey: kPracticeIDKey)
            defaults.setValue("1", forKey: kPatientIDKey)
            defaults.setValue("312312312", forKey: kPatientTockenKey)
            defaults.setValue("84", forKey: kPatientIconKey)
            defaults.setValue("睿宝医生", forKey: kPatientNameKey)
            defaults.setValue("RuiBaoDoctor", forKey: kPatientEnglishNameKey)
            defaults.setValue("好大夫", forKey: kPatientUserNameKey)
            
            
            // 添加 BinDingView 界面
            addBinDingView()
        } else if type == 2 { /// 重置密码
            
            _ = navigationController?.popToRootViewController(animated: true)
            
        } else if type == 3 { /// 手机号绑定
            
        }
        
    }
    
    /**
     * 添加 BinDingView 界面
     */
    fileprivate func addBinDingView() {
        
        // 退出键盘
        phoneField?.resignFirstResponder()
        verificationCodeField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        
        // 添加 BinDingView 界面
        binDingView = BinDingView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        binDingView!.delegate = self
        view.addSubview(binDingView!)
        
        // 执行自定义的动画
        binDingView!.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.25) {
            self.binDingView!.transform = CGAffineTransform.identity
        }
    }
    
    /**
     * 移除 BinDingView 界面
     */
    fileprivate func removeBinDingView(tag: Int) {
        
        // 执行自定义的动画
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            // 由于CGFloat是不准确的, 所以传入0.0之后没有动画效果
            self.binDingView!.transform = CGAffineTransform(scaleX: 1.0, y: 0.000001)
            }, completion: { (_) -> Void in
                
                self.binDingView?.removeFromSuperview()
                self.binDingView = nil
                
                if tag == 0 {
                    let vc = MedicalRecordBindingController()
                    vc.type = 1 // 绑定病历
                    self.navigationController?.pushViewController(vc, animated: true)
                } else if tag == 1 {
                    let vc = AddPatientInfoController()
                    self.navigationController?.pushViewController(vc, animated: true )
                } else {
                    
                    self.gotoRegisterOrLoginHuanXin()
                }
        })
    }
    
    private func gotoRegisterOrLoginHuanXin() {
        
        let isSuccess = LoginHuanXin.shareLoginHuanXin().setupRegisterHuanXin()
        if isSuccess == true {
            customLoadTip?.hideLoadTipWithSuccess()
        } else {
            customLoadTip?.hideLoadTipWithError()
        }
    }

    
    
    // MARK:- 《睿宝隐私政策》
    private func setupRuiBaoYinSiYieXie() {
    
        let circleButtonY: CGFloat = okButton!.frame.maxY + kMargin15
        let circleButtonWH: CGFloat = 20
        circleButton = UIButton(frame: CGRect(x: kMargin15, y: circleButtonY, width: circleButtonWH, height: circleButtonWH))
        circleButton!.setImage(UIImage.init(named: "CircleButtonGray2020"), for: .normal)
        circleButton!.setImage(UIImage.init(named: "CircleButtonPink2020"), for: .selected)
        circleButton!.isSelected = true
        circleButton!.addTarget(self, action: #selector(RegisterViewController.circleButtonClicked), for: .touchUpInside)
        view.addSubview(circleButton!)
        
        let xieYiLabelX: CGFloat = circleButton!.frame.maxX + 6
        let xieYiLabelW: CGFloat = kScreenWidth - kMargin15 - xieYiLabelX
        let xieYiLabel = UILabel(frame: CGRect(x: xieYiLabelX, y: circleButtonY, width: xieYiLabelW, height: circleButtonWH))
        let text1 = kReadAgree
        let text2 = kRuiBaoPrivacyAgreement
        let text3 = "\(text1)\(text2)"
        let mutableString = NSMutableAttributedString(string: text3)
        mutableString.addAttributes([NSForegroundColorAttributeName : rgb153], range: NSMakeRange(0, text1.characters.count))
        mutableString.addAttributes([NSForegroundColorAttributeName : appMainColor], range: NSMakeRange(text1.characters.count, text2.characters.count))
        xieYiLabel.attributedText = mutableString
        xieYiLabel.font = font14
        view.addSubview(xieYiLabel)

        xieYiLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.cheakRuiBaoYinSiZhengCe))
        xieYiLabel.addGestureRecognizer(tap)
    }
    
    @objc private func circleButtonClicked() {
        circleButton!.isSelected = !circleButton!.isSelected
    }
    
    @objc private func cheakRuiBaoYinSiZhengCe() {
    
        let vc = CusTomWebViewController()
        vc.urlString = "https://www.baidu.com"
        vc.isModal = true
        present(vc, animated: true, completion: nil)
    }

}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        /// 6 - 1 = 5
//        if phoneField!.hasText &&
//            verificationCodeField!.hasText &&
//            passwordField!.hasText &&
//            passwordField!.text!.characters.count >= 5 {
//            if circleButton != nil {
//                return circleButton!.isSelected
//            }
//            okButton!.isEnabled = true
//        } else {
//            okButton!.isEnabled = false
//        }
        
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = appMainColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = rgbColor(208, g: 190, b: 185).cgColor
    }
}

extension RegisterViewController: CustomSwitchDelegate {
    func buttonOfCustomSwitchClicked(btn: CustomSwitch) {
        passwordField!.isSecureTextEntry = btn.isSelected
    }
}

extension RegisterViewController: BinDingViewDelegate {
    func nextButtonClickedOfBinDingView(selectedBtn: BinDingButton, binDingView: BinDingView) {
        // 移除 BinDingView 界面
        removeBinDingView(tag: selectedBtn.tag)
    }
}
