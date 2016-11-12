//
//  SMTZListController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  生命体征列表

import UIKit

class SMTZListController: BaseViewController {

    // 生命体征
    var shengMingTiZhengs = [ShengMingTiZheng]()

    fileprivate var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(SMTZ)"
        
        
        // 创建tableView
        setupTableView()
    }
    
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 240
        tableView.backgroundColor = rgb244
        view.addSubview(tableView)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SMTZListController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return shengMingTiZhengs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecordSMTZCell.setupRecordSMTZCell(tableView, indexPath: indexPath)
        cell.model = shengMingTiZhengs[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
