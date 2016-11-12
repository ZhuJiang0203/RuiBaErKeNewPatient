//
//  MedicalRecordController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class MedicalRecordController: BaseViewController {

    private var tableView: UITableView!
    fileprivate var records = [MedicalRecord]()
    private var addButton: UIButton?

    private var maskingNoData: NoMedicalRecordBackgroundView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
      
        // 创建tableView
        setupTableView()
        
        
        // 测试数据
        for i in 0..<0 {
            
            let model = MedicalRecord()
            model.patientID = "\(i)"
            model.patientIcon = "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1475115659&di=03edc7dba4a569b6d18c1a9bcb3f8438&src=http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1308/16/c0/24549225_1376645703600.jpg"
            model.name = "姓名"
            model.age = "25"
            model.dob = "2012-09-09"
            model.sex = "F"
            model.medicalRecordNumber = "R41234134314132123"
            records.append(model)
        }
        tableView.reloadData()
        
        
        if records.count > 0 {
            /// 关联家庭成员病历
            setupAddButton()
        } else {
            loadNoData()
        }
    }
    
    // MARK:- 关联家庭成员病历
    private func setupAddButton() {
        
        addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        addButton!.setImage(UIImage.init(named: "AddMedicalRecord"), for: .normal)
        addButton!.contentHorizontalAlignment = .right
        addButton!.addTarget(self, action: #selector(MedicalRecordController.addButtonClicked), for: .touchUpInside)
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton!)
    }
    
    @objc private func addButtonClicked() {
        let vc = MedicalRecordBindingController()
        vc.type = 3
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 140
        view.addSubview(tableView)
    }
    

    // 加载数据为nil----数据处理
    private func loadNoData() {
        
        if maskingNoData == nil {
            maskingNoData = NoMedicalRecordBackgroundView.setUpNoMedicalRecordBackgroundView(view.bounds)
            maskingNoData!.delegate = self
        }
        tableView.addSubview(maskingNoData!)
    }
    
    // 加载有数据
    private func loadHaveData() {
        maskingNoData?.removeFromSuperview()
    }
    
}

extension MedicalRecordController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MedicalRecordCell.setupMedicalRecordCell(tableView, indexPath: indexPath)
        cell.model = records[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let vc = MedicalRecordDetailsController()
        vc.patient = records[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}


extension MedicalRecordController: NoMedicalRecordBackgroundViewDelegate {

    func buttonOfNoMedicalRecordBackgroundViewClicked() {
        let vc = MedicalRecordBindingController()
        vc.type = 1
        _ = navigationController?.pushViewController(vc, animated: true)
    }
}
