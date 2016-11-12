//
//  FeedbackController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/4.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  意见反馈

import UIKit
import AFNetworking

class FeedbackController: BaseViewController {

    var scrollView: UIScrollView!
    var tijiao: UIButton?
    
    var textViewBackView: UIView!
    var textView: UITextView!
    var maxWords: UILabel!
    
    var phoneField: UITextField!
    
    var customLoadTip: CustomLoadTip?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = kProfileFeedback
        
        setUpMainScrollview()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(FeedbackController.signOutKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func signOutKeyboard() {
        textView.resignFirstResponder()
    }

    fileprivate func setUpMainScrollview() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        setUpTopView()
        setupPhoneView()
        setUpSubmitButton()
    }
    
    fileprivate func setUpTopView() {
        let backViewH: CGFloat = 206
        textViewBackView = UIView(frame: CGRect(x: 0, y: 20, width: kScreenWidth, height: backViewH))
        textViewBackView.backgroundColor = UIColor.white
        textViewBackView.layer.borderColor = rgbSameColor(213).cgColor
        textViewBackView.layer.borderWidth = 0.5
        scrollView.addSubview(textViewBackView)

        let textViewH = backViewH - 2*kMargin
        textView = UITextView(frame: CGRect(x: kMargin, y: kMargin, width: kScreenWidth - 2*kMargin, height: textViewH))
        textView.font = font15
        textView.textColor = rgb50
        textView.delegate = self
        textViewBackView.addSubview(textView)
        
        textView.returnKeyType = UIReturnKeyType.go

        textView.addSubview(placehoder)
        placehoder.frame = CGRect(x: 5, y: 8, width: 200, height: 18)
        
        
        let maxWordsW: CGFloat = 100
        let maxWordsH: CGFloat = 20
        let maxWordsY: CGFloat = backViewH - 15 - maxWordsH
        let maxWordsX: CGFloat = kScreenWidth - 15 - maxWordsW
        maxWords = UILabel(frame: CGRect(x: maxWordsX, y: maxWordsY, width: maxWordsW, height: maxWordsH))
        maxWords.text = "120"
        maxWords.font = font14
        maxWords.textColor = rgb153
        maxWords.textAlignment = .right
        textViewBackView.addSubview(maxWords)
    }
    
    fileprivate lazy var placehoder: UILabel = {
        let tip = UILabel()
        tip.textColor = UIColor.gray
        tip.font = font15
        tip.text = kPleaseEnterYourComments
        return tip
    }()
    
    fileprivate func setupPhoneView() {
        
        let phoneView = UIView(frame: CGRect(x: 0, y: textViewBackView.frame.maxY + kMargin, width: kScreenWidth, height: 44))
        phoneView.layer.borderWidth = 0.5
        phoneView.layer.borderColor = rgbSameColor(213).cgColor
        phoneView.backgroundColor = UIColor.white
        scrollView.addSubview(phoneView)
        
        let tipW = kContactInformation.calculateTheSizeOfTheString(font16, maxWidth: 200).width
        let tip = UILabel(frame: CGRect(x: 15, y: 5, width: tipW, height: 34))
        tip.textColor = rgb51
        tip.font = font16
        tip.text = kContactInformation
        phoneView.addSubview(tip)
        
        let phoneFieldX: CGFloat = tip.frame.maxX + kMargin
        let phoneFieldW = kScreenWidth - 15 - phoneFieldX
        phoneField = UITextField(frame: CGRect(x: phoneFieldX, y: 5, width: phoneFieldW, height: 34))
        phoneField.placeholder = kPleaseEnterMobilePhoneNumber
        phoneField.font = font14
        phoneField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        phoneField.leftViewMode = UITextFieldViewMode.always
        phoneField.clearButtonMode = UITextFieldViewMode.whileEditing
        phoneField.keyboardType = UIKeyboardType.phonePad
        phoneView.addSubview(phoneField)
    }
    
    fileprivate func setUpSubmitButton() {
        tijiao = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        tijiao!.setTitleColor(UIColor.white, for: .normal)
        tijiao!.setTitle(kSubmission, for: .normal)
        tijiao!.titleLabel?.font = font16
        tijiao!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        tijiao!.addTarget(self, action: (#selector(FeedbackController.complete)), for: .touchUpInside)
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: tijiao!)
    }
    
    // MARK:- 提交
    func complete() {
        
        textView.resignFirstResponder()
        phoneField.resignFirstResponder()

        if !textView.hasText {
            CustomMBProgressHUD.showTipAndHideImmediately(kPleaseEnterContent, details: nil, view:view)
            return
        } else if textView.text.characters.count > 120 {
            CustomMBProgressHUD.showTipAndHideImmediately(kWordTooMuch, details: nil, view:view)
            return
        }
                
        customLoadTip = CustomLoadTip.showLoadTip(view)
        tijiao?.isEnabled = false
        
        let url = kBaseUrlString + "feedbacks"
        var parm: Dictionary<String, String> = Dictionary()
        let doctorID = defaults.string(forKey: kPatientIDKey)!
        parm["userId"] = doctorID
        parm["resource"] = "doctor"
        parm["issues"] = textView.text
        parm["contact"] = phoneField.text ?? ""
        
        // token
        let token = defaults.string(forKey: kPatientTockenKey)!
        
        LLog(parm)
        
        let request:NSMutableURLRequest = NSMutableURLRequest.init(url: URL.init(string: url)!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
        
        var data:Data?
        do {
            data = try JSONSerialization.data(withJSONObject: parm, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = data
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "token")
            let manager = AFURLSessionManager.init(sessionConfiguration: URLSessionConfiguration.default)
            let task =  manager.dataTask(with: request as URLRequest, completionHandler: { (response, object, error) in

                LLog(object)
                LLog(error)
                
                if error == nil && object != nil {
                    let dict = object as? Dictionary<String, AnyObject>
                    if dict != nil {
                        let state = dict!["status"] as? String
                        if state  == "SUCCESS" {

                            self.customLoadTip?.hideLoadTipWithSuccess()
                            
//                            let time: NSTimeInterval = 1.0
//                            let delay = dispatch_time(DISPATCH_TIME_NOW,
//                                Int64(time * Double(NSEC_PER_SEC)))
//                            dispatch_after(delay, dispatch_get_main_queue()) {
                                _ = self.navigationController?.popViewController(animated: true)
//                            }

                        } else {
                            self.customLoadTip?.hideLoadTipWithError()
                        }
                    } else {
                        self.customLoadTip?.hideLoadTipWithError()
                    }
                } else {
                    self.customLoadTip?.hideLoadTipWithError()
                }
                
                self.tijiao?.isEnabled = true

            })
            task.resume()
        } catch {
            self.customLoadTip?.hideLoadTipWithError()
            self.tijiao?.isEnabled = true
        }
    }
}

// MARK: - UITextViewDelegate
extension FeedbackController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placehoder.isHidden = textView.hasText
        
        if textView.text.characters.count > 120 {
            return
        }
        
        let remaining = 120 - Int(textView.text.characters.count)
        maxWords.text = "\(remaining)"
    }
}

extension FeedbackController: UIScrollViewDelegate {

}
