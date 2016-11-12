//
//  AccountBinDingController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  账号绑定

import UIKit

class AccountBinDingController: BaseViewController {

    private var tableView: UITableView!
    fileprivate var models = [AccountBinDing]()
    private var icons = ["AccountBinDingWX", "AccountBinDingSina", "AccountBinDingQQ", "AccountBinDingPhone", "AccountBinDingBingLi"]
    private var keys = [kWeChat, kMicroBlogSina, kTencentQQ, kPhone, kMedicalRecordTabBar]
    private var values = [kNotBound, kNotBound, kNotBound, kNotBound, kNotBound]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = kBindAccount
        
        for i in 0..<5 {
            let model = AccountBinDing()
            model.iconString = icons[i]
            model.keyString = keys[i]
            model.valueString = values[i]
            models.append(model)
        }
        
        // 创建tableView
        setupTableView()
    }
    
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.backgroundColor = rgb244
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
}

extension AccountBinDingController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AccountBinDingCell.setupAccountBinDingCellWithTableView(tableView, cellForRowAt: indexPath)
        cell.model = models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0: // 微信

            // 发送网络请求
            CustomMBProgressHUD.showTipAndHideImmediately(kSendNetworkRequest, details: nil, view: view)
            
        case 1: // 新浪微博
            // 发送网络请求
            CustomMBProgressHUD.showTipAndHideImmediately(kSendNetworkRequest, details: nil, view: view)

        case 2: // QQ
            // 发送网络请求
            CustomMBProgressHUD.showTipAndHideImmediately(kSendNetworkRequest, details: nil, view: view)

        case 3: // 手机
            
            let model = models[indexPath.row]
            if model.valueString == kNotBound { // 手机绑定
                let vc = RegisterViewController()
                vc.type = 3
                navigationController?.pushViewController(vc, animated: true)
            } else { // 手机解绑
                let vc = UnbundlingController()
                vc.type = 1
                navigationController?.pushViewController(vc, animated: true)
            }

        default: // 病历
          
            let model = models[indexPath.row]
            if model.valueString == kNotBound { // 病历绑定
                let vc = MedicalRecordBindingController()
                vc.type = 1
                self.navigationController?.pushViewController(vc, animated: true)
            } else { // 病历解绑
                let vc = UnbundlingController()
                vc.type = 2
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

private class AccountBinDingCell: UITableViewCell {
    
    var model: AccountBinDing? {
        didSet{
            
            if model != nil {
                
                let iconstr = model!.valueString == kNotBound ? model!.iconString : "\(model!.iconString)Selected"
                iconImageView.image = UIImage(named: iconstr)
                iconImageView.sizeToFit()
                iconImageView.center = CGPoint(x: 30, y: 30)

                keyLabel.text = model!.keyString
                valueLabel.text = model!.valueString
                
            }
        }
    }
    
    class func setupAccountBinDingCellWithTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> AccountBinDingCell {
        let cell = AccountBinDingCell(style: .default, reuseIdentifier: nil, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, indexPath: IndexPath) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(keyLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(line)
        

        
        let cellH: CGFloat = 60
        keyLabel.frame = CGRect(x: 61, y: 0, width: 150, height: cellH)
        
        /// 箭头
        let arrowImageViewW: CGFloat = 6
        let arrowImageViewH: CGFloat = 10
        let arrowImageViewX: CGFloat = kScreenWidth - kMargin15 - arrowImageViewW
        let arrowImageViewY: CGFloat = (cellH - arrowImageViewH)/2
        arrowImageView.frame = CGRect(x: arrowImageViewX, y: arrowImageViewY, width: arrowImageViewW, height: arrowImageViewH)
        
        let valueLabelW: CGFloat = 200
        let valueLabelX: CGFloat = arrowImageView.frame.minX - 4 - valueLabelW
        valueLabel.frame = CGRect(x: valueLabelX, y: 0, width: valueLabelW, height: cellH)
        
        line.frame = CGRect(x: 0, y: cellH - 0.5, width: kScreenWidth, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var iconImageView: UIImageView = {
        let icon = UIImageView()
        return icon
    }()

    fileprivate lazy var keyLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font16
        return lbl
    }()
    
    fileprivate lazy var valueLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font13
        lbl.textAlignment = .right
        return lbl
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "ArrowGray610")
        return icon
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
}

class AccountBinDing: NSObject {
    fileprivate var iconString = ""
    fileprivate var keyString = ""
    fileprivate var valueString = ""
}
