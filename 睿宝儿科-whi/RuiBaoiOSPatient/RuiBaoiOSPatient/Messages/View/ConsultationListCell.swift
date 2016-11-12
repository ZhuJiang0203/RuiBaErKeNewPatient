//
//  ConsultationCell.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/7.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let kConsultationListCellIdentifer = "ConsultationListCellIdentifer"

class ConsultationListCell: UITableViewCell {
    
    var model: ConsultationListModel? {
        didSet{
            if model != nil {
                
                iconImageView.sd_setImage(with: URL.init(string: model!.iconUrl ?? ""), placeholderImage: UIImage.init(named: "IconPlacehoderGray60"))
                nameAndTypeLable.text = model!.name
                timeLabel.text = model!.time
                lastContentLabel.text = model!.lastContent
                
                unReadLabel.isHidden = model!.unReadNumber == 0 ? true : false
                unReadLabel.text = model!.unReadNumber > 99 ? "..." : "\(model!.unReadNumber)"
            }
        }
    }
    
    class func setupConsultationCell(_ tableView: UITableView, indexPath: IndexPath) -> ConsultationListCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kConsultationListCellIdentifer) as? ConsultationListCell
        if cell == nil {
            cell = ConsultationListCell(style: UITableViewCellStyle.default, reuseIdentifier: kConsultationListCellIdentifer)
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加子控件
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameAndTypeLable)
        contentView.addSubview(lastContentLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(unReadLabel)
        contentView.addSubview(lineView)
        let cellH: CGFloat = 91
        let iconWH: CGFloat = 45
        let iconY = (cellH - iconWH)/2
        let kMar: CGFloat = 15
        iconImageView.frame = CGRect(x: kMar, y: iconY, width: iconWH, height: iconWH)
        let nameX: CGFloat = iconImageView.frame.maxX + kMar
        let nameH: CGFloat = 22
        nameAndTypeLable.frame = CGRect(x: nameX, y: iconY, width: 200, height: nameH)
        let lastContentLabelY: CGFloat = nameAndTypeLable.frame.maxY + 4
        let lastContentLabelH: CGFloat = 18
        lastContentLabel.frame = CGRect(x: nameX, y: lastContentLabelY, width: 200, height: lastContentLabelH)
        let timeW: CGFloat = 120
        let timeX = kScreenWidth - kMargin - timeW
        timeLabel.frame = CGRect(x: timeX, y: iconY, width: timeW, height: nameH)
        let unReadLabelX = kScreenWidth - kMargin - nameH
        unReadLabel.frame = CGRect(x: unReadLabelX, y: lastContentLabelY, width: lastContentLabelH, height: lastContentLabelH)
        lineView.frame = CGRect(x: kMar, y: cellH - 0.5, width: kScreenWidth - 2*kMar, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = UIViewContentMode.scaleAspectFill
        icon.clipsToBounds = true
        icon.layer.cornerRadius = 45.0/2
        icon.clipsToBounds = true
        return icon
    }()
    
    fileprivate lazy var nameAndTypeLable: UILabel = {
        let name = UILabel()
        name.textColor = rgb50
        name.font = font16
        return name
    }()
    
    fileprivate lazy var lastContentLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textColor = rgb153
        typeLabel.font = font14
        return typeLabel
    }()
    
    fileprivate lazy var timeLabel: UILabel = {
        let time = UILabel()
        time.textColor = rgb153
        time.font = font12
        time.textAlignment = .right
        return time
    }()

    fileprivate lazy var unReadLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.backgroundColor = rgbColor(252, g: 61, b: 57)
        lbl.textColor = UIColor.white
        lbl.font = font12
        lbl.layer.cornerRadius = 9
        lbl.clipsToBounds = true
        return lbl
    }()

    fileprivate lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
}
