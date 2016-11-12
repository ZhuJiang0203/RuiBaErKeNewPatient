//
//  RecordSMTZCell.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/15.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  生命体征 Cell

import UIKit

class RecordSMTZCell: UITableViewCell {

    var model: ShengMingTiZheng? {
        didSet{
            if model != nil {
                jiluTimeValue.text = model!.jiLuTime
                tiwenValue.text = model!.tiWen
                maiboBreathValue.text = model!.maiBoHuXi
                weightHeightValue.text = model!.weightHeight
                xueyangBaoheduValue.text = model!.xueYangBaoHeDu
                shousuoyaShuzhangyaValue.text = model!.shouSuoYaShuZhangYa
            }
        }
    }
    
    class func setupRecordSMTZCell(_ tableView: UITableView, indexPath: IndexPath) -> RecordSMTZCell {
        let cell = RecordSMTZCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加子控件
        contentView.addSubview(jiluTime)
        contentView.addSubview(jiluTimeValue)
        contentView.addSubview(line0)
        
        contentView.addSubview(tiwen)
        contentView.addSubview(tiwenValue)
        contentView.addSubview(line1)
        
        contentView.addSubview(maiboBreath)
        contentView.addSubview(maiboBreathValue)
        contentView.addSubview(line2)
        
        contentView.addSubview(weightHeight)
        contentView.addSubview(weightHeightValue)
        contentView.addSubview(line3)
        
        contentView.addSubview(xueyangBaohedu)
        contentView.addSubview(xueyangBaoheduValue)
        contentView.addSubview(line4)
        
        contentView.addSubview(shousuoyaShuzhangya)
        contentView.addSubview(shousuoyaShuzhangyaValue)
        
        
        
        
        
        
        let kMar: CGFloat = 15
        let cellW: CGFloat = 200
        let cellH: CGFloat = 40
        let valueX: CGFloat = kScreenWidth - kMar - cellW
        let lineH: CGFloat = 0.5
        
        jiluTime.frame = CGRect(x: kMar, y: 0, width: cellW, height: cellH)
        jiluTimeValue.frame = CGRect(x: valueX, y: 0, width: cellW, height: cellH)
        line0.frame = CGRect(x: 0, y: jiluTime.frame.maxY - lineH, width: kScreenWidth, height: lineH)
        
        tiwen.frame = CGRect(x: kMar, y: cellH, width: cellW, height: cellH)
        tiwenValue.frame = CGRect(x: valueX, y: cellH, width: cellW, height: cellH)
        line1.frame = CGRect(x: 0, y: tiwenValue.frame.maxY - lineH, width: kScreenWidth, height: lineH)
        
        maiboBreath.frame = CGRect(x: kMar, y: cellH*2, width: cellW, height: cellH)
        maiboBreathValue.frame = CGRect(x: valueX, y: cellH*2, width: cellW, height: cellH)
        line2.frame = CGRect(x: 0, y: maiboBreath.frame.maxY - lineH, width: kScreenWidth, height: lineH)
        
        weightHeight.frame = CGRect(x: kMar, y: cellH*3, width: cellW, height: cellH)
        weightHeightValue.frame = CGRect(x: valueX, y: cellH*3, width: cellW, height: cellH)
        line3.frame = CGRect(x: 0, y: weightHeight.frame.maxY - lineH, width: kScreenWidth, height: lineH)
        
        xueyangBaohedu.frame = CGRect(x: kMar, y: cellH*4, width: cellW, height: cellH)
        xueyangBaoheduValue.frame = CGRect(x: valueX, y: cellH*4, width: cellW, height: cellH)
        line4.frame = CGRect(x: 0, y: xueyangBaohedu.frame.maxY - lineH, width: kScreenWidth, height: lineH)
        
        shousuoyaShuzhangya.frame = CGRect(x: kMar, y: cellH*5, width: cellW, height: cellH)
        shousuoyaShuzhangyaValue.frame = CGRect(x: valueX, y: cellH*5, width: cellW, height: cellH)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /*************************** 就诊时间 *************************/
    
    fileprivate lazy var jiluTime: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        lbl.text = "\(kRecordTime)"
        return lbl
    }()
    
    fileprivate lazy var jiluTimeValue: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = font14
        lbl.textColor = rgb51
        return lbl
    }()
    
    fileprivate lazy var line0: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(231)
        return line
    }()
    
    
    
    
    /*************************** 体温 *************************/

    fileprivate lazy var tiwen: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        lbl.text = "\(kTemperature)"
        return lbl
    }()
    
    fileprivate lazy var tiwenValue: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = font14
        lbl.textColor = rgb51
        return lbl
    }()
    
    fileprivate lazy var line1: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(231)
        return line
    }()

    
    
    
    /*************************** 脉搏/呼吸 *************************/

    fileprivate lazy var maiboBreath: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        lbl.text = "\(kPulseBreathing)"
        return lbl
    }()
    
    fileprivate lazy var maiboBreathValue: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = font14
        lbl.textColor = rgb51
        return lbl
    }()
    
    fileprivate lazy var line2: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(231)
        return line
    }()

    
    
    
    
    /*************************** 体重/身高 *************************/

    fileprivate lazy var weightHeight: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        lbl.text = "\(kWeightHeight)"
        return lbl
    }()
    
    fileprivate lazy var weightHeightValue: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = font14
        lbl.textColor = rgb51
        return lbl
    }()
    
    fileprivate lazy var line3: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(231)
        return line
    }()

    
   
    
    
    /*************************** 血氧饱和度 *************************/

    fileprivate lazy var xueyangBaohedu: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        lbl.text = "\(kBloodOxygenSaturation)"
        return lbl
    }()
    
    fileprivate lazy var xueyangBaoheduValue: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = font14
        lbl.textColor = rgb51
        return lbl
    }()
    
    fileprivate lazy var line4: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(231)
        return line
    }()

    
    
    
    
    
    /*************************** 收缩压/舒张压 *************************/

    fileprivate lazy var shousuoyaShuzhangya: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        lbl.text = "\(kSystolicPressureDiastolicPressure)"
        return lbl
    }()
    
    fileprivate lazy var shousuoyaShuzhangyaValue: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = font14
        lbl.textColor = rgb51
        return lbl
    }()
}
