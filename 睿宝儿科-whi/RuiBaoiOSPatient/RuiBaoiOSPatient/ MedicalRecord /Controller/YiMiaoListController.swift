//
//  YiMiaoListController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  疫苗列表

import UIKit

class YiMiaoListController: BaseViewController {

    // 疫苗列表
    var yiMiaoLieBiaos = [YiMiaoLieBiao]()
    
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(YMLB)"

        // 创建tableView
        setupTableView()
    }
    
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40
        tableView.backgroundColor = rgb244
        view.addSubview(tableView)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension YiMiaoListController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yiMiaoLieBiaos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecordListCell.setupRecordListCell(tableView, indexPath: indexPath)
        cell.model4 = yiMiaoLieBiaos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = YiMiaoDetailsController()
        vc.model = yiMiaoLieBiaos[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
