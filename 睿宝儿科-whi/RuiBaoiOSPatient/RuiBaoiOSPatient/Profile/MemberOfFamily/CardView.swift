
//
//  CardView.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/9.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class CardView: UIView {

    var model: MemberModel? {
        didSet{
            
            if model != nil {
                iconView.sd_setImage(with: URL(string: model!.iconUrlString), placeholderImage: UIImage(named: "DoctorPlacehoderMan"))
                nameLabel.text = model!.name
                sexAgeLabel.text = "\(model!.sex) \(model!.age)"
                relationshipLabelValue.text = model!.relationship
                phoneLabelValue.text = model!.phone
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        layer.cornerRadius = 12
        if kScreenWidth == 375 {
            layer.cornerRadius = 16
        } else if kScreenWidth == 414 {
            layer.cornerRadius = 20
        }
        clipsToBounds = true
        
        // 创建子控件
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(sexAgeLabel)
        addSubview(line)
        addSubview(relationshipLabelKey)
        addSubview(relationshipLabelValue)
        addSubview(phoneLabelKey)
        addSubview(phoneLabelValue)
        

        let iconWH: CGFloat = 120
        let iconX: CGFloat = (kMemberCarViewW - iconWH)/2
        let iconY: CGFloat = 35
        iconView.frame = CGRect(x: iconX, y: iconY, width: iconWH, height: iconWH)
        
        nameLabel.frame = CGRect(x: 0, y: iconView.frame.maxY + 10, width: kMemberCarViewW, height: 26)
        sexAgeLabel.frame = CGRect(x: 0, y: nameLabel.frame.maxY + 8, width: kMemberCarViewW, height: 16)
        
        let lineX: CGFloat = 20
        let lineY: CGFloat = sexAgeLabel.frame.maxY + 19
        let lineW: CGFloat = kMemberCarViewW - 2*lineX
        line.frame = CGRect(x: lineX, y: lineY, width: lineW, height: 0.5)
        
        let keyX: CGFloat = 22
        relationshipLabelKey.frame = CGRect(x: keyX, y: line.frame.maxY + 21, width: 44, height: 17)
        let relationshipLabelValueX = relationshipLabelKey.frame.maxX
        let relationshipLabelValueW = kMemberCarViewW - relationshipLabelValueX - keyX
        relationshipLabelValue.frame = CGRect(x: relationshipLabelValueX, y: line.frame.maxY + 20, width: relationshipLabelValueW, height: 19)
        
        phoneLabelKey.frame = CGRect(x: keyX, y: relationshipLabelKey.frame.maxY + 16, width: 58, height: 17)
        let phoneLabelValueX: CGFloat = phoneLabelKey.frame.maxX
        let phoneLabelValueW: CGFloat = kMemberCarViewW - phoneLabelValueX - keyX
        phoneLabelValue.frame = CGRect(x: phoneLabelValueX, y: relationshipLabelValue.frame.maxY + 15, width: phoneLabelValueW, height: 19)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 60.0
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFill
        return icon
    }()

    fileprivate lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font17
        lbl.textAlignment = .center
        return lbl
    }()
    
    fileprivate lazy var sexAgeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font13
        lbl.textAlignment = .center
        return lbl
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
    
    fileprivate lazy var relationshipLabelKey: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        lbl.text = kRelationship
        return lbl
    }()
    
    fileprivate lazy var relationshipLabelValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font16
        return lbl
    }()
    
    fileprivate lazy var phoneLabelKey: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        lbl.text = kPhoneNumber
        return lbl
    }()
    
    fileprivate lazy var phoneLabelValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font16
        return lbl
    }()
    
}
