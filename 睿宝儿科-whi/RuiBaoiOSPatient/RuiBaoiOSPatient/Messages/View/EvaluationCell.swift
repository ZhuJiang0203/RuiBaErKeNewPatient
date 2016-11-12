//
//  EvaluationCell.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/18.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let evaluationCellIdentifier = "evaluationCellIdentifier"

class EvaluationCell: UITableViewCell {
    
    var frameModel: EvaluationFrame? {
        didSet{
            if frameModel != nil {
                phoneLabel.frame = frameModel!.phoneFrame
                praiseDegreeIcon.frame = frameModel!.degreeFrame
                contentLabel.frame = frameModel!.contentFrame
                timeLabel.frame = frameModel!.timeFrame
                conTypeLabel.frame = frameModel!.typeFrame
                line.frame = frameModel!.lineFrame
                
                
                if frameModel!.model != nil {
                    let mdl = frameModel!.model!
                    phoneLabel.text = mdl.phoneNumber
                    praiseDegreeIcon.image = UIImage(named: "Star\(mdl.praiseDegree)")
                    contentLabel.text = mdl.content
                    // 行间距
                    let attributedString = NSMutableAttributedString(string: mdl.content )
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 6
                    attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
                    contentLabel.attributedText = attributedString
                    timeLabel.text = mdl.time
                    conTypeLabel.text = mdl.consultationType
                }
            }        
        }
    }

    class func setupEvaluationCell(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> EvaluationCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: evaluationCellIdentifier) as? EvaluationCell
        if cell == nil {
            cell = EvaluationCell(style: .default, reuseIdentifier: evaluationCellIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(phoneLabel)
        contentView.addSubview(praiseDegreeIcon)
        contentView.addSubview(contentLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(conTypeLabel)
        contentView.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var phoneLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = font13
        lbl.textColor = rgb50
        return lbl
    }()
    
    private lazy var praiseDegreeIcon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()

    private lazy var contentLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = font14
        lbl.textColor = rgb50
        lbl.numberOfLines = 0
        return lbl
    }()

    private lazy var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = font12
        lbl.textColor = rgb153
        return lbl
    }()

    private lazy var conTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = font12
        lbl.textColor = rgb153
        return lbl
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()

}
