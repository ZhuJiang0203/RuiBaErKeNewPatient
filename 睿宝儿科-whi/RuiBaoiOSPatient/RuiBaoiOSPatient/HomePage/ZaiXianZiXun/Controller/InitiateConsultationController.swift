//
//  InitiateConsultationController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/23.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//   发起咨询，选择咨询类型

import UIKit

class InitiateConsultationController: BaseViewController {
    
    private var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建ScrollView
        setupScrollView()
    
        // 医生基本信息
        setupDoctorInfosView()
        
        // 图文咨询
        setupTuWenConsulationView()
        
        // 在线电话
        setupOnlineTelephoneView()
    }
    
    // MARK:- 创建ScrollView
    private func setupScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        scrollView.backgroundColor = rgb244
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
    }
    
    // MARK:- 医生基本信息
    private func setupDoctorInfosView() {
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 96))
        backView.backgroundColor = appMainColor
        scrollView.addSubview(backView)
        
        let iconWH: CGFloat = 45
        let iconView = UIImageView(frame: CGRect(x: 15, y: 9, width: iconWH, height: iconWH))
        iconView.contentMode = .scaleAspectFill
        iconView.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "DoctorPlacehoderMan"))
        iconView.layer.cornerRadius = iconWH/2
        iconView.clipsToBounds = true
        backView.addSubview(iconView)
        
        let name = "Laurel"
        let nameW: CGFloat = name.calculateTheSizeOfTheString(font16, maxWidth: 200).width
        let nameLabelX: CGFloat = iconView.frame.maxX + 15
        let nameLabel = UILabel(frame: CGRect(x: nameLabelX, y: 5, width: nameW, height: 22))
        nameLabel.text = name
        nameLabel.textColor = UIColor.white
        nameLabel.font = font16
        backView.addSubview(nameLabel)

        let professionLabel = UILabel(frame: CGRect(x: nameLabel.frame.maxX + 7, y: 9, width: 200, height: 17))
        professionLabel.text = "主任医师"
        professionLabel.textColor = UIColor.white
        professionLabel.font = font12
        backView.addSubview(professionLabel)

        let hospitalLabel = UILabel(frame: CGRect(x: nameLabelX, y: nameLabel.frame.maxY + 4, width: 200, height: 18))
        hospitalLabel.text = "复旦大学附属医院华北医院"
        hospitalLabel.textColor = UIColor.white
        hospitalLabel.font = font13
        backView.addSubview(hospitalLabel)

        let department = UILabel(frame: CGRect(x: nameLabelX, y: hospitalLabel.frame.maxY + 3, width: 200, height: 18))
        department.text = "皮肤科"
        department.textColor = UIColor.white
        department.font = font13
        backView.addSubview(department)

        let interrogation = "3.6万"
        let interrogationNumberW = interrogation.calculateTheSizeOfTheString(font13, maxWidth: 200).width + 5
        let interrogationNumberX = kScreenWidth - 15 - interrogationNumberW
        let interrogationNumber = UILabel(frame: CGRect(x: interrogationNumberX, y: 8, width: interrogationNumberW, height: 18))
        interrogationNumber.text = interrogation
        interrogationNumber.textColor = UIColor.white
        interrogationNumber.font = font13
        interrogationNumber.textAlignment = .right
        backView.addSubview(interrogationNumber)

        let circleWH: CGFloat = 6
        let circleX: CGFloat = interrogationNumber.frame.minX - circleWH
        let circle = UIView(frame: CGRect(x: circleX, y: 14, width: circleWH, height: circleWH))
        circle.backgroundColor = rgbColor(255, g: 241, b: 80)
        circle.layer.cornerRadius = circleWH/2
        circle.clipsToBounds = true
        backView.addSubview(circle)

        let interrogationLabelW: CGFloat = 200
        let interrogationLabelX: CGFloat = kScreenWidth - 15 - interrogationLabelW
        let interrogationLabel = UILabel(frame: CGRect(x: interrogationLabelX, y: interrogationNumber.frame.maxY, width: interrogationLabelW, height: 17))
        interrogationLabel.text = kInterrogation
        interrogationLabel.textColor = UIColor.white
        interrogationLabel.font = font12
        interrogationLabel.textAlignment = .right
        backView.addSubview(interrogationLabel)
    }
    
    // MARK:- 图文咨询
    private func setupTuWenConsulationView() {
        
        let backImageViewX: CGFloat = 10
        let backImageViewW: CGFloat = kScreenWidth - backImageViewX*2
        let backImageViewH: CGFloat = 146
        let backImageView = UIImageView(frame: CGRect(x: backImageViewX, y: 119, width: backImageViewW, height: backImageViewH))
        backImageView.image = UIImage(named: "InitiateConsultationCtlPictureConsulting");
        backImageView.isUserInteractionEnabled = true
        backImageView.layer.cornerRadius = 4
        backImageView.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(InitiateConsultationController.goToPictureConsulting))
        backImageView.addGestureRecognizer(tap)
        scrollView.addSubview(backImageView)
        
        let icon = UIImageView(image: UIImage(named: "InitiateConsultationControllerTuWenZiXun"))
        icon.sizeToFit()
        icon.center = CGPoint(x: 45, y: backImageViewH/2)
        backImageView.addSubview(icon)
        
        let titleLblX = icon.frame.maxX + kMargin
        let titleLbl = UILabel(frame: CGRect(x: titleLblX, y: 46, width: 200, height: 25))
        titleLbl.text = kTextConsulting
        titleLbl.textColor = rgb51
        titleLbl.font = font18
        backImageView.addSubview(titleLbl)
        
        var rightViewW: CGFloat = 115
        if kScreenWidth == 320 {
            rightViewW = 96
        } else if kScreenWidth == 414 {
            rightViewW = 128
        }
        
        let detailsLblW = backImageViewW - rightViewW - kMargin - titleLblX
        let detailsLbl = VerticalAlignmentLabel(frame: CGRect(x: titleLblX, y: titleLbl.frame.maxY + 9, width: detailsLblW, height: 100))
        detailsLbl.text = kTextPictureConsulting
        detailsLbl.textColor = rgb102
        detailsLbl.font = font14
        detailsLbl.numberOfLines = 0
        detailsLbl.verAlignment = .top
        backImageView.addSubview(detailsLbl)
        
        let rightViewX: CGFloat = backImageViewW - rightViewW - 2
        let rightView = UIView(frame: CGRect(x: rightViewX, y: 0, width: rightViewW, height: backImageViewH))
        backImageView.addSubview(rightView)
        
        let renMinBi = UILabel(frame: CGRect(x: 0, y: 28, width: rightViewW, height: 50))
        renMinBi.text = "¥"
        renMinBi.textColor = UIColor.white
        renMinBi.font = UIFont.boldSystemFont(ofSize: 36)
        renMinBi.textAlignment = .center
        rightView.addSubview(renMinBi)

        let priceLabel = UILabel(frame: CGRect(x: 0, y: renMinBi.frame.maxY, width: rightViewW, height: 20))
        priceLabel.text = "10\(kElement)/15\(kMinute)"
        priceLabel.textColor = UIColor.white
        priceLabel.font = font14
        priceLabel.textAlignment = .center
        rightView.addSubview(priceLabel)
    }
    
    /**
     图文咨询
     */
    @objc private func goToPictureConsulting() {
        let vc = PictureConsultingController()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK:- 在线电话
    private func setupOnlineTelephoneView() {
        
        let backImageViewX: CGFloat = 10
        let backImageViewW: CGFloat = kScreenWidth - backImageViewX*2
        let backImageViewH: CGFloat = 146
        let backImageView = UIImageView(frame: CGRect(x: backImageViewX, y: 275, width: backImageViewW, height: backImageViewH))
        backImageView.image = UIImage(named: "InitiateConsultationCtlOnlineTelephone");
        backImageView.isUserInteractionEnabled = true
        backImageView.layer.cornerRadius = 4
        backImageView.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(InitiateConsultationController.goToOnlineTelephone))
        backImageView.addGestureRecognizer(tap)
        scrollView.addSubview(backImageView)
        
        let icon = UIImageView(image: UIImage(named: "InitiateConsultationControllerZaiXianDianHua"))
        icon.sizeToFit()
        icon.center = CGPoint(x: 45, y: backImageViewH/2)
        backImageView.addSubview(icon)
        
        let titleLblX = icon.frame.maxX + 10
        let titleLbl = UILabel(frame: CGRect(x: titleLblX, y: 46, width: 200, height: 25))
        titleLbl.text = kOnlineTelephone
        titleLbl.textColor = rgb51
        titleLbl.font = font18
        backImageView.addSubview(titleLbl)
        
        var rightViewW: CGFloat = 115
        if kScreenWidth == 320 {
            rightViewW = 96
        } else if kScreenWidth == 414 {
            rightViewW = 128
        }
        
        let detailsLblW = backImageViewW - rightViewW - kMargin - titleLblX
        let detailsLbl = VerticalAlignmentLabel(frame: CGRect(x: titleLblX, y: titleLbl.frame.maxY + 9, width: detailsLblW, height: 100))
        detailsLbl.text = kTelephoneConsultationThroughTextPictures
        detailsLbl.textColor = rgb102
        detailsLbl.font = font14
        detailsLbl.numberOfLines = 0
        detailsLbl.verAlignment = .top
        backImageView.addSubview(detailsLbl)
        
        let rightViewX: CGFloat = backImageViewW - rightViewW - 2
        let rightView = UIView(frame: CGRect(x: rightViewX, y: 0, width: rightViewW, height: backImageViewH))
        backImageView.addSubview(rightView)
        
        let renMinBi = UILabel(frame: CGRect(x: 0, y: 28, width: rightViewW, height: 50))
        renMinBi.text = "¥"
        renMinBi.textColor = UIColor.white
        renMinBi.font = UIFont.boldSystemFont(ofSize: 36)
        renMinBi.textAlignment = .center
        rightView.addSubview(renMinBi)
        
        let priceLabel = UILabel(frame: CGRect(x: 0, y: renMinBi.frame.maxY, width: rightViewW, height: 20))
        priceLabel.text = "100\(kElement)/15\(kMinute)"
//        priceLabel.backgroundColor = UIColor.redColor()
        priceLabel.textColor = UIColor.white
        priceLabel.font = font14
        priceLabel.textAlignment = .center
        rightView.addSubview(priceLabel)
    }
    
    /**
     在线电话
     */
    @objc private func goToOnlineTelephone() {
    
    }
}
