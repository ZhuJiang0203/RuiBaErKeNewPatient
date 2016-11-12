//
//  ArticleListCell.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let ArticleListCellIdentifier = "HotConsultingCellIdentifier"

class ArticleListCell: UITableViewCell {

    private var titleW: CGFloat = 0.0
    
    var model: Article? {
        didSet{
            if model != nil {
                
                let url = "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1475906605&di=583b3c1d42e65275347753d5cc817832&src=http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1308/16/c0/24549225_1376645703600.jpg" //CHGetPicUrl + imageID + "/photo.jpg"
                iconView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "picturePlacehoder"))
                
                let titleTxt = model!.title 
                // 行间距
                let spacing: CGFloat = 3.0
                let attributedString = NSMutableAttributedString(string: titleTxt)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = spacing
                attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
                titleLabel.attributedText = attributedString
                
                // 根据内容确定titleLabel的最终高度
                let titleH: CGFloat = titleTxt.calculateTheHeightOfTheString(font16, width: titleW, margin: spacing, maxRow: 0)
                titleLabel.frame.size.height = min(titleH, 53)
                
                otherLabel.text = "\(model!.author) \(model!.department)"
            }
        }
    }
    
    class func setupArticleListCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> ArticleListCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ArticleListCellIdentifier) as? ArticleListCell
        if cell == nil {
            cell = ArticleListCell(style: .default, reuseIdentifier: ArticleListCellIdentifier)
            cell!.selectionStyle = .none
        }
        return cell!
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(otherLabel)
        contentView.addSubview(line)
        
        let iconW: CGFloat = 85
        let iconH: CGFloat = 70
        let cellH: CGFloat = 102
        let marginX: CGFloat = 15
        let marginY: CGFloat = (cellH - iconH)/2
        iconView.frame = CGRect(x: marginX, y: marginY, width: iconW, height: iconH)
        
        let titleX: CGFloat = iconView.frame.maxX + 10
        titleW = kScreenWidth - titleX - marginX
        titleLabel.frame = CGRect(x: titleX, y: marginY, width: titleW, height: 22)
        
        let otherH: CGFloat = 17
        let otherY: CGFloat = iconView.frame.maxY - otherH
        otherLabel.frame = CGRect(x: titleX, y: otherY, width: titleW, height: otherH)
        
        line.frame = CGRect(x: marginX, y: cellH - 0.5, width: kScreenWidth - marginX*2, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        return icon
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font16
        lbl.numberOfLines = 0
        return lbl
    }()
    
    fileprivate lazy var otherLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbColor(150, g: 159, b: 169)
        lbl.font = font12
        return lbl
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
}
