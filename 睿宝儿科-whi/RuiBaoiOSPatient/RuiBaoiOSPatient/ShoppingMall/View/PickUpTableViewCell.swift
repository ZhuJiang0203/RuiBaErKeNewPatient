//
//  PickUpTableViewCell.swift
//  querendingdan
//
//  Created by whj on 16/6/14.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let kPickUpTableViewCellIdentifier = "kPickUpTableViewCellIdentifier"

class PickUpTableViewCell: UITableViewCell {
    
    var model: ExpressModel? {
        didSet{
            if model != nil {
                print(model!.selected)
                if model!.selected == true {
                    icon.image = UIImage(named: "ExpressCellIconSelected")
                } else {
                    icon.image = UIImage(named: "ExpressCellIcon")
                }
                addressLabel.text = model!.provincialCityCounty
            }
        }
    }

    class func setupPickUpTableViewCell(_ tableView: UITableView, indexPath: IndexPath) -> PickUpTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kPickUpTableViewCellIdentifier) as? PickUpTableViewCell
        if cell == nil {
            cell = PickUpTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: kPickUpTableViewCellIdentifier)
            cell!.selectionStyle = UITableViewCellSelectionStyle.none
            cell!.backgroundColor = UIColor.clear
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        // 添加子控件
        contentView.addSubview(backView)
        backView.addSubview(icon)
        backView.addSubview(addressLabel)

        let backViewH: CGFloat = 80
        backView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: backViewH)
        let iconWH: CGFloat = 20
        let iconY = (backViewH - iconWH)/2
        icon.frame = CGRect(x: kMargin, y: iconY, width: iconWH, height: iconWH)
        let addressX = icon.frame.maxX + kMargin
        let addressW = kScreenWidth - kMargin - addressX
        addressLabel.frame = CGRect(x: addressX, y: 0, width: addressW, height: backViewH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    
    fileprivate lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "ExpressCellIcon")
        return icon
    }()
    
    fileprivate lazy var addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = font13
        lbl.textColor = rgb50
        lbl.numberOfLines = 0
        return lbl
    }()
}
