
//
//  AccountSecurityController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  账号与安全

import UIKit

class AccountSecurityController: BaseViewController {

    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = kCcountSecurity
        
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

extension AccountSecurityController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AccountSecurityCell.setupAccountSecurityCellWithTableView(tableView, cellForRowAt: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            navigationController?.pushViewController(AccountBinDingController(), animated: true)
        } else if indexPath.row == 2 {
            navigationController?.pushViewController(ModifyPasswordController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

private class AccountSecurityCell: UITableViewCell {
    
    class func setupAccountSecurityCellWithTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> AccountSecurityCell {
        let cell = AccountSecurityCell(style: .default, reuseIdentifier: nil, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, indexPath: IndexPath) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(keyLabel)
        
        
        let cellH: CGFloat = 60
        keyLabel.frame = CGRect(x: kMargin15, y: 0, width: 150, height: cellH)
        
        /// 箭头
        let arrowImageViewW: CGFloat = 6
        let arrowImageViewH: CGFloat = 10
        let arrowImageViewX: CGFloat = kScreenWidth - kMargin15 - arrowImageViewW
        let arrowImageViewY: CGFloat = (cellH - arrowImageViewH)/2

        if indexPath.row == 0  {
            
            contentView.addSubview(arrowImageView)
            contentView.addSubview(line)
            
            arrowImageView.frame = CGRect(x: arrowImageViewX, y: arrowImageViewY, width: arrowImageViewW, height: arrowImageViewH)
            line.frame = CGRect(x: kMargin15, y: cellH - 0.5, width: kScreenWidth - 2*kMargin15, height: 0.5)
            
            keyLabel.text = kBindAccount

        } else if indexPath.row == 1  {
            
            contentView.addSubview(valueLabel)
            contentView.addSubview(line)
            
            let valueLabelW: CGFloat = 200
            let valueLabelX: CGFloat = kScreenWidth - kMargin15 - valueLabelW
            valueLabel.frame = CGRect(x: valueLabelX, y: 0, width: valueLabelW, height: cellH)
            line.frame = CGRect(x: kMargin15, y: cellH - 0.5, width: kScreenWidth - 2*kMargin15, height: 0.5)

            keyLabel.text = kCurrentAccount
            valueLabel.text = "188****3121"

        } else {
            
            contentView.addSubview(arrowImageView)
            arrowImageView.frame = CGRect(x: arrowImageViewX, y: arrowImageViewY, width: arrowImageViewW, height: arrowImageViewH)
            
            keyLabel.text = kModifyPassword
        }
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
    
    fileprivate lazy var valueLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font16
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
