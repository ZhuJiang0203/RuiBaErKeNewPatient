//
//  DoctorCell.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/20.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let DoctorCellIdentifier = "DoctorCellIdentifier"

class DoctorCell: UITableViewCell {
    
    var model: DoctorModel? {
        didSet{
            if model != nil {
                iconView.sd_setImage(with: URL(string: model!.doctorIconUrlString), placeholderImage: UIImage(named: "DoctorPlacehoderMan"))
                nameLabel.text = model!.doctorName
                deparmentLabel.text = "\(model!.doctorDeparment) \(model!.doctorPosition)"
                clinicLabel.text = model!.clinic
            }
        }
    }

    class func setupDoctorCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> DoctorCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: DoctorCellIdentifier) as? DoctorCell
        if cell == nil {
            cell = DoctorCell(style: .default, reuseIdentifier: DoctorCellIdentifier)
            cell!.backgroundColor = UIColor.white
            cell!.selectionStyle = .none
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(deparmentLabel)
        contentView.addSubview(clinicLabel)
        contentView.addSubview(line)
        
        let cellH: CGFloat = 100
        iconView.frame = CGRect(x: 15, y: 20, width: 60, height: 60)
        let nameX: CGFloat = iconView.frame.maxX + 22
        let nameY: CGFloat = 15
        let nameW: CGFloat = kScreenWidth - nameX - 15
        nameLabel.frame = CGRect(x: nameX, y: nameY, width: nameW, height: 22)
        deparmentLabel.frame = CGRect(x: nameX, y: nameLabel.frame.maxY + 4, width: nameW, height: 20)
        clinicLabel.frame = CGRect(x: nameX, y: deparmentLabel.frame.maxY + 7, width: nameW, height: 17)
        line.frame = CGRect(x: 15, y: cellH - 0.5, width: kScreenWidth - 30, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 30
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        return icon
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font16
        return lbl
    }()
    
    fileprivate lazy var deparmentLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        return lbl
    }()
    
    fileprivate lazy var clinicLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbColor(150, g: 159, b: 169)
        lbl.font = font12
        return lbl
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
}
