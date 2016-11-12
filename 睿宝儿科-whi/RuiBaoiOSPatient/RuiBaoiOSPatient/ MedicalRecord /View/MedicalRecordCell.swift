//
//  MedicalRecordCell.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/7/8.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  病历的cell

import UIKit

private let kMedicalRecordCellIdentifer = "kMedicalRecordCellIdentifer"

class MedicalRecordCell: UITableViewCell {

    var model: MedicalRecord? {
        didSet{
            if model != nil {
                number.text = model!.medicalRecordNumber
                name.text = model!.name
                LLog(model!.name)
                time.text = model!.dob // 出生日期
                let iconPlachoder = model!.sex == "F" ? "Bitmap22" : "Bitmap"
                icon.sd_setImage(with: URL.init(string: model!.patientIcon), placeholderImage: UIImage.init(named: iconPlachoder))
                let sexIcon = model!.sex == "F" ? "SexWomanIcon" : "SexManIcon"
                sexImageView.image = UIImage(named: sexIcon)
                sexLabel.text = model!.sex == "F" ? kFemale : kMale
            }
        }
    }
    
    class func setupMedicalRecordCell(_ tableView: UITableView, indexPath: IndexPath) -> MedicalRecordCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kMedicalRecordCellIdentifer) as? MedicalRecordCell
        if cell == nil {
            cell = MedicalRecordCell(style: UITableViewCellStyle.default, reuseIdentifier: kMedicalRecordCellIdentifer)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加子控件
        contentView.addSubview(superView)
        superView.addSubview(number)
        superView.addSubview(line)
        superView.addSubview(icon)
        superView.addSubview(backView)
        backView.addSubview(name)
        backView.addSubview(time)
        backView.addSubview(sexImageView)
        backView.addSubview(sexLabel)
        
        
        let kMar: CGFloat = 15
        let superW = kScreenWidth - kMar*2
        let superH: CGFloat = 130.0
        
        superView.frame = CGRect(x: 15, y: 0, width: superW, height: superH)
        
        let topH: CGFloat = 42
        let bottomH: CGFloat = 88
        
        number.frame = CGRect(x: kMar, y: 0, width: 200, height: topH)

        line.frame = CGRect(x: kMar, y: topH - 0.5, width: superW - kMar, height: 0.5)
        
        let iconWH: CGFloat = 45
        let iconY = (bottomH - iconWH)/2
        icon.frame = CGRect(x: kMar, y: topH + iconY, width: iconWH, height: iconWH)
        
        let backViewX = icon.frame.maxX + kMargin
        let backViewW = superW - backViewX - kMar
        backView.frame = CGRect(x: backViewX, y: topH + kMar, width: backViewW, height: bottomH - 2*kMar)
        
        let nameW = backViewW - 2*kMargin
        name.frame = CGRect(x: kMargin, y: 7, width: nameW, height: 22)
        let setImgW: CGFloat = 15
        let setImgH: CGFloat = 15
        let setImgY = name.frame.maxY + 4
        sexImageView.frame = CGRect(x: kMargin, y: setImgY, width: setImgW, height: setImgH)
        sexLabel.frame = CGRect(x: sexImageView.frame.maxX + 7, y: setImgY, width: 100, height: setImgH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var superView: UIImageView = {
        let superView = UIImageView()
        superView.image = UIImage(named: "MedicalRecordCellSuperView")
        return superView
    }()

    fileprivate lazy var number: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font16
        return lbl
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(231)
        return line
    }()
    
    fileprivate lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 22.5
        icon.clipsToBounds = true
        return icon
    }()
    
    fileprivate lazy var backView: UIView = {
        let vw = UIView()
        vw.backgroundColor = rgbSameColor(247)
        return vw
    }()
    
    fileprivate lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.font = font16
        lbl.textColor = rgb51
        return lbl
    }()

    fileprivate lazy var time: UILabel = {
        let lbl = UILabel()
        lbl.font = font12
        lbl.textColor = rgbSameColor(168)
        return lbl
    }()

    fileprivate lazy var sexImageView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    fileprivate lazy var sexLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = font13
        lbl.textColor = rgb153
        return lbl
    }()
}
