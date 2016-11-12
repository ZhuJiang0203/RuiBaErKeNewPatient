//
//  FollowDoctorsController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/20.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  关注的医生

import UIKit

class FollowDoctorsController: BaseViewController {

    var tableView: UITableView!
    var doctors = [DoctorModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        // 测试数据
        for i in 0..<3 {
            let model = DoctorModel()
            model.doctorId = "\(i)"
            model.doctorIconUrlString = "http://img5.imgtn.bdimg.com/it/u=962587370,2103018495&fm=21&gp=0.jpg"
            model.doctorSex = "F"
            model.doctorName = "Aimee"
            model.doctorDeparment = "小儿外科"
            model.doctorPosition = "主治医师"
            model.clinic = "青苗口腔"
            doctors.append(model)
        }
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64 - 40 - 10), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
}

extension FollowDoctorsController: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DoctorCell.setupDoctorCell(tableView, cellForRowAtIndexPath: indexPath)
        cell.model = doctors[indexPath.row]
        return cell
    }
}

