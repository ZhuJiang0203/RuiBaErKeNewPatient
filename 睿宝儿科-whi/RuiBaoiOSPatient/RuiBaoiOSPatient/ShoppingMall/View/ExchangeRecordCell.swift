//
//  ExchangeRecordCell.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/7.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let kExchangeRecordCellIdentifier = "kExchangeRecordCellIdentifier"

class ExchangeRecordCell: UITableViewCell {

    var model: ExchangeRecord? {
        didSet{
            if model != nil {
                icon.sd_setImage(with: URL(string: model!.shopIcon), placeholderImage: UIImage(named: model!.shopIconPlachoder))
                name.text = model!.shopName
                
                let ptxt = "\(model!.shopPrice) \(kRainbowCoin)"
                let mutableString = NSMutableAttributedString(string: ptxt)
                mutableString.addAttributes([NSForegroundColorAttributeName : rgbColor(253, g: 119, b: 142)], range: NSMakeRange(0, ptxt.characters.count - 4))
                mutableString.addAttributes([NSForegroundColorAttributeName : rgbSameColor(153)], range: NSMakeRange(ptxt.characters.count - 4, 4))
                mutableString.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 20)], range: NSMakeRange(0, ptxt.characters.count - 4))
                mutableString.addAttributes([NSFontAttributeName : font12], range: NSMakeRange(ptxt.characters.count - 4, 4))
                price.attributedText = mutableString
                
                time.text = model!.shopTime
                number.text = "x\(model!.shopNumber)"
                code.text = "取货码：\(model!.shopCode)"
            }
        }
    }
    
    class func setupExchangeRecordCell(_ tableView: UITableView, indexPath: IndexPath) -> ExchangeRecordCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kExchangeRecordCellIdentifier) as? ExchangeRecordCell
        if cell == nil {
            cell = ExchangeRecordCell.init(style: .default, reuseIdentifier: kExchangeRecordCellIdentifier)
            cell!.selectionStyle = .none
            cell!.backgroundColor = UIColor.clear
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(backView)
        backView.addSubview(icon)
        backView.addSubview(name)
        backView.addSubview(price)
        backView.addSubview(time)
        backView.addSubview(number)
        backView.addSubview(arrow)
        backView.addSubview(line)
        backView.addSubview(code)
        
        backView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 170)
        icon.frame = CGRect(x: 15, y: 18, width: 90, height: 90)
        let nameX: CGFloat = icon.frame.maxX + 10
        let nameW: CGFloat = kScreenWidth - 10 - nameX
        name.frame = CGRect(x: nameX, y: 16, width: nameW, height: 21)
        price.frame = CGRect(x: nameX, y: name.frame.maxY + 12, width: 200, height: 28)
        let timeY: CGFloat = price.frame.maxY + 13
        time.frame = CGRect(x: nameX, y: timeY, width: 200, height: 20)
        let numberW: CGFloat = 100
        let numberX: CGFloat = kScreenWidth - 10 - numberW
        number.frame = CGRect(x: numberX, y: timeY, width: numberW, height: 20)
        let arrowW: CGFloat = 8
        let arrowH: CGFloat = 14
        let arrowX: CGFloat = kScreenWidth - 10 - arrowW
        let arrowY: CGFloat = 56
        arrow.frame = CGRect(x: arrowX, y: arrowY, width: arrowW, height: arrowH)
        line.frame = CGRect(x: 0, y: 126, width: kScreenWidth, height: 0.5)
        code.frame = CGRect(x: 10, y: 128, width: kScreenWidth - 20, height: 40)
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
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.image = UIImage(named: "CHRuiBaoHeader_newsDefaultIcon")
        icon.layer.borderColor = rgbSameColor(224).cgColor
        icon.layer.borderWidth = 0.5
        return icon
    }()
    
    fileprivate lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbSameColor(76)
        lbl.font = font15
        return lbl
    }()
    
    fileprivate lazy var price: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbSameColor(76)
        lbl.font = font12
        return lbl
    }()
    
    fileprivate lazy var time: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbSameColor(153)
        lbl.font = font14
        return lbl
    }()

    fileprivate lazy var number: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbSameColor(102)
        lbl.font = font13
        lbl.textAlignment = .right
        return lbl
    }()
    
    fileprivate lazy var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(named: "ExchangeRecordCellArrow")
        return arrow
    }()

    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(235)
        return line
    }()

    fileprivate lazy var code: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbSameColor(50)
        lbl.font = font15
        return lbl
    }()
}
