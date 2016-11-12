//
//  MedicalRecordBindingController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

/**
 * 0：默认，啥也不是
 *
 * 1：病历绑定
 * 2：新增就诊人（添加复诊患者）
 * 3：关联家庭成员病历
 */

import UIKit

class MedicalRecordBindingController: BaseViewController {

    /**
     * 0：默认，啥也不是
     *
     * 1：病历绑定
     * 2：新增就诊人（添加复诊患者）
     * 3：关联家庭成员病历
     */
    var type: Int = 0

    private var viewW: CGFloat = 0
    
    fileprivate var accountField: UITextField?
    fileprivate var passwordField: UITextField?
    fileprivate var okButton: UIButton?
    private var customLoadTip: CustomLoadTip?


    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewW = kScreenWidth - 2*kMargin15

        
        switch type {
        case 1:
            title = kMedicalRecordBinding
        case 2:
            title = kNewPatient
        case 3:
            title = kRelatedFamilyMembers
        default:
            title = ""
        }
        view.backgroundColor = rgbColor(252, g: 244, b: 234)

        
        /// 账号
        setupAccountField()

        /// 密码
        setupPasswordField()
        
        /// 确定
        setupOkButton()
        
        /// 提示
        setupRuiBaoYinSiYieXie()
    }
    
    // MARK:- 账号
    private func setupAccountField() {
        accountField = UITextField(frame: CGRect(x: kMargin15, y: 95, width: viewW, height: kCellHeight))
        accountField!.placeholder = kAccountNumber
        accountField!.layer.cornerRadius = kRadius
        accountField!.clipsToBounds = true
        accountField!.layer.borderColor = rgbColor(208, g: 190, b: 185).cgColor
        accountField!.layer.borderWidth = 0.5
        accountField!.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin15, height: 0))
        accountField!.leftViewMode = .always
        accountField!.clearButtonMode = .whileEditing
        accountField!.textColor = rgb51
        accountField!.font = font16
        accountField!.delegate = self
        view.addSubview(accountField!)
    }
    
    // MARK:- 密码
    private func setupPasswordField() {
        passwordField = UITextField(frame: CGRect(x: kMargin15, y: accountField!.frame.maxY + kMargin15, width: viewW, height: kCellHeight))
        passwordField!.placeholder = kLoginPasswordPlacehoder
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
        okButton!.isEnabled = false
        okButton!.setTitle(kEnsure, for: .normal)
        okButton!.setTitleColor(UIColor.white, for: .normal)
        okButton!.addTarget(self, action: #selector(MedicalRecordBindingController.okButtonClicked), for: .touchUpInside)
        view.addSubview(okButton!)
    }

    @objc private func okButtonClicked() {
        
//        guard accountField!.hasText else {
//            CustomMBProgressHUD.showTipAndHideImmediately(kEnterAccount, details: nil, view: view)
//            return
//        }
//        
//        guard passwordField!.hasText else {
//            CustomMBProgressHUD.showTipAndHideImmediately(kEnterPassword, details: nil, view: view)
//            return
//        }
        
        
        if type == 1 { // 病历绑定
            gotoRegisterOrLoginHuanXin()
        } else if type == 2 { // 新增就诊人（添加复诊患者）
            _ = navigationController?.popViewController(animated: true)
        } else if type == 3 { // 关联家庭成员病历
            _ = navigationController?.popViewController(animated: true)
        }
        
        let vc = AddPatientInfoController()
        navigationController?.pushViewController(vc, animated: true )
    }
    
    private func gotoRegisterOrLoginHuanXin() {
        
        let isSuccess = LoginHuanXin.shareLoginHuanXin().setupRegisterHuanXin()
        if isSuccess == true {
            customLoadTip?.hideLoadTipWithSuccess()
        } else {
            customLoadTip?.hideLoadTipWithError()
        }
    }


    // MARK:- 提示
    private func setupRuiBaoYinSiYieXie() {
        
        let circleViewWH: CGFloat = 6
        let circleView = UIView(frame: CGRect(x: kMargin15, y: okButton!.frame.maxY + 22, width: circleViewWH, height: circleViewWH))
        circleView.layer.cornerRadius = circleViewWH/2
        circleView.clipsToBounds = true
        circleView.backgroundColor = appMainColor
        view.addSubview(circleView)
        
        let tipLabelX: CGFloat = circleView.frame.maxX + 6
        let tipLabelY: CGFloat = okButton!.frame.maxY + kMargin15
        let tipLabelW: CGFloat = kScreenWidth - kMargin15 - tipLabelX
        let tipLabelH: CGFloat = 60
        let tipLabel = VerticalAlignmentLabel(frame: CGRect(x: tipLabelX, y: tipLabelY, width: tipLabelW, height: tipLabelH))
        tipLabel.text = kAfterInitialTreatmentTip
        tipLabel.textColor = rgb153
        tipLabel.font = font14
        tipLabel.numberOfLines = 0
        tipLabel.verAlignment = .top
        view.addSubview(tipLabel)
    }
}

extension MedicalRecordBindingController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /// 6 - 1 = 5
        if accountField!.hasText && passwordField!.hasText && passwordField!.text!.characters.count >= 5 {
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

extension MedicalRecordBindingController: CustomSwitchDelegate {
    func buttonOfCustomSwitchClicked(btn: CustomSwitch) {
        passwordField!.isSecureTextEntry = btn.isSelected
    }
}
