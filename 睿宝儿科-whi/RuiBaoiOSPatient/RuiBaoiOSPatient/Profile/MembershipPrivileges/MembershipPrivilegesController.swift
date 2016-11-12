//
//  MembershipPrivilegesController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/1.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  会员特权

import UIKit

class MembershipPrivilegesController: BaseViewController {

    var mainScrollView: UIScrollView!
    
    // 头像
    var icon: UIImageView!
    // 会员图标
    var memberIcon: UIImageView!
    // 姓名
    var nameLabel: UILabel!
    // 详情
    var detailLabel: VerticalAlignmentLabel!
    // 会员充值按钮
    var memberRecharge: UIButton!
    // 提示
    var tipLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = kMembershipPrivileges
        

        // mainScrollView
        setupMainScrollView()
        
        // 顶部
        setupTopView()
        
        setupMembershipPrivilegesView(144, index: 0)
        setupMembershipPrivilegesView(374, index: 1)
        setupMembershipPrivilegesView(604, index: 2)
    }
    
    // MARK:- mainScrollView
    private func setupMainScrollView() {
        mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        mainScrollView.alwaysBounceVertical = true
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.backgroundColor = UIColor.white
        view.addSubview(mainScrollView)
    }
    
    // MARK:- 顶部
    private func setupTopView() {
        
        let topH: CGFloat = 122
        let top = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: topH))
        mainScrollView.addSubview(top)
        
        let iconWH: CGFloat = 40
        let marginX: CGFloat = 17
        icon = UIImageView(frame: CGRect(x: marginX, y: 26, width: iconWH, height: iconWH))
        icon.image = UIImage(named: "CHDefaultAvatar_45Icon_0")
        icon.layer.cornerRadius = iconWH/2
        icon.clipsToBounds = true
        let iconImage = SaveImage.getImageWithImageName(kUserIconUIImageKey)
        icon.image = (iconImage != nil) ? iconImage : UIImage(named: "IconPlacehoderFenWhite")
        top.addSubview(icon)
        
        let memberIconX: CGFloat = icon.frame.maxX + 13
        memberIcon = UIImageView(frame: CGRect(x: memberIconX, y: 30, width: 16, height: 12))
        memberIcon.image = UIImage(named: "memberIconString")
        top.addSubview(memberIcon)
        
        nameLabel = UILabel(frame: CGRect(x: 94, y: 25, width: 200, height: 22))
        nameLabel.text = defaults.string(forKey: kPatientNameKey) ?? ""
        nameLabel.textColor = rgbSameColor(102)
        nameLabel.font = font16
        top.addSubview(nameLabel)
        
        
        /// 会员充值 按钮的宽、高、x坐标
        let btnW: CGFloat = 67
        let btnH: CGFloat = 24
        let btnX: CGFloat = kScreenWidth - 10 - btnW
        
        /// 提示的y坐标
        let tipLabelY: CGFloat = 88


        
        let detailLabelW: CGFloat = btnX - kMargin - memberIconX
        let detailLabelY: CGFloat = 47
        let detailLabelH: CGFloat = tipLabelY - detailLabelY
        detailLabel = VerticalAlignmentLabel(frame: CGRect(x: memberIconX, y: 47, width: detailLabelW, height: detailLabelH))
        detailLabel.text = "玫瑰金会员 余额88.00 积分100"
        detailLabel.textColor = rgbSameColor(169)
        detailLabel.font = font12
        detailLabel.numberOfLines = 0
        detailLabel.verAlignment = .top
        top.addSubview(detailLabel)
        
        memberRecharge = UIButton(frame: CGRect(x: btnX, y: 39, width: btnW, height: btnH))
        memberRecharge.setTitle(kMemberRecharge, for: .normal)
        memberRecharge.setTitleColor(rgbColor(110, g: 213, b: 108), for: .normal)
        memberRecharge.titleLabel?.font = font12
        memberRecharge.layer.cornerRadius = btnH/2
        memberRecharge.clipsToBounds = true
        memberRecharge.layer.borderColor = rgbColor(110, g: 213, b: 108).cgColor
        // 不可点击状态，待调整
        memberRecharge.setTitleColor(rgbSameColor(188), for: .normal)
        memberRecharge.layer.borderColor = rgbSameColor(188).cgColor

        memberRecharge.layer.borderWidth = 0.5
        memberRecharge.contentHorizontalAlignment = .center
        memberRecharge.addTarget(self, action: #selector(MembershipPrivilegesController.goToRecharge), for: .touchUpInside)
        top.addSubview(memberRecharge)

        let tipIcon = UIView(frame: CGRect(x: marginX, y: 95, width: 5, height: 5))
        tipIcon.layer.cornerRadius = 2.5
        tipIcon.clipsToBounds = true
        tipIcon.backgroundColor = rgbColor(42, g: 192, b: 146)
        top.addSubview(tipIcon)
        
        let str = kMemberRechargeTip
        let mutableString = NSMutableAttributedString(string: str)
        mutableString.addAttributes([NSForegroundColorAttributeName : rgbColor(42, g: 192, b: 146)], range: NSMakeRange(0, 3))
        mutableString.addAttributes([NSForegroundColorAttributeName : rgbColor(255, g: 201, b: 0)], range: NSMakeRange(str.characters.count - 1 - 4, 4))
        tipLabel = UILabel(frame: CGRect(x: 25, y: tipLabelY, width: kScreenWidth - 2*marginX, height: 18))
        tipLabel.textColor = rgbSameColor(169)
        tipLabel.font = font13
        tipLabel.attributedText = mutableString
        top.addSubview(tipLabel)

        let line = UIView(frame: CGRect(x: 0, y: topH - 0.5, width: kScreenWidth, height: 0.5))
        line.backgroundColor = rgbSameColor(232)
        top.addSubview(line)
    }
    
    // MARK:- 会员充值
    @objc fileprivate func goToRecharge() {
        let vc = RechargeController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    let tts = [kRoseGoldMember, kGoldMember, kPlatinumMember]
    let zhifutts = ["需一次性支付1000", "需一次性支付2000", "需一次性支付3000"]
    let huiyuanColors = [rgbColor(255, g: 171, b: 152), rgbColor(255, g: 201, b: 0), rgbColor(106, g: 195, b: 110)]
    let zhifuColors = [rgbColor(255, g: 200, b: 188), rgbColor(255, g: 216, b: 26), rgbColor(119, g: 218, b: 123)]
    fileprivate func setupMembershipPrivilegesView(_ maxY: CGFloat, index: Int) {
        let marginX: CGFloat = 17
        let viewH: CGFloat = 210
        let viewW: CGFloat = kScreenWidth - 2*marginX
        let view = UIView(frame: CGRect(x: marginX, y: maxY, width: viewW, height: viewH))
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.layer.borderColor = rgbSameColor(232).cgColor
        view.layer.borderWidth = 0.5
        mainScrollView.addSubview(view)
    
        let huiyuanW: CGFloat = viewW*0.35
        let huiyuanH: CGFloat = 70
        let huiyuanView = UIView(frame: CGRect(x: 0, y: 0, width: huiyuanW, height: huiyuanH))
        huiyuanView.backgroundColor = huiyuanColors[index]
        view.addSubview(huiyuanView)

        let huiyuan = UILabel(frame: CGRect(x: marginX, y: 0, width: huiyuanW - marginX, height: huiyuanH))
        huiyuan.text = tts[index]
        huiyuan.textColor = UIColor.white
        huiyuan.font = UIFont.boldSystemFont(ofSize: 18)
        huiyuanView.addSubview(huiyuan)
        
        let zhifuW: CGFloat = viewW*0.65
        let zhifu = UIView(frame: CGRect(x: huiyuanW, y: 0, width: zhifuW, height: huiyuanH))
        zhifu.backgroundColor = zhifuColors[index]
        view.addSubview(zhifu)
        
        let zhifuIcon = UIImageView()
        zhifuIcon.sizeToFit()
        zhifuIcon.frame.size = CGSize(width: 15, height: 12)
        zhifuIcon.center = CGPoint(x: 20, y: huiyuanH/2)
        zhifuIcon.image = UIImage(named: "iconfont-money")
        zhifu.addSubview(zhifuIcon)
        
        let zhifuTitleX: CGFloat = zhifuIcon.frame.maxX + 5
        let zhifuTitleW: CGFloat = zhifuW - zhifuTitleX
        let zhifuTitle = UILabel(frame: CGRect(x: zhifuTitleX, y: 0, width: zhifuTitleW, height: huiyuanH))
        zhifuTitle.text = zhifutts[index]
        zhifuTitle.textColor = rgbColor(162, g: 142, b: 40)
        zhifuTitle.font = font17
        zhifu.addSubview(zhifuTitle)

        let otherViewH: CGFloat = viewH - huiyuanH
        let otherView = UIView(frame: CGRect(x: 0, y: huiyuanH, width: viewW, height: otherViewH))
        view.addSubview(otherView)
        
        let otherH = otherViewH/4
        let otherW = viewW - 2*marginX
        let ttl1 = UILabel(frame: CGRect(x: marginX, y: 0, width: otherW, height: otherH))
        ttl1.textColor = rgb51
        ttl1.font = font13
        ttl1.text = kMembershipPrivileges
        otherView.addSubview(ttl1)
        
        let ttl2 = UILabel(frame: CGRect(x: marginX, y: otherH, width: otherW, height: otherH))
        ttl2.textColor = rgb51
        ttl2.font = font13
        ttl2.text = "服务费9.5折"
        otherView.addSubview(ttl2)
        
        let ttl3 = UILabel(frame: CGRect(x: marginX, y: otherH*2, width: otherW, height: otherH))
        ttl3.textColor = rgb51
        ttl3.font = font13
        ttl3.text = "每月免费礼品"
        otherView.addSubview(ttl3)
        
        let ttl4 = UILabel(frame: CGRect(x: marginX, y: otherH*3, width: otherW, height: otherH))
        ttl4.textColor = rgb51
        ttl4.font = font13
        ttl4.text = "生日礼品一份"
        otherView.addSubview(ttl4)
        
        mainScrollView.contentSize = CGSize(width: kScreenWidth, height: view.frame.maxY + marginX)
    }

}
