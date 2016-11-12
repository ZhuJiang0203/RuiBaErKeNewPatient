//
//  YongYaoListController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  用药列表

import UIKit

class YongYaoListController: BaseViewController {
   
    // 用药列表
    var yongYaoLieBiaos = [YongYaoLieBiao]()
    
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(YYLB)"

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
extension YongYaoListController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yongYaoLieBiaos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecordListCell.setupRecordListCell(tableView, indexPath: indexPath)
        cell.model3 = yongYaoLieBiaos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = YongYaoDetailsController()
        vc.model = yongYaoLieBiaos[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
