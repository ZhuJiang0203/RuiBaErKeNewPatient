//
//  DoctorListCell.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/12.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let kDoctorListCellIdentifer = "kDoctorListCellIdentifer"

class DoctorListCell: UITableViewCell {
    
    var model: DoctorListModel? {
        didSet{
            
            if model != nil {
                let placehoder = model!.doctorSex == "F" ? "DoctorPlacehoderWoman" : "DoctorPlacehoderMan"
                icon.sd_setImage(with: URL(string: model!.doctorIconUrlString), placeholderImage: UIImage(named: placehoder))
                name.text = model!.doctorName
                keshizhicheng.text = "\(model!.doctorKeShiZhi)  \(model!.doctorZhiCheng)"
                if model!.doctorState == true { // 在线
                    state.text = kOnLine
                    state.backgroundColor = rgbColor(142, g: 205, b: 248)
                } else {
                    state.text = kOffLine
                    state.backgroundColor = rgbSameColor(198)
                }
                state.isHidden = model!.isHideState
                goods.text = model!.doctorGoods
            }
        }
    }

    class func setupDoctorListCellWithTableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> DoctorListCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kDoctorListCellIdentifer) as? DoctorListCell
        if cell == nil {
            cell = DoctorListCell(style: .default, reuseIdentifier: kDoctorListCellIdentifer)
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: kDoctorListCellIdentifer)
        
        contentView.addSubview(icon)
        contentView.addSubview(name)
        contentView.addSubview(keshizhicheng)
        contentView.addSubview(state)
        contentView.addSubview(goods)
        contentView.addSubview(line)
        
        
        let cellH: CGFloat = 100
        let margin: CGFloat = 15
        let iconWH: CGFloat = 45
        let iconY: CGFloat = 21
        icon.frame = CGRect(x: margin, y: iconY, width: iconWH, height: iconWH)
        let nameX: CGFloat = icon.frame.maxX + margin
        let nameY: CGFloat = 17
        name.frame = CGRect(x: nameX, y: nameY, width: 150, height: 22)
        let kszcX = nameX
        let kszcY = name.frame.maxY + 1
        let kszcW = kScreenWidth - margin - kszcX
        keshizhicheng.frame = CGRect(x: kszcX, y: kszcY, width: kszcW, height: 18)
        let stateW: CGFloat = 40
        let stateH: CGFloat = 20
        let stateX: CGFloat = kScreenWidth - margin - stateW
        let stateY: CGFloat = nameY
        state.frame = CGRect(x: stateX, y: stateY, width: stateW, height: stateH)
        let goodsX = nameX
        let goodsY = keshizhicheng.frame.maxY + 6
        let goodsW = kszcW
        goods.frame = CGRect(x: goodsX, y: goodsY, width: goodsW, height: 18)
        line.frame = CGRect(x: margin, y: cellH - 0.5, width: kScreenWidth - 2*margin, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 头像
    fileprivate lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 22.5
        icon.clipsToBounds = true
        return icon
    }()

    /// 名称
    fileprivate lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font16
        return lbl
    }()
    
    /// 科室 职称
    fileprivate lazy var keshizhicheng: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb153
        lbl.font = font13
        return lbl
    }()

    /// 状态
    fileprivate lazy var state: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = rgbColor(142, g: 205, b: 248)
        lbl.layer.cornerRadius = 10
        lbl.clipsToBounds = true
        lbl.textColor = UIColor.white
        lbl.font = font12
        lbl.textAlignment = .center
        return lbl
    }()
    
    /// 擅长
    fileprivate lazy var goods: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font13
        return lbl
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(231)
        return line
    }()
}
