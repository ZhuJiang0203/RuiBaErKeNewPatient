
//
//  RecordListCell.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/7/9.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  病历详情的cell

import UIKit


class RecordListCell: UITableViewCell {
    
    // 过敏列表
    var model1: GuoMinLieBiao? {
        didSet{
            if model1 != nil {
                key.text = model1!.guoMinYuan
                value.text = model1!.guoMinChengDu
            }
        }
    }
    
    // 疾病列表
    var model2: JiBingLieBiao? {
        didSet{
            if model2 != nil {
                key.text = model2!.jiBingName
                value.text = model2!.startTime
            }
        }
    }
    
    // 用药列表
    var model3: YongYaoLieBiao? {
        didSet{
            if model3 != nil {
                key.text = model3!.yongYaoName
                value.text = model3!.endTime
            }
        }
    }
    
    // 疫苗列表
    var model4: YiMiaoLieBiao? {
        didSet{
            if model4 != nil {
                key.text = model4!.yiMiaoName
                value.text = model4!.yiMiaoTime
            }
        }
    }
    
    // 实验室检查
    var model5: ShiYanShiJianCha? {
        didSet{
            if model5 != nil {
                key.text = model5!.jianChaName
                value.text = model5!.jianChaTime
            }
        }
    }
    
    // 就诊记录
    var model6: JiuZhenJiLu? {
        didSet{
            if model6 != nil {
                key.text = model6!.zhenDuan
                value.text = model6!.jiuZhenTime
            }
        }
    }
    
    
    class func setupRecordListCell(_ tableView: UITableView, indexPath: IndexPath) -> RecordListCell {
        let cell = RecordListCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
//        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加子控件
        contentView.addSubview(key)
        contentView.addSubview(value)
        contentView.addSubview(arrow)
        contentView.addSubview(line)

        let keyValueH: CGFloat = 40

        let valueW: CGFloat = 125
        let valueX = kScreenWidth - 25 - valueW
        value.frame = CGRect(x: valueX, y: 0, width: valueW, height: keyValueH)
//        value.backgroundColor = UIColor.blueColor()
        
        let kMar: CGFloat = 15
        let keyValueW = value.frame.minX - kMar
        key.frame = CGRect(x: kMar, y: 0, width: keyValueW, height: keyValueH)
//        key.backgroundColor = UIColor.redColor()

        arrow.center = CGPoint(x: kScreenWidth - 18, y: keyValueH/2)
        
        line.frame = CGRect(x: 0, y: keyValueH - 0.5, width: kScreenWidth, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    fileprivate lazy var key: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        return lbl
    }()
    
    fileprivate lazy var value: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = font14
        lbl.textColor = rgb51
        return lbl
    }()
    
    fileprivate lazy var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(named: "ArrowGray610")
        arrow.sizeToFit()
        return arrow
    }()

    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(231)
        return line
    }()
}
