//
//  DoctorAppointmentController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  预约 医生主页

import UIKit

class DoctorAppointmentController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = rgb244
        
        // 医生基本信息
        setupDoctorInfosView()
        
        // 预约模块
        setupAppointmentView()
    }
    
    // MARK:- 医生基本信息
    private func setupDoctorInfosView() {
        
        let backView = UIView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: 96))
        backView.backgroundColor = appMainColor
        view.addSubview(backView)
        
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
    
    // MARK:- 预约模块
    private func setupAppointmentView() {
        
        let appointmentView = UIView(frame: CGRect(x: 0, y: 160, width: kScreenWidth, height: 150))
        appointmentView.backgroundColor = UIColor.white
        view.addSubview(appointmentView)
        
        // 排班、上午、下午
        appointmentView.addSubview(setupLeftView())
        
      
        let scrollViewX: CGFloat = 32
        let scrollViewW: CGFloat = kScreenWidth - scrollViewX
        let scrollViewH: CGFloat = 150
        let totalNumber = 30
        let countRow = 5
        let scrollView = UIScrollView(frame: CGRect(x: scrollViewX, y: 0, width: scrollViewW, height: scrollViewH))
        scrollView.contentSize = CGSize(width: scrollViewW*CGFloat(totalNumber/countRow), height: 0)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        appointmentView.addSubview(scrollView)
        
        
        let backViewW: CGFloat = (kScreenWidth - 32)/CGFloat(countRow)
        let backViewH: CGFloat = 150
        let vwH: CGFloat = 50
        for i in 0..<30 {
            
            let backViewX: CGFloat =  backViewW*CGFloat(i)
            let backView = UIView(frame: CGRect(x:backViewX, y: 0, width: backViewW, height: backViewH))
            scrollView.addSubview(backView)
            
            /// 日期
            let dateViewY: CGFloat = 0
            let dateLabel = UILabel(frame: CGRect(x: 0, y: dateViewY, width: backViewW, height: vwH))
            dateLabel.text = "09-27\n周四"
            dateLabel.textColor = rgb102
            dateLabel.font = font12
            dateLabel.textAlignment = .center
            dateLabel.numberOfLines = 0
            backView.addSubview(dateLabel)

            
            /// 上午
            let morningView = UIView(frame: CGRect(x: 0, y: vwH, width: backViewW, height: vwH))
            morningView.tag = i
            let morningTap = UITapGestureRecognizer(target: self, action: #selector(DoctorAppointmentController.morningViewClicked(_:)))
            morningView.addGestureRecognizer(morningTap)
            backView.addSubview(morningView)
            
            let morningIconView = UIImageView(image: UIImage(named: "YiYueManIcon"))
            morningIconView.center = CGPoint(x: backViewW/2, y: vwH/2)
            morningView.addSubview(morningIconView)

            let morningContentLabel = UILabel(frame: morningView.bounds)
            morningContentLabel.text = kThis
            morningContentLabel.textColor = rgb51
            morningContentLabel.font = font15
            morningContentLabel.textAlignment = .center
            morningView.addSubview(morningContentLabel)

            
            /// 下午
            let afternoonView = UIView(frame: CGRect(x: 0, y: vwH*2, width: backViewW, height: vwH))
            afternoonView.tag = i
            let afternoonTap = UITapGestureRecognizer(target: self, action: #selector(DoctorAppointmentController.afternoonViewClicked(_:)))
            afternoonView.addGestureRecognizer(afternoonTap)
            backView.addSubview(afternoonView)
            
            let afternoonIconView = UIImageView(image: UIImage(named: "YiYueManIcon"))
            afternoonIconView.center = CGPoint(x: backViewW/2, y: vwH/2)
            afternoonView.addSubview(afternoonIconView)
            
            let afternoonContentLabel = UILabel(frame: morningView.bounds)
            afternoonContentLabel.text = kThis
            afternoonContentLabel.textColor = rgb51
            afternoonContentLabel.font = font15
            afternoonContentLabel.textAlignment = .center
            afternoonView.addSubview(afternoonContentLabel)
            
            
            let line1 = UIView(frame: CGRect(x: 0, y: 0, width: 0.5, height: backViewH))
            line1.backgroundColor = rgbSameColor(237)
            backView.addSubview(line1)
            
            let line2 = UIView(frame: CGRect(x: 0, y: vwH, width: backViewW, height: 0.5))
            line2.backgroundColor = rgbSameColor(237)
            backView.addSubview(line2)
            
            let line3 = UIView(frame: CGRect(x: 0, y: vwH*2, width: backViewW, height: 0.5))
            line3.backgroundColor = rgbSameColor(237)
            backView.addSubview(line3)
        }
    }
    
    /**
     上午 被点击
     */
    @objc private func morningViewClicked(_ tap: UITapGestureRecognizer) {
        let vc = AppointmentDetailsController()
        vc.type = .YuYueXiangQing
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /**
     上午 被点击
     */
    @objc private func afternoonViewClicked(_ tap: UITapGestureRecognizer) {
        let vc = AppointmentDetailsController()
        vc.type = .YuYueXiangQing
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupLeftView() -> UIView {
    
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 150))
    
        let paiban = UILabel(frame: CGRect(x: 10, y: 0, width: 12, height: 50))
        paiban.numberOfLines = 0
        paiban.text = kScheduling
        paiban.textColor = rgb102
        paiban.font = font12
        paiban.textAlignment = .center
        leftView.addSubview(paiban)

        let morning = UILabel(frame: CGRect(x: 10, y: 50, width: 12, height: 50))
        morning.numberOfLines = 0
        morning.text = kMorning
        morning.textColor = rgb102
        morning.font = font12
        morning.textAlignment = .center
        leftView.addSubview(morning)
        
        let afternoon = UILabel(frame: CGRect(x: 10, y: 100, width: 12, height: 50))
        afternoon.numberOfLines = 0
        afternoon.text = kAfternoon
        afternoon.textColor = rgb102
        afternoon.font = font12
        afternoon.textAlignment = .center
        leftView.addSubview(afternoon)
        
        return leftView
    }
}
