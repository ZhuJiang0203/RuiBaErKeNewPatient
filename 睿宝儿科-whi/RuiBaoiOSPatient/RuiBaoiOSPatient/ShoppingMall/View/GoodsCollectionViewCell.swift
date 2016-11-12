//
//  GoodsCollectionViewCell.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/29.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit
//import SDWebImage

private let GoodsCollectionViewCellReuseIdentifier = "GoodsCollectionViewCellReuseIdentifier"

class GoodsCollectionViewCell: UICollectionViewCell {
    
    var model: Goods? {
        didSet{
            if model != nil {
               
                nameLabel.text = model!.goodsName
                iconView.sd_setImage(with: URL(string: model!.goodsImageString), placeholderImage: UIImage(named: "RuiBaoPlacehoderIcon"))
                
                if model!.stock == 0 {
                    chbValue.text = "已售完"
                    chbValue.backgroundColor = rgbSameColor(216)
                } else {
                    chbValue.text = "¥\(model!.price)"
                    chbValue.backgroundColor = appMainColor
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        layer.cornerRadius = 2.5
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        
        contentView.addSubview(topView)
        topView.addSubview(nameLabel)
        contentView.addSubview(iconView)
        contentView.addSubview(bottomView)
        bottomView.addSubview(chbKey)
        bottomView.addSubview(chbValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var topView: UIView = {
        let vw = UIView()
        return vw
    }()

    fileprivate lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbSameColor(76)
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        return lbl
    }()

    fileprivate lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        return icon
    }()
    
    fileprivate lazy var bottomView: UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor.white
        return vw
    }()

    /// 彩虹币
    fileprivate lazy var chbKey: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb153
        lbl.font = font12
        lbl.text = "\(kRainbowCoin)"
        return lbl
    }()

    /// ¥ 1000
    fileprivate lazy var chbValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.font = font11
        lbl.textAlignment = .center
        lbl.backgroundColor = appMainColor
        lbl.layer.cornerRadius = 2.5
        lbl.clipsToBounds = true
        return lbl
    }()
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 标题
        let topViewH: CGFloat = 35
        topView.frame = CGRect(x: 0, y: 0, width: frame.width, height: topViewH)
        nameLabel.frame = CGRect(x: 10, y: 0, width: frame.width - 20, height: topViewH)

        // 底部
        let bottomViewH: CGFloat = 42
        let bottomViewY = frame.height - bottomViewH
        bottomView.frame = CGRect(x: 0, y: bottomViewY, width: frame.width, height: bottomViewH)
        chbKey.frame = CGRect(x: 10, y: 0, width: 200, height: bottomViewH)
        let chbValueW: CGFloat = 50
        let chbValueH: CGFloat = 24
        let chbValueX: CGFloat = frame.width - 10 - chbValueW
        let chbValueY: CGFloat = (bottomViewH - chbValueH)/2
        chbValue.frame = CGRect(x: chbValueX, y: chbValueY, width: chbValueW, height: chbValueH)
        
        // 图片
        let iconViewH = frame.height - topViewH
        iconView.frame = CGRect(x: 0, y: topViewH, width: frame.width, height: iconViewH)
    }
}
