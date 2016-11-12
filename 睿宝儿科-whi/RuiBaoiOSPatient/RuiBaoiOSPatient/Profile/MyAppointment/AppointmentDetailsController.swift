//
//  AppointmentDetailsController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/20.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

enum AppointmentDetails {
    case YuYueXiangQing
    case ZiXunXiangQing
}

class AppointmentDetailsController: BaseViewController {
  
    var type: AppointmentDetails = .YuYueXiangQing
    
    var scrollView: UIScrollView!
    var topView: UIView!
    var centerView: UIView!
    var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 创建scrollView
        setupScrollView()
        
        if type == .YuYueXiangQing {
            title = kBookingDetails

            customNavigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: .plain, target: self, action: #selector(AppointmentDetailsController.goToSubmit))
        } else {
            title = kConsultationDetails
        }
    }
    
    @objc private func goToSubmit() {
    
    }
    
    fileprivate func setupScrollView() {
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = rgb244
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        // 创建topView
        setupTopView()
        
        // 创建centerView
        setupCenterView()
        
        // 创建bottomView
        setupBottomView()
    }
    
    fileprivate func setupTopView() {
        topView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 64))
        topView.backgroundColor = UIColor.white
        scrollView.addSubview(topView)
        
        let iconViewWH: CGFloat = 45
        let iconY: CGFloat = 10
        let iconView = UIImageView(frame: CGRect(x: 15, y: iconY, width: iconViewWH, height: iconViewWH))
        iconView.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "DoctorPlacehoderMan"))
        iconView.contentMode = .scaleAspectFill
        iconView.layer.cornerRadius = iconViewWH/2
        iconView.clipsToBounds = true
        topView.addSubview(iconView)
        
        let nameDeparmentLabelX: CGFloat = iconView.frame.maxX + 15
        let nameDeparmentLabelW: CGFloat = kScreenWidth - 15 - nameDeparmentLabelX
        let nameDeparmentLabel = UILabel(frame: CGRect(x: nameDeparmentLabelX, y: iconY, width: nameDeparmentLabelW, height: iconViewWH))
        let name = "Laurel"
        let deparment = "主任医师"
        let nameAndDeparment = "\(name) \(deparment)"
        let mutableString = NSMutableAttributedString(string: nameAndDeparment)
        mutableString.addAttributes([NSForegroundColorAttributeName : rgb51], range: NSMakeRange(0, name.characters.count))
        mutableString.addAttributes([NSForegroundColorAttributeName : rgb102], range: NSMakeRange(name.characters.count + 1, deparment.characters.count))
        mutableString.addAttributes([NSFontAttributeName : font16], range: NSMakeRange(0, name.characters.count))
        mutableString.addAttributes([NSFontAttributeName : font12], range: NSMakeRange(name.characters.count + 1, deparment.characters.count))
        nameDeparmentLabel.attributedText = mutableString
        topView.addSubview(nameDeparmentLabel)
    }
    
    fileprivate func setupCenterView() {
        centerView = UIView(frame: CGRect(x: 0, y: 74, width: kScreenWidth, height: 531))
        centerView.backgroundColor = UIColor.white
        scrollView.addSubview(centerView)
        
        
        // 就诊医院
        let keyW: CGFloat = 85
        let keyH: CGFloat = 26
        let hospitalKey = UIButton(frame: CGRect(x: 0, y: 12, width: keyW, height: keyH))
        hospitalKey.setBackgroundImage(UIImage(named: "BackImageR142G205B248"), for: .normal)
        hospitalKey.setTitle(kMedicalHospital, for: .normal)
        hospitalKey.setTitleColor(UIColor.white, for: .normal)
        hospitalKey.titleLabel?.font = font14
        centerView.addSubview(hospitalKey)
        
        let valueX: CGFloat = 12
        let valueW = kScreenWidth - 2*valueX
        let valueH: CGFloat = 40
        let hospitalValue = UIView(frame: CGRect(x: valueX, y: hospitalKey.frame.maxY + 12, width: valueW , height: valueH))
        hospitalValue.backgroundColor = rgbSameColor(247)
        centerView.addSubview(hospitalValue)
        
        let valueLabelX: CGFloat = 10
        let valueLabelW: CGFloat = valueW - 2*valueLabelX
        let hospitalValueLabel = UILabel(frame: CGRect(x: valueLabelX, y: 0, width: valueLabelW, height: valueH))
        hospitalValueLabel.text = "复旦大学附属华山医院"
        hospitalValueLabel.textColor = rgb51
        hospitalValueLabel.font = font16
        hospitalValue.addSubview(hospitalValueLabel)
        
        
        
        
        // 就诊科室
        let deparmentKey = UIButton(frame: CGRect(x: 0, y: hospitalValue.frame.maxY + 15, width: keyW, height: keyH))
        deparmentKey.setBackgroundImage(UIImage(named: "BackImageR142G205B248"), for: .normal)
        deparmentKey.setTitle(kMedicalDepartment, for: .normal)
        deparmentKey.setTitleColor(UIColor.white, for: .normal)
        deparmentKey.titleLabel?.font = font14
        centerView.addSubview(deparmentKey)
        
        let deparmentValue = UIView(frame: CGRect(x: valueX, y: deparmentKey.frame.maxY + 12, width: valueW , height: valueH))
        deparmentValue.backgroundColor = rgbSameColor(247)
        centerView.addSubview(deparmentValue)
        
        let deparmentValueLabel = UILabel(frame: CGRect(x: valueLabelX, y: 0, width: valueLabelW, height: valueH))
        deparmentValueLabel.text = "皮肤科"
        deparmentValueLabel.textColor = rgb51
        deparmentValueLabel.font = font16
        deparmentValue.addSubview(deparmentValueLabel)
        
        
        
        
        
        // 门诊时间
        let timeKey = UIButton(frame: CGRect(x: 0, y: deparmentValue.frame.maxY + 15, width: keyW, height: keyH))
        timeKey.setBackgroundImage(UIImage(named: "BackImageR142G205B248"), for: .normal)
        timeKey.setTitle(kClinicHours, for: .normal)
        timeKey.setTitleColor(UIColor.white, for: .normal)
        timeKey.titleLabel?.font = font14
        centerView.addSubview(timeKey)
        
        let timeValue = UIView(frame: CGRect(x: valueX, y: timeKey.frame.maxY + 12, width: valueW , height: valueH))
        timeValue.backgroundColor = rgbSameColor(247)
        centerView.addSubview(timeValue)
        
        let timeValueLabel = UILabel(frame: CGRect(x: valueLabelX, y: 0, width: valueLabelW, height: valueH))
        timeValueLabel.text = "2016年3月8日 周二10:00-10:30"
        timeValueLabel.textColor = rgb51
        timeValueLabel.font = font16
        timeValue.addSubview(timeValueLabel)
        
        
        
        
        // 门诊类型
        let typeKey = UIButton(frame: CGRect(x: 0, y: timeValue.frame.maxY + 15, width: keyW, height: keyH))
        typeKey.setBackgroundImage(UIImage(named: "BackImageR142G205B248"), for: .normal)
        typeKey.setTitle("门诊类型", for: .normal)
        typeKey.setTitleColor(UIColor.white, for: .normal)
        typeKey.titleLabel?.font = font14
        centerView.addSubview(typeKey)
        
        let typeValue = UIView(frame: CGRect(x: valueX, y: typeKey.frame.maxY + 12, width: valueW , height: valueH))
        typeValue.backgroundColor = rgbSameColor(247)
        centerView.addSubview(typeValue)
        
        let tpyeValueLabel = UILabel(frame: CGRect(x: valueLabelX, y: 0, width: valueLabelW, height: valueH))
        tpyeValueLabel.text = "特需门诊"
        tpyeValueLabel.textColor = rgb51
        tpyeValueLabel.font = font16
        typeValue.addSubview(tpyeValueLabel)
        
        
        
        
        // 挂号费用
        let costKey = UIButton(frame: CGRect(x: 0, y: typeValue.frame.maxY + 15, width: keyW, height: keyH))
        costKey.setBackgroundImage(UIImage(named: "BackImageR142G205B248"), for: .normal)
        costKey.setTitle(kRegistrationFee, for: .normal)
        costKey.setTitleColor(UIColor.white, for: .normal)
        costKey.titleLabel?.font = font14
        centerView.addSubview(costKey)
        
        let costValue = UIView(frame: CGRect(x: valueX, y: costKey.frame.maxY + 12, width: valueW , height: valueH))
        costValue.backgroundColor = rgbSameColor(247)
        centerView.addSubview(costValue)
        
        let costValueLabel = UILabel(frame: CGRect(x: valueLabelX, y: 0, width: valueLabelW, height: valueH))
        costValueLabel.text = "108元"
        costValueLabel.textColor = rgb51
        costValueLabel.font = font16
        costValue.addSubview(costValueLabel)
        
        
        
        
        // 提示
        let tipTxt = kRealNameSystemAppointmentTip
        let margin: CGFloat = 3.0
        let tipLabelH: CGFloat = tipTxt.calculateTheHeightOfTheString(font12, width: valueW, margin: margin, maxRow: 0)
        
        let tipLabel = UILabel(frame: CGRect(x: valueX, y: costValue.frame.maxY + 25, width: valueW, height: tipLabelH))
        tipLabel.textColor = rgb153
        tipLabel.font = font12
        tipLabel.numberOfLines = 0
        // 行间距
        let attributedString = NSMutableAttributedString(string: tipTxt)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = margin
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        tipLabel.attributedText = attributedString
        centerView.addSubview(tipLabel)
        
        
        
        // 确定centerView的最终高度
        centerView.frame.size.height = tipLabel.frame.maxY + 15
    }
    
    
    fileprivate func setupBottomView() {
        bottomView = UIView(frame: CGRect(x: 0, y: centerView.frame.maxY + 10, width: kScreenWidth, height: 240))
        bottomView.backgroundColor = UIColor.white
        scrollView.addSubview(bottomView)
        
        // 确定scrollView的contentSize
        scrollView.contentSize = CGSize(width: kScreenWidth, height: bottomView.frame.maxY + 10)
        
        let keys = [kPatientVisits, kDiseaseInformation, kReservationType, kPaymentMethod]
        let values = ["文晓来", "请填写疾病西你想", "门诊", "去医院支付"]
        
        let viewH: CGFloat = 60
        for i in 0..<4 {
            
            let view = UIView(frame: CGRect(x: 0, y: viewH*CGFloat(i), width: kScreenWidth, height: viewH))
            bottomView.addSubview(view)
            
            let iconWH: CGFloat = 20
            let iconX: CGFloat = 15
            let iconY: CGFloat = (viewH - iconWH)/2
            let icon = UIImageView(frame: CGRect(x: iconX, y: iconY, width: iconWH, height: iconWH))
            icon.image = UIImage(named: "AppointmentDetailsControllerBottonIcon\(i)")
            view.addSubview(icon)
            
            let key = UILabel(frame: CGRect(x: icon.frame.maxX + 10, y: iconY, width: 200, height: iconWH))
            key.textColor = rgb153
            key.text = keys[i]
            key.font = font16
            view.addSubview(key)
            
            let valueW: CGFloat = 200
            let valueX: CGFloat = kScreenWidth - 15 - valueW
            let value = UILabel(frame: CGRect(x: valueX, y: iconY, width: valueW, height: iconWH))
            value.textColor = rgb51
            value.text = values[i]
            value.font = font16
            value.textAlignment = .right
            view.addSubview(value)
            
            if i < 3 {
                let line = UIView(frame: CGRect(x: 15, y: viewH - 0.5, width: kScreenWidth - 30, height: 0.5))
                line.backgroundColor = rgbSameColor(237)
                view.addSubview(line)
            }
        }
    }
}
