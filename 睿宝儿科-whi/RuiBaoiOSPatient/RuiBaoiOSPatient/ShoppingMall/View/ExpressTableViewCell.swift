//
//  ExpressTableViewCell.swift
//  querendingdan
//
//  Created by whj on 16/6/14.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let kExpressTableViewCellIdentifier = "kExpressTableViewCellIdentifier"

@objc
protocol ExpressTableViewCellDelegate: NSObjectProtocol {
    @objc optional func changeButtonClicked(_ cell: ExpressTableViewCell)
    @objc optional func deleteButtonClicked(_ cell: ExpressTableViewCell)
}

class ExpressTableViewCell: UITableViewCell {
    
    weak var delegate: ExpressTableViewCellDelegate?
    var model: ExpressModel? {
        didSet{
            if model != nil {
                if model!.selected == true {
                    icon.image = UIImage(named: "ExpressCellIconSelected")
                } else {
                    icon.image = UIImage(named: "ExpressCellIcon")
                }
                
                nameLabel.text = model!.name
                phoneLabel.text = model!.phone
                pccLabel.text = model!.provincialCityCounty
                addressLabel.text = model!.specificAddress
            }
        
        }
    }
    
    class func setupExpressTableViewCell(_ tableView: UITableView, indexPath: IndexPath) -> ExpressTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kExpressTableViewCellIdentifier) as? ExpressTableViewCell
        if cell == nil {
            cell = ExpressTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: kExpressTableViewCellIdentifier)
            cell!.selectionStyle = UITableViewCellSelectionStyle.none
            cell!.backgroundColor = UIColor.clear
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加子控件
        contentView.addSubview(backView)
        contentView.addSubview(topView)
        topView.addSubview(icon)
        topView.addSubview(nameLabel)
        topView.addSubview(phoneLabel)
        topView.addSubview(pccLabel)
        topView.addSubview(addressLabel)
        contentView.addSubview(changeBtn)
        contentView.addSubview(deleteBtn)
        contentView.addSubview(levelLine)
        contentView.addSubview(verticalLine)
        
        backView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 120)
        let topViewH: CGFloat = 80
        topView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: topViewH)
        let iconWH: CGFloat = 20
        let iconY = (topViewH - iconWH)/2
        icon.frame = CGRect(x: kMargin, y: iconY, width: iconWH, height: iconWH)
        let nameX = icon.frame.maxX + kMargin
        let lblH: CGFloat = 18
        nameLabel.frame = CGRect(x: nameX, y: kMargin, width: 200, height: lblH)
        let phoneW: CGFloat = 150
        let phoneX: CGFloat = kScreenWidth - kMargin - phoneW
        phoneLabel.frame = CGRect(x: phoneX, y: kMargin, width: phoneW, height: lblH)
        let pccLabelW = kScreenWidth - kMargin - nameX
        pccLabel.frame = CGRect(x: nameX, y: nameLabel.frame.maxY + 6, width: pccLabelW, height: lblH)
        addressLabel.frame = CGRect(x: nameX, y: pccLabel.frame.maxY, width: pccLabelW, height: lblH)
        let changeBtnY = topView.frame.maxY
        let changeBtnW = kScreenWidth/2
        let changeBtnH: CGFloat = 40
        changeBtn.frame = CGRect(x: 0, y: changeBtnY, width: changeBtnW, height: changeBtnH)
        deleteBtn.frame = CGRect(x: changeBtnW, y: changeBtnY, width: changeBtnW, height: changeBtnH)
        
        levelLine.frame = CGRect(x: 0, y: 80, width: kScreenWidth, height: 0.5)
        verticalLine.frame = CGRect(x: kScreenWidth/2, y: 80, width: 0.5, height: changeBtnH)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    
    fileprivate lazy var topView: UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor.white
        return vw
    }()

    fileprivate lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "ExpressCellIcon")
        return icon
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb50
        lbl.font = font13
        return lbl
    }()
    
    fileprivate lazy var phoneLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb50
        lbl.font = font13
        lbl.textAlignment = .right
        return lbl
    }()
    
    fileprivate lazy var pccLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb50
        lbl.font = font13
        return lbl
    }()
    
    fileprivate lazy var addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb50
        lbl.font = font13
        return lbl
    }()
    
    fileprivate lazy var changeBtn: ChangeDeleteButton = {
        let btn = ChangeDeleteButton()
        btn.setTitle("修改", for: .normal)
        btn.setImage(UIImage(named: "ChangeIcon"), for: .normal)
        btn.addTarget(self, action: #selector(ExpressTableViewCell.changeBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    func changeBtnClicked() {
        delegate?.changeButtonClicked?(self)
    }
    
    fileprivate lazy var deleteBtn: ChangeDeleteButton = {
        let btn = ChangeDeleteButton()
        btn.setTitle("删除", for: .normal)
        btn.setImage(UIImage(named: "DeleteIcon"), for: .normal)
        btn.addTarget(self, action: #selector(ExpressTableViewCell.deleteBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    func deleteBtnClicked() {
        delegate?.deleteButtonClicked?(self)
    }
    
    fileprivate lazy var levelLine: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
    
    fileprivate lazy var verticalLine: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
}
