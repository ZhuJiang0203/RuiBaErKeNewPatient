//
//  MyRainbowCell.swift
//  querendingdan
//
//  Created by whj on 16/6/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let kMyRainbowCellIdentifier = "kMyRainbowCellIdentifier"

class MyRainbowCell: UITableViewCell {

    var model: MyRainbowModel? {
        didSet{
            if model != nil {
                
                var typeW: CGFloat = 30
                switch model!.rainbowType {
                case "0":
                    icon.image = UIImage(named: "RainbowType1")
                    type.text = "消耗"
                    number.text = "-\(model!.rainbowNumber)"

                case "1":
                    icon.image = UIImage(named: "RainbowType0")
                    type.text = "签到"
                    number.text = "+\(model!.rainbowNumber)"

                case "2":
                    icon.image = UIImage(named: "RainbowType2")
                    type.text = "分享APP"
                    number.text = "+\(model!.rainbowNumber)"
                    typeW = 60
                case "3":
                    icon.image = UIImage(named: "RainbowType3")
                    type.text = "转发文章"
                    number.text = "+\(model!.rainbowNumber)"
                    typeW = 60
                default:
                    icon.image = UIImage(named: "RainbowType4")
                    type.text = "绑定手机号"
                    number.text = "+\(model!.rainbowNumber)"
                    typeW = 75
                }
                time.text = model!.rainbowTime

                type.frame.size.width = typeW
                time.frame.origin.x = type.frame.maxX + kMargin
            }
        }
    }
    
    class func setupMyRainbowCell(_ tableView: UITableView, indexPath: IndexPath) -> MyRainbowCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kMyRainbowCellIdentifier) as? MyRainbowCell
        if cell == nil {
            cell = MyRainbowCell.init(style: UITableViewCellStyle.default, reuseIdentifier: kMyRainbowCellIdentifier)
            cell!.selectionStyle = UITableViewCellSelectionStyle.none
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加子控件
        contentView.addSubview(icon)
        contentView.addSubview(type)
        contentView.addSubview(time)
        contentView.addSubview(number)
        contentView.addSubview(line)
        
        let cellH: CGFloat = 55
        let iconWH: CGFloat = 16
        let iconY = (cellH - iconWH)/2
        icon.frame = CGRect(x: 16, y: iconY, width: iconWH, height: iconWH)
        let typeW: CGFloat = 30
        let typeH: CGFloat = 21
        let typeY = (cellH - typeH)/2
        type.frame = CGRect(x: icon.frame.maxX + kMargin, y: typeY, width: typeW, height: typeH)
        time.frame = CGRect(x: type.frame.maxX + kMargin, y: typeY, width: 200, height: typeH)
        let numberW: CGFloat = 100
        let numberX: CGFloat = kScreenWidth - kMargin - numberW
        number.frame = CGRect(x: numberX, y: typeY, width: numberW, height: typeH)
        line.frame = CGRect(x: 0, y: cellH - 0.5, width: kScreenWidth, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var icon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    fileprivate lazy var type: UILabel = {
        let lbl = UILabel()
        lbl.font = font15
        lbl.textColor = rgb50
        return lbl
    }()

    fileprivate lazy var time: UILabel = {
        let lbl = UILabel()
        lbl.font = font13
        lbl.textColor = rgb153
        return lbl
    }()
    
    fileprivate lazy var number: UILabel = {
        let lbl = UILabel()
        lbl.font = font15
        lbl.textColor = rgb50
        lbl.textAlignment = .right
        return lbl
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
}
