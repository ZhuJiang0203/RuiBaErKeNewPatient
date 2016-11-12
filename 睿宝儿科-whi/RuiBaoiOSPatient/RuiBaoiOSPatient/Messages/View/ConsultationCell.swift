//
//  MyConsultationCell.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let kConsultationCellMine = "ConsultationCellMine"

@objc
protocol ConsultationCellDelegate: NSObjectProtocol {
    @objc optional func backTextImageViewClicked(_ pictureStr: String)
    @objc optional func openShareArticle(_ url: String)
}

class ConsultationCell: UITableViewCell {
    
    weak var delegate: ConsultationCellDelegate?
    fileprivate var currentModel: ConslationModel?

    var frameModel: ConslationFrame? {
        didSet{
            
            if frameModel != nil {
                if let model = frameModel!.model {
                    currentModel = model
                    
                    if (model.UserType == "2" && (model.AssistantTip == "1" || model.AssistantTip == "3" || model.AssistantTip == "5" || model.AssistantTip == "7")) { // 咨询结束、随访结束
                        
                        consulatEndView.isHidden = false
                        icon.isHidden = true
                        backTextImageView.isHidden = true
                        
                        switch model.AssistantTip! {
                        case "1":
                            tipLabel.text = kNoAdmissionsTip
                        case "3":
                            tipLabel.text = kNoPaymentTip
                        case "5":
                            tipLabel.text = kTheInterrogationIsOver
                        case "7":
                            tipLabel.text = kTheFollowUpIsOver
                        default:
                            tipLabel.text = "Error"
                        }
                        timeLabel.text = "----  \(model.ConsultTime)  ----"
                        
                    } else { // 待接诊、已接诊，待付款、咨询中、随访中、随访结束
                        
                        consulatEndView.isHidden = true
                        icon.isHidden = false
                        backTextImageView.isHidden = false
                        
                        LLog(model.icon)
                        if model.UserType == "0" { // 患者
                            icon.sd_setImage(with: URL.init(string: model.icon), placeholderImage: UIImage.init(named: "IconPlacehoderGray60"))
                        } else if model.UserType == "1" { // 医生
                            let sex = defaults.string(forKey: kPatientSexKey) ?? ""
                            let placehoder = sex == "M" ? "DoctorPlacehoderMan" : "DoctorPlacehoderWoman"
                            let doctorIconString = defaults.string(forKey: kPatientIconURLStringKey) ?? ""
                            icon.sd_setImage(with: URL.init(string: doctorIconString), placeholderImage: UIImage.init(named: placehoder))
                        } else { // 医生助手
                            icon.image = UIImage(named: "DoctorAssistant")
                        }
                        
                        if model.UserType == "1" { // 我
                            backTextImageView.image = UIImage(named: kGroup)
                            timeBtn.titleLabel?.textAlignment = .right
                            ttLabel.textColor = UIColor.white
                            
                            // 分享模块
                            let txt = model.text ?? ""
                            if txt.hasPrefix("#^!#") {
                                let arrstr = (txt as NSString).substring(from: 4)
                                let arr = arrstr.components(separatedBy: "#^!#")
                                if arr.count == 4 {
                                    backTextImageView.image = UIImage(named: "ShareCombined")
                                }
                            }
                        } else if model.UserType == "0" { // 患者
                            backTextImageView.image = UIImage(named: "Group-1")
                            timeBtn.titleLabel?.textAlignment = .left
                            ttLabel.textColor = rgb50
                        } else { // 医生助手
                            backTextImageView.image = UIImage(named: kGroup)
                            timeBtn.titleLabel?.textAlignment = .right
                            ttLabel.textColor = UIColor.white
                        }
                        
                        LLog(model.text?.characters.count)
                        
                        ttLabel.isHidden = true
                        pictureView.isHidden = true
                        voiceBtn.isHidden = true
                        
                        shareTtl.isHidden = true
                        shareIcon.isHidden = true
                        shareContent.isHidden = true
                        if model.text != nil { // 文字
                            
                            let txt = model.text ?? ""
                            if txt.hasPrefix("#^!#") {
                                shareTtl.isHidden = false
                                shareIcon.isHidden = false
                                shareContent.isHidden = false
                                
                                let arrstr = (txt as NSString).substring(from: 4)
                                let arr = arrstr.components(separatedBy: "#^!#")
                                if arr.count == 4 {
                                    let tt = arr[0]
                                    let content = arr[1]
                                    let iconid = arr[2]
                                    let urlstr = arr[3]
                                    LLog(urlstr)
                                    shareTtl.text = tt
                                    shareContent.text = content
                                    let shareIconUrl = kBaseUrlString + "headFiles/\(iconid)/ran.jpg"
                                    shareIcon.sd_setImage(with: URL.init(string: shareIconUrl), placeholderImage: UIImage.init(named: "wenzhangtu"))
                                    shareTtl.frame = (frameModel?.shareTtlFrame)!
                                    shareContent.frame = (frameModel?.shareContentFrame)!
                                    shareIcon.frame = (frameModel?.shareIconFrame)!
                                } else {
                                    ttLabel.frame = (frameModel?.textFrame)!
                                    ttLabel.isHidden = false
                                    ttLabel.text = kPlaceText
                                }
                            } else {
                                let attributedString = NSMutableAttributedString(string: model.text ?? kPlaceText)
                                // 行间距
                                let paragraphStyle = NSMutableParagraphStyle()
                                paragraphStyle.lineSpacing = kRowMargin
                                attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
                                ttLabel.attributedText = attributedString
                                
                                ttLabel.frame = (frameModel?.textFrame)!
                                
                                ttLabel.isHidden = false
                            }
                        } else if model.pictureString != nil { // 图片
                            if model.pictureString != nil {
                                pictureView.sd_setImage(with: URL(string: model.pictureString!), placeholderImage: UIImage(named: "wenzhangtu"))
                            }
                            
                            pictureView.frame = (frameModel?.pictureFrame) ?? CGRect(x: 0, y: 0, width: 80, height: 150)
                            LLog(pictureView.frame)
                            
                            pictureView.isHidden = false
                            
                            // 图片上的蒙版
                            pictureMasking.frame = pictureView.bounds
                            if model.UserType == "1" { // 我
                                pictureMasking.image = UIImage(named: "pictureMaskingMine")
                            } else {
                                pictureMasking.image = UIImage(named: "pictureMaskingOther")
                            }
                        } else if model.voicePath != nil { // 语音
                            
                            voiceBtn.frame = (frameModel?.yuyinFrame)!
                            let tt = "\(model.voiceDuration)" + "''"
                            voiceBtn.setTitle(tt, for: .normal)
                            
                            voiceBtn.isHidden = false
                        }
                        
                        
                        timeBtn.setTitle(model.handerTime, for: .normal)
                        
                        icon.frame = (frameModel?.iconFrame)!
                        backTextImageView.frame = (frameModel?.textBackFrame)!
                    }
                }
            }
        }
    }
    
    class func setupMyConsultationCell(_ tableView: UITableView) -> ConsultationCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kConsultationCellMine) as? ConsultationCell
        if cell == nil {
            cell = ConsultationCell(style: UITableViewCellStyle.default, reuseIdentifier: kConsultationCellMine)
            cell!.selectionStyle = UITableViewCellSelectionStyle.none
            cell!.backgroundColor = UIColor.clear
        }
        return cell!
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(icon)
        contentView.addSubview(backTextImageView)
        backTextImageView.addSubview(ttLabel)
        backTextImageView.addSubview(pictureView)
        pictureView.addSubview(pictureMasking)
        backTextImageView.addSubview(voiceBtn)
        
        backTextImageView.addSubview(shareTtl)
        backTextImageView.addSubview(shareContent)
        backTextImageView.addSubview(shareIcon)
        
        contentView.addSubview(consulatEndView)
        consulatEndView.addSubview(tipLabel)
        consulatEndView.addSubview(timeLabel)
        
        consulatEndView.frame = CGRect(x: 0, y: kMargin, width: kScreenWidth, height: 70)
        let tipW: CGFloat = 260
        let tipX = (kScreenWidth - tipW)/2
        tipLabel.frame = CGRect(x: tipX, y: 0, width: tipW, height: 30)
        timeLabel.frame = CGRect(x: 0, y: 53, width: kScreenWidth, height: 17)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = UIViewContentMode.scaleAspectFill
        icon.layer.cornerRadius = CGFloat(45)/2
        icon.clipsToBounds = true
        // 医生助手头像（暂时是：测试数据）
        icon.backgroundColor = UIColor(patternImage: UIImage(named: "DoctorAssistant")!)
        return icon
    }()

    fileprivate lazy var backTextImageView: UIImageView = {
        let back = UIImageView()
        back.isUserInteractionEnabled = true
        return back
    }()
    
    fileprivate lazy var pictureView: UIImageView = {
        let img = UIImageView()
        img.contentMode = UIViewContentMode.scaleAspectFill
        img.clipsToBounds = true
        img.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConsultationCell.tapPictureView))
        img.addGestureRecognizer(tap)
        return img
    }()
    
    fileprivate lazy var pictureMasking: UIImageView = {
        let masking = UIImageView()
        return masking
    }()

    
    func tapPictureView() {
        LLog(currentModel?.pictureString)
        if pictureView.isHidden == false && currentModel != nil && currentModel!.pictureString != nil {
            delegate?.backTextImageViewClicked?(currentModel!.pictureString!)
        }
    }
    
    fileprivate lazy var voiceBtn: VoiceButton = {
        let btn = VoiceButton()
        btn.addTarget(self, action: #selector(ConsultationCell.startPlaying(_:)), for: .touchUpInside)
        return btn
    }()
    
    func startPlaying(_ btn: VoiceButton) {
        
        VoicePlayTool.playerWithMessage(currentModel!.message!, superView: btn)
    }
    
    fileprivate lazy var ttLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = font15
        return lbl
    }()
    
    fileprivate lazy var timeBtn: TimeButton = {
        let btn = TimeButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        btn.setTitleColor(rgb153, for: .normal)
        return btn
    }()
    
    // 分享标题
    fileprivate lazy var shareTtl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = rgb50
        lbl.font = font15
        lbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConsultationCell.toOpenShareArticle))
        lbl.addGestureRecognizer(tap)
        return lbl
    }()
    
    func toOpenShareArticle() {
        let txt = currentModel?.text ?? ""
        
        if txt.hasPrefix("#^!#") {
            let arrstr = (txt as NSString).substring(from: 4)
            let arr = arrstr.components(separatedBy: "#^!#")
            if arr.count == 4 {
                let urlstr = arr[3]
                LLog(urlstr)
                delegate?.openShareArticle?(urlstr)
            }
        }
    }
    
    // 分享图标
    fileprivate lazy var shareIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = UIViewContentMode.scaleAspectFill
        icon.clipsToBounds = true
        icon.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConsultationCell.toOpenShareArticle))
        icon.addGestureRecognizer(tap)
        icon.image = UIImage(named: "wenzhangtu")
        return icon
    }()
    
    // 分享详情
    fileprivate lazy var shareContent: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb153
        lbl.numberOfLines = 0
        lbl.font = font12
        lbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConsultationCell.toOpenShareArticle))
        lbl.addGestureRecognizer(tap)
        return lbl
    }()
    
    fileprivate lazy var consulatEndView: UIView = {
        let vw = UIView()
        return vw
    }()

    fileprivate lazy var tipLabel: UILabel = {
        let lbl = UILabel()
        lbl.layer.cornerRadius = 2.5
        lbl.clipsToBounds = true
        lbl.backgroundColor = rgbColor(157, g: 165, b: 182)
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.font = font12
        return lbl
    }()

    fileprivate lazy var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = rgb153
        lbl.font = font12
        return lbl
    }()

}
