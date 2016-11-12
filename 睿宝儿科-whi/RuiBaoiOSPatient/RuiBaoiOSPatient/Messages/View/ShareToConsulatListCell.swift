//
//  ShareToConsulatListCell.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let kShareToConsulatListCellIdentifer = "ShareToConsulatListCellIdentifer"

class ShareToConsulatListCell: UITableViewCell {

    var model: ConsultationListModel? {
        didSet{
            if model != nil {
                if model!.iconUrl != nil {
                    let iconUrl = kBaseUrlString + model!.iconUrl!
                    iconImageView.sd_setImage(with: URL.init(string: iconUrl), placeholderImage: UIImage.init(named: "IconPlacehoderGray60"))
                }
                nameLable.text = model!.name
            }
        }
    }
    
    class func setupConsultationCell(_ tableView: UITableView, indexPath: IndexPath) -> ShareToConsulatListCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kShareToConsulatListCellIdentifer) as? ShareToConsulatListCell
        if cell == nil {
            cell = ShareToConsulatListCell(style: UITableViewCellStyle.default, reuseIdentifier: kShareToConsulatListCellIdentifer)
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加子控件
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLable)
        contentView.addSubview(lineView)
        
        let cellH: CGFloat = kCellHeight
        let iconWH: CGFloat = 34
        let iconY = (cellH - iconWH)/2
        iconImageView.frame = CGRect(x: kMargin, y: iconY, width: iconWH, height: iconWH)
        let nameX: CGFloat = iconImageView.frame.maxX + kMargin
        let nameW: CGFloat = kScreenWidth - kMargin - nameX
        nameLable.frame = CGRect(x: nameX, y: iconY, width: nameW, height: iconWH)
        contentView.addSubview(nameLable)
        lineView.frame = CGRect(x: 0, y: cellH - 0.5, width: kScreenWidth, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = UIViewContentMode.scaleAspectFill
        icon.clipsToBounds = true
        icon.layer.cornerRadius = 34.0/2
        icon.clipsToBounds = true
        return icon
    }()
    
    fileprivate lazy var nameLable: UILabel = {
        let name = UILabel()
        name.textColor = rgb50
        name.font = font16
        return name
    }()
    
    fileprivate lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
}
