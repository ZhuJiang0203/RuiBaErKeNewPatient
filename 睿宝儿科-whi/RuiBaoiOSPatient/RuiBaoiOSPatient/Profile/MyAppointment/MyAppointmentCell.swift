//
//  MyAppointmentCell.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/20.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let MyAppointmentCellIdentifier = "MyAppointmentCellIdentifier"

@objc
protocol MyAppointmentCellDelegate: NSObjectProtocol {
    @objc optional func stateButtonOfMyAppointmentCellClicked(_ btn: UIButton, cell: MyAppointmentCell)
}

class MyAppointmentCell: UITableViewCell {
    
    weak var delegate: MyAppointmentCellDelegate?

    var model: MyAppointment? {
        didSet{
            if model != nil {
                hospitalLabel.text = model!.hospital
                moneyLabel.text = model!.appointMoney
                iconView.sd_setImage(with: URL(string: model!.doctorIconUrlString), placeholderImage: UIImage(named: "DoctorPlacehoderMan"))
                nameLabel.text = model!.dcotorName
                departmentLabel.text = model!.doctorDeparment
                switch model!.appointState {
                case "1":
                    stateButton.backgroundColor = rgbColor(236, g: 79, b: 93)
                    stateButton.setTitle("待接诊", for: .normal)
                case "2":
                    stateButton.backgroundColor = rgbColor(236, g: 79, b: 93)
                    stateButton.setTitle("待接诊", for: .normal)
                case "3":
                    stateButton.backgroundColor = rgbColor(236, g: 79, b: 93)
                    stateButton.setTitle("待接诊", for: .normal)
                case "4":
                    stateButton.backgroundColor = rgbColor(236, g: 79, b: 93)
                    stateButton.setTitle("待接诊", for: .normal)
                case "5":
                    stateButton.backgroundColor = rgbColor(236, g: 79, b: 93)
                    stateButton.setTitle("待接诊", for: .normal)
                case "6":
                    stateButton.backgroundColor = rgbColor(236, g: 79, b: 93)
                    stateButton.setTitle("待接诊", for: .normal)
                default:
                    print("")
                }
                timeLabel.text = model!.appointTime
                jiuZhenRenLabel.text = model!.jiuZhenRen
            }
        }
    }
    
    class func setupMyAppointmentCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> MyAppointmentCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: MyAppointmentCellIdentifier) as? MyAppointmentCell
        if cell == nil {
            cell = MyAppointmentCell(style: .default, reuseIdentifier: MyAppointmentCellIdentifier)
            cell!.backgroundColor = rgb244
            cell!.selectionStyle = .none
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(backView)
        backView.addSubview(topLine)
        backView.addSubview(hospitalLabel)
        backView.addSubview(moneyLabel)
        backView.addSubview(iconView)
        backView.addSubview(nameLabel)
        backView.addSubview(departmentLabel)
        backView.addSubview(stateButton)
        backView.addSubview(centerLine)
        backView.addSubview(timeLabel)
        backView.addSubview(jiuZhenRenLabel)
        backView.addSubview(bottomLine)
        
//        let cellH: CGFloat = 177
        let backH: CGFloat = 167
        backView.frame = CGRect(x: 0, y: 10, width: kScreenWidth, height: backH)
        topLine.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5)
        hospitalLabel.frame = CGRect(x: 15, y: 15, width: 200, height: 20)
        let moneyW: CGFloat = 150
        let moneyX = kScreenWidth - 15 - moneyW
        moneyLabel.frame = CGRect(x: moneyX, y: 12, width: moneyW, height: 25)
        iconView.frame = CGRect(x: 15, y: hospitalLabel.frame.maxY + 21, width: 45, height: 45)
        let nameX: CGFloat = iconView.frame.maxX + 11
        let nameW: CGFloat = 200
        nameLabel.frame = CGRect(x: nameX, y: hospitalLabel.frame.maxY + 25, width: nameW, height: 22)
        departmentLabel.frame = CGRect(x: nameX, y: nameLabel.frame.maxY + 1, width: nameW, height: 17)
        let stateButtonW: CGFloat = 70
        let stateButtonH: CGFloat = 32
        let stateButtonX: CGFloat = kScreenWidth - 15 - stateButtonW
        let stateButtonY: CGFloat = moneyLabel.frame.maxY + 26
        stateButton.frame = CGRect(x: stateButtonX, y: stateButtonY, width: stateButtonW, height: stateButtonH)
        centerLine.frame = CGRect(x: 15, y: iconView.frame.maxY + 19, width: kScreenWidth - 30, height: 0.5)
        let timeY: CGFloat = iconView.frame.maxY + 32
        timeLabel.frame = CGRect(x: 15, y: timeY, width: 200, height: 20)
        let jzrW: CGFloat = 200
        let jzrX: CGFloat = kScreenWidth - 15 - jzrW
        jiuZhenRenLabel.frame = CGRect(x: jzrX, y: timeY, width: jzrW, height: 20)
        bottomLine.frame = CGRect(x: 0, y: backH - 0.5, width: kScreenWidth, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    fileprivate lazy var hospitalLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        return lbl
    }()
    
    fileprivate lazy var moneyLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbColor(55, g: 62, b: 78)
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .right
        return lbl
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
        lbl.font = font16
        return lbl
    }()
    
    fileprivate lazy var departmentLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font12
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
        btn.addTarget(self, action: #selector(MyAppointmentCell.stateButtonClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func stateButtonClicked(_ btn: UIButton) {
        delegate?.stateButtonOfMyAppointmentCellClicked?(btn, cell: self)
    }
    
    fileprivate lazy var centerLine: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
    
    fileprivate lazy var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font14
        return lbl
    }()
    
    // 就诊人
    fileprivate lazy var jiuZhenRenLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font14
        lbl.textAlignment = .right
        return lbl
    }()
    
    fileprivate lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
}
