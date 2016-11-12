//
//  ToEvaluateController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/20.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  评价

import UIKit

class ToEvaluateController: BaseViewController {

    private var topView: UIView!
    private var textView: UITextView!
    let submitH: CGFloat = 48

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "患者姓名"

        /// 创建topView
        setupTopView()
        
        // 创建textView
        setupTextView()
        
        /// 创建submit
        setupSubmitButton()
    }
    
    private func setupTopView() {
        let topViewH: CGFloat = 140
        topView = UIView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: topViewH))
        view.addSubview(topView)
        
        let title = UILabel(frame: CGRect(x: 15, y: 20, width: 200, height: 22))
        title.text = kDoctorEvaluation
        title.textColor = rgb102
        title.font = font12
        topView.addSubview(title)
        
        let starsView = StartsView.setupStartsView(frame: CGRect(x: 0, y: title.frame.maxY + 15, width: kScreenWidth, height: 45), starsNumber: 5)
        starsView.delegate = self
        topView.addSubview(starsView)

        let tip = UILabel(frame: CGRect(x: 15, y: starsView.frame.maxY + 14, width: kScreenWidth - 30, height: 17))
        tip.text = kDoctorEvaluationTip
        tip.textColor = rgb153
        tip.font = font12
        topView.addSubview(tip)

        let line = UIView(frame: CGRect(x: 12, y: topViewH - 0.5, width: kScreenWidth - 24, height: 0.5))
        line.backgroundColor = rgbSameColor(208)
        topView.addSubview(line)
    }

    private func setupTextView() {
        let backViewX: CGFloat = 12
        let backViewW = kScreenWidth - 2*backViewX
        let backViewH: CGFloat = 200
        let backView = UIView(frame: CGRect(x: 12, y: topView.frame.maxY + kMargin15, width: backViewW, height: backViewH))
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 4
        backView.clipsToBounds = true
        backView.layer.borderColor = rgbSameColor(208).cgColor
        backView.layer.borderWidth = 0.5
        view.addSubview(backView)
    
        let textViewW = backViewW - kMargin*2
        let textViewH = backViewH - kMargin
        textView = UITextView(frame: CGRect(x: kMargin, y: 0, width: textViewW, height: textViewH))
        textView.tintColor = appMainColor
        textView.font = font15
        textView.textColor = rgb50
        textView.delegate = self
        textView.returnKeyType = .go
        backView.addSubview(textView)
    }

    private func setupSubmitButton() {
        let submit = UIButton(frame: CGRect(x: 0, y: kScreenHeight - submitH, width: kScreenWidth, height: submitH))
        submit.setBackgroundImage(UIImage(named: "ToEvaluateControllerSubmitBackImage"), for: .normal)
        submit.setTitle(kSubmission, for: .normal)
        submit.setTitleColor(UIColor.white, for: .normal)
        submit.titleLabel?.font = font16
        submit.addTarget(self, action: #selector(ToEvaluateController.submitClicked), for: .touchUpInside)
        view.addSubview(submit)
    }
    
    @objc private func submitClicked() {
    
    }
}

extension ToEvaluateController: UITextViewDelegate {
    
}

// MARK:- StartsViewDelegate
extension ToEvaluateController: StartsViewDelegate {
    func clickedNumberOfStarts(starsView: StartsView, number: Int){
    
    }
}
