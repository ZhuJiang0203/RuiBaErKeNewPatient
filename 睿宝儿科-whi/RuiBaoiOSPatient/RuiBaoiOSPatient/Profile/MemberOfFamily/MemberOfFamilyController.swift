//
//  MemberOfFamilyController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

// 卡片尺寸
var kMemberCarViewW: CGFloat = 300.0
var kMemberCarViewH: CGFloat = 400.0

class MemberOfFamilyController: BaseViewController {
    
    var members = [MemberModel]()
    var isReloadData = false
    
    private var cardViews: MemberCardViews?
    private var addButton: UIButton?
    private var addButtonWH: CGFloat = 50
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 适配卡片尺寸
        switch kScreenHeight {
        case 480:
            kMemberCarViewW = 255
            kMemberCarViewH = 340
        case 568:
            kMemberCarViewW = 270
            kMemberCarViewH = 360
        case 667:
            kMemberCarViewW = 300
            kMemberCarViewH = 400
        case 736:
            kMemberCarViewW = 300
            kMemberCarViewH = 400
        default:
            kMemberCarViewW = 300
            kMemberCarViewH = 400
        }

        title = kMemberOfFamily

        
        
        
        /// 假数据
        for i in 0..<0 {
            let member = MemberModel()
            member.memberId = "1"
            switch i {
            case 0:
                member.iconUrlString = "http://upload4.hlgnet.com/uploadphoto/big/2011/2011-11-17/20111117015034_9610.jpg"
                member.name = "小小"
                member.sex = "男"
                member.age = "1岁"
                member.relationship = "儿子"
                member.phone = "15321434543"
            case 1:
                member.iconUrlString = "http://img.pconline.com.cn/images/upload/upc/tx/itbbs/1510/29/c13/14599627_1446085016720_mthumb.jpg"
                member.name = "妮妮"
                member.sex = "女"
                member.age = "3岁"
                member.relationship = "女儿"
                member.phone = "15678903432"
            case 2:
                member.iconUrlString = "http://img2.imgtn.bdimg.com/it/u=2829878419,2291663693&fm=21&gp=0.jpg"
                member.name = "晓晓"
                member.sex = "女"
                member.age = "18岁"
                member.relationship = "配偶"
                member.phone = "18910324324"
                
            default:
                member.iconUrlString = "http://i1.hexunimg.cn/2014-08-15/167580248.jpg"
                member.name = "珠江"
                member.sex = "男"
                member.age = "36岁"
                member.relationship = "本人"
                member.phone = "15322789899"
            }
            members.append(member)
        }

        
        
        
        /// 创建占位模块
        setupPlacehoderView()
        
        // 创建家庭成员卡片
        setupMemberCardViews()
        
        // 创建添加按钮
        setupAddMemberButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isReloadData == true {
            isReloadData = false
            // 刷新数据
            reloadData()
        }
    }
    
    /// 刷新数据
    private func reloadData() {
        
        var addY: CGFloat = (64 + kScreenHeight + kMemberCarViewH - addButtonWH)/2
        if members.count == 0 {
            addY = view.center.y + 76
        }
        addButton?.frame.origin.y = addY

        // 移除 旧卡片
        cardViews?.removeFromSuperview();
        
        // 创建 新卡片
        if members.count > 0 {
            setupMemberCardViews()
        }
    }
    
    /// 创建占位模块
    private func setupPlacehoderView() {

        let icon = UIImageView(image: UIImage(named: "AddChangYongJiueZhenren"))
        icon.center = CGPoint(x: view.center.x, y: view.center.y - 13)
        view.addSubview(icon)
        
        let tip = UILabel(frame: CGRect(x: 0, y: icon.frame.maxY + 7, width: kScreenWidth, height: 18))
        tip.text = kCommonlyUsedMedicalTreatment
        tip.textColor = rgbColor(79, g: 9, b: 2)
        tip.font = font15
        tip.textAlignment = .center
        view.addSubview(tip)
    }
    
    // MARK:- 创建家庭成员卡片
    private func setupMemberCardViews() {
        
        if members.count == 0 {
            view.backgroundColor = UIColor.white
        } else {
            view.backgroundColor = appMainColor
        }
        
        cardViews = MemberCardViews(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), members: members)
        cardViews!.delegate = self
        view.addSubview(cardViews!)
        
        if addButton != nil {
            view.bringSubview(toFront: addButton!)
        }
    }
    
    // MARK:- 创建添加按钮
    private func setupAddMemberButton() {
        
        let addX: CGFloat = (kScreenWidth - addButtonWH)/2
        let addY: CGFloat = view.center.y + 76
        addButton = UIButton(frame: CGRect(x: addX, y: addY, width: addButtonWH, height: addButtonWH))
        addButton!.setImage(UIImage(named: "AddMemberIcon"), for: .normal)
        addButton!.addTarget(self, action: #selector(MemberOfFamilyController.goToAddMember), for: .touchUpInside)
        view.addSubview(addButton!)
    }
    
    @objc private func goToAddMember() {
        
        let alertController = UIAlertController(title: kNewPatient, message: nil, preferredStyle: .actionSheet)
        
        let action0 = UIAlertAction(title: kAddNewlyDiagnosedPatient, style: .default) { (action) in
            let vc = AddPatientInfoController()
            vc.memberOfFamilyCtl = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alertController.addAction(action0)
        
        let action1 = UIAlertAction(title: kAddTheReferralOfPatients, style: .default) { (action) in
            let vc = MedicalRecordBindingController()
            vc.type = 2
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alertController.addAction(action1)
        
        let cancle = UIAlertAction(title: kCancle, style: .cancel, handler: nil)
        alertController.addAction(cancle)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension MemberOfFamilyController: MemberCardViewsDelegate {
    
    func memberCardViewsClicked(_ card: CardView?, memberCardViews: MemberCardViews?) {
        LLog(card?.tag)
        let vc = PersonalInfoController()
        vc.member = card?.model
        navigationController?.pushViewController(vc, animated: true)
    }
}
