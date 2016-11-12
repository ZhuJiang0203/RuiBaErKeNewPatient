//
//  ModifyPasswordController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/7/9.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  修改密码

import UIKit
import AFNetworking
import MBProgressHUD

class ModifyPasswordController: BaseViewController {

    var scrollView: UIScrollView!
    var ok: UIButton?
    
    var originalTextField: UITextField!
    var newField: UITextField!
    var againField: UITextField!
    
    var customLoadTip: CustomLoadTip?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = kModifyPassword
        
        // 创建scrollView
        setupScrollView()
    }
    
    // MARK:- 创建scrollView
    fileprivate func setupScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        let originalView = UIView(frame: CGRect(x: 0, y: 26, width: kScreenWidth, height: 44))
        scrollView.addSubview(originalView)
        
        let originalTip = UILabel(frame: CGRect(x: 15, y: 0, width: 58, height: 44))
        originalTip.text = kOriginalPassword
        originalTip.textColor = rgb102
        originalTip.font = font16
        originalView.addSubview(originalTip)
        
        let originalTextFieldX: CGFloat = 73
        let originalTextFieldW = kScreenWidth - 15 - originalTextFieldX
        originalTextField = UITextField(frame: CGRect(x: originalTextFieldX, y: 0, width: originalTextFieldW, height: 44))
        originalTextField.backgroundColor = UIColor.white
        originalTextField.layer.cornerRadius = 2.5
        originalTextField.clipsToBounds = true
        originalTextField.layer.borderColor = rgbSameColor(213).cgColor
        originalTextField.layer.borderWidth = 0.5
        originalTextField.placeholder = kPleaseEnterOriginalPassword
        originalTextField.font = font14
        originalTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        originalTextField.leftViewMode = UITextFieldViewMode.always
        originalTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        originalTextField.isSecureTextEntry = true
        originalView.addSubview(originalTextField)
        
        
        
        let newView = UIView(frame: CGRect(x: 0, y: originalView.frame.maxY + kMargin, width: kScreenWidth, height: 44))
        scrollView.addSubview(newView)
        
        let newTip = UILabel(frame: CGRect(x: 15, y: 0, width: 58, height: 44))
        newTip.text = kNewPassword
        newTip.textColor = rgb102
        newTip.font = font16
        newView.addSubview(newTip)
        
        newField = UITextField(frame: CGRect(x: originalTextFieldX, y: 0, width: originalTextFieldW, height: 44))
        newField.backgroundColor = UIColor.white
        newField.layer.cornerRadius = 2.5
        newField.clipsToBounds = true
        newField.layer.borderColor = rgbSameColor(213).cgColor
        newField.layer.borderWidth = 0.5
        newField.placeholder = kPleaseEnterNewPassword
        newField.font = font14
        newField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        newField.leftViewMode = UITextFieldViewMode.always
        newField.clearButtonMode = UITextFieldViewMode.whileEditing
        newField.isSecureTextEntry = true
        newView.addSubview(newField)
        
        
        let againView = UIView(frame: CGRect(x: 0, y: newView.frame.maxY + kMargin, width: kScreenWidth, height: 44))
        scrollView.addSubview(againView)
        
        let againTip = UILabel(frame: CGRect(x: 15, y: 0, width: 58, height: 44))
        againTip.text = kNewPassword
        againTip.textColor = rgb102
        againTip.font = font16
        againView.addSubview(againTip)
        
        againField = UITextField(frame: CGRect(x: originalTextFieldX, y: 0, width: originalTextFieldW, height: 44))
        againField.backgroundColor = UIColor.white
        againField.layer.cornerRadius = 2.5
        againField.clipsToBounds = true
        againField.layer.borderColor = rgbSameColor(213).cgColor
        againField.layer.borderWidth = 0.5
        againField.placeholder = kkPleaseEnterNewPasswordAgain
        againField.font = font14
        againField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        againField.leftViewMode = UITextFieldViewMode.always
        againField.clearButtonMode = UITextFieldViewMode.whileEditing
        againField.isSecureTextEntry = true
        againView.addSubview(againField)
        
        

        ok = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        ok!.setTitle(kEnsure, for: .normal)
        ok!.setTitleColor(UIColor.white, for: .normal)
        ok!.titleLabel?.font = font16
        ok!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        ok!.addTarget(self, action: #selector(ModifyPasswordController.okClicked), for: .touchUpInside)
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: ok!)
    }

    // MARK:- 修改密码
    func okClicked() {
        
        originalTextField.resignFirstResponder()
        newField.resignFirstResponder()
        againField.resignFirstResponder()
        
        if originalTextField.hasText == false {
            CustomMBProgressHUD.showTipAndHideImmediately(kPleaseEnterOriginalPassword, details: nil, view: view)
            return
        }
        if newField.hasText == false {
            CustomMBProgressHUD.showTipAndHideImmediately(kPleaseEnterNewPassword, details: nil, view: view)
            return
        }
        if againField.hasText == false {
            CustomMBProgressHUD.showTipAndHideImmediately(kkPleaseEnterNewPasswordAgain, details: nil, view: view)
            return
        }
        if newField.text != againField.text {
            CustomMBProgressHUD.showTipAndHideImmediately(kNewPasswordNotUnified, details: nil, view: view)
            return
        }
        
        let url = kBaseUrlString + "authorities/updateDoctorPassword"
        var parm: Dictionary<String, String> = Dictionary()
        let doctorID = defaults.string(forKey: kPatientIDKey)!
        parm["doctorId"] = doctorID
        parm["oldPassword"] = originalTextField.text
        parm["newPassword"] = newField.text
        
        LLog(parm)
        
//        _ = MBProgressHUD.showAdded(to: view, animated: true)
        customLoadTip = CustomLoadTip.showLoadTip(view)
        ok?.isEnabled = false
        
        let request:NSMutableURLRequest = NSMutableURLRequest.init(url: URL.init(string: url)!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        
        var data:Data?
        do {
            data = try JSONSerialization.data(withJSONObject: parm, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = data
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let manager = AFHTTPSessionManager.init(sessionConfiguration: URLSessionConfiguration.default)
            
            let task = manager.dataTask(with: request as URLRequest, completionHandler: { (response, object, error) in
                
                LLog(object)
                LLog(error)
                if error == nil && object != nil {
                    if let dict = object as? Dictionary<String, AnyObject> {
                        let state = dict["status"] as? String
                        if state  == "SUCCESS" {
                            
                            self.customLoadTip?.hideLoadTipWithSuccess()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { 
                                self.signOut()
                            })
                            
                        } else {
                            self.customLoadTip?.hideLoadTipWithError()
                        }
                    } else {
                        self.customLoadTip?.hideLoadTipWithError()
                    }
                } else {
                    self.customLoadTip?.hideLoadTipWithError()
                }
                
                self.ok?.isEnabled = true

            })
            task.resume()
        } catch {
            customLoadTip?.hideLoadTipWithError()
            self.ok?.isEnabled = true
        }
    }
    
    // MARK:- 退出登录
    func signOut() {

        defaults.setValue("", forKey: kPatientIDKey)
        defaults.setValue("", forKey: kPatientTockenKey)
        defaults.setValue("", forKey: kPatientIconKey)
        defaults.setValue("", forKey: kPatientNameKey)
        
        let window = UIApplication.shared.delegate!.window!
//        let vc = LoginController()
        let vc = LoginViewController()
        let navVC = BaseNavigationController(rootViewController: vc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }

    
}
