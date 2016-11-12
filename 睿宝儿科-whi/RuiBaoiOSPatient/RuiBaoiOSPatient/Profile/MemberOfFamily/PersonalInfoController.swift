//
//  PersonalInfoController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/10.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  个人信息、添加联系人

import UIKit

class PersonalInfoController: BaseViewController {

    var member: MemberModel?
    fileprivate var tableView: UITableView!
    // 关系
    fileprivate var relationshipTextField: UITextField!
    // 姓名
    fileprivate var nameTextField: UITextField!
    // 手机号
    fileprivate var phoneTextField: UITextField!
    // 家庭电话
    fileprivate var familyPhonefTextField: UITextField!
    // 邮箱
    fileprivate var emailTextField: UITextField!
    // 微信号
    fileprivate var weiXinNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建tableView
        setupTableView()
        
        // 创建navigation
        setupNavigation()
    }
    
    // MARK:- 创建navigation
    fileprivate func setupNavigation() {
        if member == nil { // 添加联系人
            title = kAddAContact
            // 创建rightBarButtonItem
            customNavigationItem.rightBarButtonItem = UIBarButtonItem(title: kSave, style: .plain, target: self, action: #selector(PersonalInfoController.saveInfos))
        } else { // 个人信息
            title = kProfileInfo
        }
    }
    
    // MARK:- 保存
    @objc fileprivate func saveInfos() {
        
    
    }

    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.backgroundColor = rgb244
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
}

extension PersonalInfoController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PersonalInfoCell.setupPersonalInfoCell(tableView, cellForRowAtIndexPath: indexPath)
       
        let index = indexPath.section*3 + indexPath.row
        switch index {
        case 0:
            relationshipTextField = cell.valueTextField
            relationshipTextField.isUserInteractionEnabled = member == nil
            relationshipTextField.text = member?.relationship
        case 1:
            nameTextField = cell.valueTextField
            nameTextField.isUserInteractionEnabled = member == nil
            nameTextField.text = member?.name
        case 2:
            phoneTextField = cell.valueTextField
            phoneTextField.isUserInteractionEnabled = member == nil
            phoneTextField.text = member?.phone
        case 3:
            familyPhonefTextField = cell.valueTextField
            familyPhonefTextField.isUserInteractionEnabled = member == nil
            familyPhonefTextField.text = member?.familyPhone
        case 4:
            emailTextField = cell.valueTextField
            emailTextField.isUserInteractionEnabled = member == nil
            emailTextField.text = member?.email
        case 5:
            weiXinNumberTextField = cell.valueTextField
            weiXinNumberTextField.isUserInteractionEnabled = member == nil
            weiXinNumberTextField.text = member?.weiXinNumber
        default:
            LLog("")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}


class PersonalInfoCell: UITableViewCell {

    fileprivate var keyTexts = [kRelationship, kName, kPhoneNumber2, kHomePhone, kMailbox, kWechatNumber]
    fileprivate var valuePlaceTexts = [kRequired, kRequired, kRequired, kNonMandatory, kNonMandatory, kNonMandatory]
    
    class func setupPersonalInfoCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> PersonalInfoCell {
        let cell = PersonalInfoCell(style: .default, reuseIdentifier: nil, tableView: tableView, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, tableView: UITableView, indexPath: IndexPath) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 创建子控件
        contentView.addSubview(keyLabel)
        contentView.addSubview(valueTextField)
        contentView.addSubview(line)
        
        if (indexPath.section == 0 && indexPath.row == 2) || (indexPath.section == 1 && indexPath.row == 0) {
            // 键盘类型（只有整数）
            valueTextField.keyboardType = .numberPad
        }
        
        let index = indexPath.section*3 + indexPath.row
        keyLabel.text = keyTexts[index]
        valueTextField.placeholder = valuePlaceTexts[index]
        
        let cellH: CGFloat = 60
        keyLabel.frame = CGRect(x: 15, y: 0, width: 150, height: cellH)
        let valueTextFieldW: CGFloat = 200
        let valueTextFieldX: CGFloat = kScreenWidth - 15 - valueTextFieldW
        valueTextField.frame = CGRect(x: valueTextFieldX, y: 0, width: valueTextFieldW, height: cellH)
        line.frame = CGRect(x: 0, y: cellH - 0.5, width: kScreenWidth, height: 0.5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var keyLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font16
        return lbl
    }()
    
    lazy var valueTextField: UITextField = {
        let txt = UITextField()
        txt.textColor = rgb51
        txt.font = font16
        txt.textAlignment = .right
        // 光标颜色
        txt.tintColor = appMainColor
        return txt
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()

}
