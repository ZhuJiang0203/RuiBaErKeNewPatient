//
//  ProfileController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

// 切换中英文后push到SetUpController
var isPushToSetUpController = false

class ProfileController: BaseViewController {
    
    var isRefresh = false

    var tableView: UITableView?
    fileprivate var iconImageView: UIImageView?
    fileprivate var iconImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        iconImage = SaveImage.getImageWithImageName(kUserIconUIImageKey)

        // 创建tableView
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isPushToSetUpController == true {
            isPushToSetUpController = false
            navigationController?.pushViewController(SetUpController(), animated: false)
        }
        
        if isRefresh == true {
            isRefresh = false
            
            // 为什么不刷新数据呢？？？？？？？？？？？？
//            tableView?.reloadData()
            
            iconImage = SaveImage.getImageWithImageName(kUserIconUIImageKey)
            iconImageView?.image = (iconImage != nil) ? iconImage : UIImage(named: "IconPlacehoderFenWhite")
        }
    }
    
    // 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64 - 49), style: .grouped)
        tableView!.backgroundColor = rgb244
        tableView!.separatorStyle = .none
        tableView!.dataSource = self
        tableView!.delegate = self
        view.addSubview(tableView!)
    }
}


extension ProfileController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return profileCellIcons.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = Section0Cell(style: .default, reuseIdentifier: nil)
            iconImageView = cell.picture
            iconImageView?.image = (iconImage != nil) ? iconImage : UIImage(named: "IconPlacehoderFenWhite")
            cell.name.text = defaults.string(forKey: kPatientNameKey) ?? ""
            cell.position.text = kNotBoundMedicalRecords // 未绑定病历
            
            let sex = defaults.string(forKey: kPatientSexKey) ?? "M"
            let sexString = sex == "M" ? kMale : kFemale
            let age = defaults.string(forKey: kPatientAgeKey) ?? ""
            let ageString = age.characters.count > 0 ? "\(age)\(kAge)" : age
            cell.position.text = "\(sexString) \(ageString)"
            
            return cell
        }
        
        let cell = Section1Cell(style: .default, reuseIdentifier: nil)
        cell.iconView.image = UIImage(named: profileCellIcons[indexPath.row])
        cell.content.text = kProfileTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 { // 患者信息
            let vc = PatientInformationController()
            vc.profileCtl = self
            navigationController?.pushViewController(vc, animated: true)
        } else {
            switch indexPath.row {
            case 0: // 会员特权
                let vc = MembershipPrivilegesController()
                navigationController?.pushViewController(vc, animated: true)
            case 1: // 我的咨询
                let vc = MyConsultationController()
                navigationController?.pushViewController(vc, animated: true)
            case 2: // 我的预约
                let vc = MyAppointmentController()
                navigationController?.pushViewController(vc, animated: true)
            case 3: // 我的关注
                let vc = MyFollowingController()
                navigationController?.pushViewController(vc, animated: true)
            case 4: // 家庭成员
                let vc = MemberOfFamilyController()
                navigationController?.pushViewController(vc, animated: true)
            case 5: // 设置
                let vc = SetUpController()
                navigationController?.pushViewController(vc, animated: true)
            default:
                LLog("")
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}


class Section0Cell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 创建、布局子控件
        contentView.addSubview(picture)
        contentView.addSubview(name)
        contentView.addSubview(position)
        contentView.addSubview(arrow)
        
        picture.frame = CGRect(x: 15, y: kMargin, width: 60, height: 60)
        let nameX: CGFloat = picture.frame.maxX + kMargin
        name.frame = CGRect(x: nameX, y: 17, width: 200, height: 22)
        let rightMaigin: CGFloat = 28 // 箭头左右间距 + 箭头的宽度
        position.frame = CGRect(x: nameX, y: name.frame.maxY + 4, width: kScreenWidth - nameX - rightMaigin, height: 17)
        let arroeW: CGFloat = 6
        let arroeH: CGFloat = 10
        let arroeX = kScreenWidth - 15 - arroeW
        let arroeY = (80 - arroeH)/2
        arrow.frame = CGRect(x: arroeX, y: arroeY, width: arroeW, height: arroeH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate lazy var picture: UIImageView = {
        let picture = UIImageView()
        picture.contentMode = UIViewContentMode.scaleAspectFill
        picture.clipsToBounds = true
        picture.layer.cornerRadius = 30
        picture.clipsToBounds = true
        picture.backgroundColor = UIColor(patternImage: UIImage(named: "IconPlacehoderFenWhite")!)
        return picture
    }()
    
    fileprivate lazy var name: UILabel = {
        let name = UILabel()
        name.textColor = rgb50
        name.font = font16
        return name
    }()
    
    fileprivate lazy var position: UILabel = {
        let position = UILabel()
        position.textColor = rgb153
        position.font = font12
        return position
    }()
    
    fileprivate lazy var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(named: "ArrowGray610")
        return arrow
    }()
}



class Section1Cell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 创建、布局子控件
        let cellH: CGFloat = 60
        
        contentView.addSubview(iconView)
        contentView.addSubview(content)
        contentView.addSubview(arrow)
        contentView.addSubview(line)
        iconView.frame = CGRect(x: 15, y: 20, width: 20, height: 20)
        content.frame = CGRect(x: 45, y: 20, width: 200, height: 20)
        let arroeW: CGFloat = 6
        let arroeH: CGFloat = 10
        let arroeX = kScreenWidth - 15 - arroeW
        let arroeY = (cellH - arroeH)/2
        arrow.frame = CGRect(x: arroeX, y: arroeY, width: arroeW, height: arroeH)
        line.frame = CGRect(x: 15, y: 60 - 0.5, width: kScreenWidth - 30, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = UIViewContentMode.scaleAspectFill
        icon.clipsToBounds = true
        return icon
    }()
    
    fileprivate lazy var content: UILabel = {
        let content = UILabel()
        content.textColor = rgb50
        content.font = font15
        return content
    }()
    
    fileprivate lazy var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(named: "ArrowGray610")
        return arrow
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
}
