//
//  DoctorHomePageController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/18.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  医生主页

import UIKit

class DoctorHomePageController: BaseViewController {

    private var tableView: UITableView?
    
    fileprivate var evaluationFrames = [EvaluationFrame]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = kDoctorHomePage

        view.backgroundColor = rgb244
        
        for i in 0..<3 {
            let model = Evaluation()
            model.evaluationID = "\(i)"
            model.phoneNumber = "153****3063"
            model.praiseDegree = "\(i + 2)"
            switch i {
            case 0:
                model.content = "的司法考试的发生地方发达打算发多少，发打发斯蒂芬，发大水发的说法都是反大法师打发但是发送到发送到发大水发的说法都是发达打算发多少发大水发的说法都是。"
            case 1:
                model.content = "说法都是发达打算发多少发大水发的说法都是。"
            default:
                model.content = "发大水发的说法都是。"
            }
            model.time = "2016年09月18日"
            model.consultationType = "图文咨询"
            let frameModel = EvaluationFrame()
            frameModel.model = model
            evaluationFrames.append(frameModel)
        }
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView?.separatorStyle = .none
        tableView!.tableHeaderView = setupTableHeaderView()
        view.addSubview(tableView!)
    }
    
    private func setupTableHeaderView() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 300))
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        header.backgroundColor = UIColor.white
        headerView.addSubview(header)
        
        let topViewH: CGFloat = 116
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 116))
        topView.backgroundColor = rgbColor(249, g: 117, b: 140)
        header.addSubview(topView)
        
        let iconViewWH: CGFloat = 130
        let iconViewX: CGFloat = (kScreenWidth - iconViewWH)/2
        let iconViewY: CGFloat = topViewH - iconViewWH/2
        let iconView = UIView(frame: CGRect(x: iconViewX, y: iconViewY, width: iconViewWH, height: iconViewWH))
        iconView.backgroundColor = UIColor.white
        iconView.layer.cornerRadius = iconViewWH/2
        iconView.clipsToBounds = true
        header.addSubview(iconView)
        
        let iconWH: CGFloat = 120
        let icon = UIImageView(frame: CGRect(x: 5, y: 5, width: iconWH, height: iconWH))
        icon.layer.cornerRadius = iconWH/2
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFill
        icon.sd_setImage(with: URL.init(string: ""), placeholderImage: UIImage(named: "DoctorPlacehoderMan"))
        iconView.addSubview(icon)
        
        let name = UILabel(frame: CGRect(x: 15, y: iconView.frame.maxY + 9, width: kScreenWidth - 30, height: 20))
        name.textColor = rgb51
        name.font = font17
        name.textAlignment = .center
        name.text = "John Fred"
        header.addSubview(name)
        
        // 职位
        let position = UILabel(frame: CGRect(x: 15, y: name.frame.maxY + 10, width: kScreenWidth - 30, height: 16))
        position.textColor = rgb102
        position.font = font13
        position.textAlignment = .center
        position.text = "主任医师"
        header.addSubview(position)
        
        let followW: CGFloat = 120
        let followH: CGFloat = 44
        let followX: CGFloat = (kScreenWidth - followW)/2
        let followY: CGFloat = position.frame.maxY + 20
        let follow = UIButton(frame: CGRect(x: followX, y: followY, width: followW, height: followH))
        follow.backgroundColor = rgbColor(142, g: 205, b: 248)
        follow.setTitle(kFollow, for: .normal)
        follow.setTitleColor(UIColor.white, for: .normal)
        follow.titleLabel?.font = font16
        follow.layer.cornerRadius = followH/2
        follow.clipsToBounds = true
        follow.addTarget(self, action: #selector(DoctorHomePageController.followClicked), for: .touchUpInside)
        header.addSubview(follow)
        
        let line = UIView(frame: CGRect(x: 0, y: follow.frame.maxY + 29, width: kScreenWidth, height: 0.5))
        line.backgroundColor = rgbSameColor(237)
        header.addSubview(line)
        
        let hospital = UILabel(frame: CGRect(x: 0, y: line.frame.maxY, width: kScreenWidth, height: 60))
        hospital.textColor = rgb51
        hospital.font = font14
        hospital.textAlignment = .center
        hospital.text = "\(kPracticePoint)北京协和医院"
        header.addSubview(hospital)
        
        // 预约挂号
        let titleH: CGFloat = 20
        let iconWOrH: CGFloat = 45
        var iconX: CGFloat = 20
        if kScreenWidth == 375 {
            iconX = 30
        } else if kScreenWidth == 414 {
            iconX = 40
        }
        let iconY: CGFloat = 25
        
        let yyghzxzxW: CGFloat = iconX*2 + iconWOrH
        let yyghzxzxH: CGFloat = 70
        let yyghzxzxY: CGFloat = topView.frame.maxY + 14
        let yuyueguahao = UIView(frame: CGRect(x: 0, y: yyghzxzxY, width: yyghzxzxW, height: yyghzxzxH))
        header.addSubview(yuyueguahao)
        
        let yyghTap = UITapGestureRecognizer(target: self, action: #selector(DoctorHomePageController.yyghTapClicked))
        yuyueguahao.addGestureRecognizer(yyghTap)
        
        let yyghTitle = UILabel(frame: CGRect(x: 0, y: 0, width: yyghzxzxW, height: titleH))
        yyghTitle.textColor = rgb51
        yyghTitle.font = font15
        yyghTitle.textAlignment = .center
        yyghTitle.text = kMakeAnAppointment
        yyghTitle.isUserInteractionEnabled = true
        yuyueguahao.addSubview(yyghTitle)
        
        let yyghIcon = UIImageView(frame: CGRect(x: iconX, y: iconY, width: iconWOrH, height: iconWOrH))
        yyghIcon.image = UIImage(named: "CHDoctorHomePage_guahaoIcon_1")
        yyghIcon.isUserInteractionEnabled = true
        yuyueguahao.addSubview(yyghIcon)
        
        // 在线咨询
        let zaixianzixunX = kScreenWidth - yyghzxzxW
        let zaixianzixun = UIView(frame: CGRect(x: zaixianzixunX, y: yyghzxzxY, width: yyghzxzxW, height: yyghzxzxH))
        header.addSubview(zaixianzixun)
        
        let zxzxTap = UITapGestureRecognizer(target: self, action: #selector(DoctorHomePageController.zxzxTapClicked))
        yuyueguahao.addGestureRecognizer(zxzxTap)
        
        let zxzxTitle = UILabel(frame: CGRect(x: 0, y: 0, width: yyghzxzxW, height: titleH))
        zxzxTitle.textColor = rgb51
        zxzxTitle.font = font15
        zxzxTitle.textAlignment = .center
        zxzxTitle.text = kOnlineConsultation
        zxzxTitle.isUserInteractionEnabled = true
        zaixianzixun.addSubview(zxzxTitle)
        
        let zxzxIcon = UIImageView(frame: CGRect(x: iconX, y: iconY, width: iconWOrH, height: iconWOrH))
        zxzxIcon.image = UIImage(named: "CHDoctorHomePage_zixunIcon_1")
        zxzxIcon.isUserInteractionEnabled = true
        zaixianzixun.addSubview(zxzxIcon)
        
        // 确定header最终高度
        header.frame.size.height = hospital.frame.maxY
        
        
        
        /// 擅长、简介
        let goodsIntroduct = UIView(frame: CGRect(x: 0, y: header.frame.maxY + 10, width: kScreenWidth, height: 100))
        goodsIntroduct.backgroundColor = UIColor.white
        headerView.addSubview(goodsIntroduct)
        
        let goods = UILabel(frame: CGRect(x: 15, y: 21, width: kScreenWidth - 30, height: 17))
        goods.textColor = rgb51
        let goodsTxt = "\(kSpecialty)消化系统的早期诊断，胃肠功能疾病"
        let mutableString = NSMutableAttributedString(string: goodsTxt)
        mutableString.addAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14)], range: NSMakeRange(0, 3))
        mutableString.addAttributes([NSFontAttributeName : font14], range: NSMakeRange(3, goodsTxt.characters.count - 3))
        goods.attributedText = mutableString
        goodsIntroduct.addSubview(goods)
        
        let introductTxt = "\(kBriefIntroduction)John医生是个很年轻帅气的医生，为人正直诚恳，是个医术界不可多得的天才，对待画着，非常有耐心，是个不折不扣的好医生。"
        let introductionH = introductTxt.calculateTheHeightOfTheString(UIFont.boldSystemFont(ofSize: 14), width: kScreenWidth - 30, margin: 6, maxRow: 0)
        let introduction = UILabel(frame: CGRect(x: 15, y: goods.frame.maxY + 20, width: kScreenWidth - 30, height: introductionH))
        // 字体
        let mutableIntroductString = NSMutableAttributedString(string: introductTxt)
        mutableIntroductString.addAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14)], range: NSMakeRange(0, 3))
        mutableIntroductString.addAttributes([NSFontAttributeName : font14], range: NSMakeRange(3, introductTxt.characters.count - 3))
        introduction.attributedText = mutableIntroductString
        // 行间距
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        mutableIntroductString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, mutableIntroductString.length))
        introduction.attributedText = mutableIntroductString
        
        introduction.numberOfLines = 0
        goodsIntroduct.addSubview(introduction)
        
        // 确定goodsIntroduct的最终高度
        goodsIntroduct.frame.size.height = introduction.frame.maxY + 20
        
        // 确定headerView的最终高度
        headerView.frame.size.height = goodsIntroduct.frame.maxY + 10

        return headerView
    }
    
    /**
     关注
     */
    @objc private func followClicked() {
    
    }
    
    /**
     预约挂号
     */
    @objc private func yyghTapClicked() {
    
    }
    
    /**
     在线咨询
     */
    @objc private func zxzxTapClicked() {
        
    }
}

extension DoctorHomePageController: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evaluationFrames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EvaluationCell.setupEvaluationCell(tableView: tableView, cellForRowAtIndexPath: indexPath)
        cell.frameModel = evaluationFrames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return evaluationFrames[indexPath.row].cellH
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        sectionHeader.backgroundColor = UIColor.white
        
         /// 患者评论（*人）
        let evaluationTotalViewH: CGFloat = 45
        let evaluationTotalView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: evaluationTotalViewH))
        evaluationTotalView.backgroundColor = UIColor.white
        sectionHeader.addSubview(evaluationTotalView)
        
        let total = UILabel(frame: CGRect(x: 15, y: 0, width: 300, height: evaluationTotalViewH))
        total.text = "\(kPatientEvaluation)112\(kPeople)"
        total.textColor = rgb102
        total.font = font14
        evaluationTotalView.addSubview(total)
        
        let line = UIView(frame: CGRect(x: 0, y: evaluationTotalViewH - 0.5, width: kScreenWidth, height: 0.5))
        line.backgroundColor = rgbSameColor(237)
        evaluationTotalView.addSubview(line)
        
        return sectionHeader
    }
}
