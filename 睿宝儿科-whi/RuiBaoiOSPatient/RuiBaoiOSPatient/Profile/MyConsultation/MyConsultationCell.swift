//
//  MyConsultationCell.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/19.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let MyConsultationIdentifier = "MyConsultationIdentifier"

@objc
protocol MyConsultationCellDelegate: NSObjectProtocol {
    @objc optional func stateButtonOfMyConsultationCellClicked(_ btn: UIButton, cell: MyConsultationCell)
}

class MyConsultationCell: UITableViewCell {
    
    weak var delegate: MyConsultationCellDelegate?
    
    var model: MyConsultation? {
        didSet{
            if model != nil {
                timeLabel.text = model!.consultationTime
                iconView.sd_setImage(with: URL(string: model!.doctorIconString), placeholderImage: UIImage(named: "DoctorPlacehoderMan"))
                nameLabel.text = model!.doctorName
                
                switch model!.consultationState {
                case "1":
                    stateButton.setTitle(kThePatientHasBeenWaiting, for: .normal)
                    stateButton.backgroundColor = rgbColor(97, g: 123, b: 180)
                case "2":
                    stateButton.setTitle(kPendingPayment, for: .normal)
                    stateButton.backgroundColor = rgbColor(236, g: 79, b: 93)
                case "3":
                    stateButton.setTitle(kConsulting, for: .normal)
                    stateButton.backgroundColor = rgbColor(82, g: 179, b: 247)
                case "4":
                    stateButton.setTitle(kCanceled, for: .normal)
                    stateButton.backgroundColor = rgbColor(163, g: 165, b: 169)
                case "5":
                    stateButton.setTitle(kToBeEvaluated, for: .normal)
                    stateButton.backgroundColor = rgbColor(247, g: 158, b: 82)
                case "6":
                    stateButton.setTitle(kConsultingAgain, for: .normal)
                    stateButton.backgroundColor = rgbColor(21, g: 199, b: 124)
                default:
                    print("其他")
                }
                
                jiuZhenRenLabel.text = model!.patientName
                zhuSuLabel.text = model!.patientComplaint
            }
        }
    }

    class func setupMyConsultationCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> MyConsultationCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: MyConsultationIdentifier) as? MyConsultationCell
        if cell == nil {
            cell = MyConsultationCell(style: .default, reuseIdentifier: MyConsultationIdentifier)
            cell!.backgroundColor = rgb244
            cell!.selectionStyle = .none
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(backView)
        backView.addSubview(topLine)
        backView.addSubview(iconView)
        backView.addSubview(nameLabel)
        backView.addSubview(stateButton)
        backView.addSubview(centerLine)
        backView.addSubview(jiuZhenRenLabel)
        backView.addSubview(zhuSuLabel)
        backView.addSubview(bottomLine)
        
        let cellH: CGFloat = 174
        let timeH: CGFloat = 32
        let backH: CGFloat = cellH - timeH
        
        timeLabel.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: timeH)
        backView.frame = CGRect(x: 0, y: timeLabel.frame.maxY, width: kScreenWidth, height: backH)
        topLine.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5)
        iconView.frame = CGRect(x: 15, y: 8, width: 45, height: 45)
        nameLabel.frame = CGRect(x: iconView.frame.maxX + 10, y: 18, width: 200, height: 25)
        let stateButtonW: CGFloat = 70
        let stateButtonH: CGFloat = 32
        let stateButtonX: CGFloat = kScreenWidth - 15 - stateButtonW
        stateButton.frame = CGRect(x: stateButtonX, y: 15, width: stateButtonW, height: stateButtonH)
        centerLine.frame = CGRect(x: 15, y: iconView.frame.maxY + 6, width: kScreenWidth - 30, height: 0.5)
        jiuZhenRenLabel.frame = CGRect(x: 15, y: centerLine.frame.maxY + 10, width: kScreenWidth - 30, height: 22)
        zhuSuLabel.frame = CGRect(x: 15, y: jiuZhenRenLabel.frame.maxY + 6, width: kScreenWidth, height: 22)
        bottomLine.frame = CGRect(x: 0, y: cellH - 0.5, width: kScreenWidth, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font12
        lbl.textAlignment = .center
        return lbl
    }()

    fileprivate lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()

    fileprivate lazy var topLine: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()

    fileprivate lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 45.0/2.0
        icon.clipsToBounds = true
        return icon
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font18
        return lbl
    }()

    // 待接诊、待付款、咨询中、已取消、待评价、再次咨询
    fileprivate lazy var stateButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = font14
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(MyConsultationCell.stateButtonClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func stateButtonClicked(_ btn: UIButton) {
        delegate?.stateButtonOfMyConsultationCellClicked?(btn, cell: self)
    }

    fileprivate lazy var centerLine: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
  
    // 就诊人
    fileprivate lazy var jiuZhenRenLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font16
        return lbl
    }()
    
    // 主诉
    fileprivate lazy var zhuSuLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font16
        return lbl
    }()
    
    fileprivate lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
}
