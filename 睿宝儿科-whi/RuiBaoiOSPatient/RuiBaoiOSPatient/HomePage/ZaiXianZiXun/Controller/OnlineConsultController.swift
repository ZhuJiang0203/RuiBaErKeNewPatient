//
//  OnlineConsultController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/12.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  在线咨询

import UIKit

class OnlineConsultController: BaseViewController {
    
    var keyword = ""
    var isRefresh = false
    
    var tableView: UITableView!
    var doctors = [DoctorListModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = kConsultation
        
        // 搜索
        setupSearchView()
        
        // tableView
        setupTableView()
        
        // 测试数据
        for _ in 0..<1 {
            let model = DoctorListModel()
            model.doctorID = "1"
            model.doctorIconUrlString = "http://img1.imgtn.bdimg.com/it/u=1612318878,2544651379&fm=21&gp=0.jpg"
            model.doctorSex = "M"
            model.doctorName = "Michr col"
            model.doctorState = true
            model.doctorKeShiZhi = "小儿外科"
            model.doctorZhiCheng = "主治医师"
            model.doctorGoods = "高血压、糖尿病、口腔溃疡、牙龈出血等常见疾病"
            model.wenZhenLiang = "26.5万"
            model.TuWenZiXunPrice = "50"
            model.zaiXianPhonePrice = "100"
            doctors.append(model)
        }
        tableView.reloadData()
    }

    private func setupSearchView() {
        let searchView = UIButton(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: 50))
        searchView.backgroundColor = rgb244
        
        let btn = UIButton(frame: CGRect(x: 10, y: 10, width: kScreenWidth - 20, height: 30))
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.layer.borderColor = rgbSameColor(208).cgColor
        btn.layer.borderWidth = 0.5
        btn.setTitle("  " + kSearch, for: .normal)
        btn.setTitleColor(rgbSameColor(153), for: .normal)
        btn.titleLabel?.font = font14
        btn.setImage(UIImage(named: "OnlineConsultControllerSearchIcon"), for: .normal)
        btn.addTarget(self, action: #selector(OnlineConsultController.searchButtonClicked), for: .touchUpInside)
        searchView.addSubview(btn)

    
        view.addSubview(searchView)
    }
    
    @objc private func searchButtonClicked() {
        // 搜索咨询的医生
        let vc = SearchDoctorsController()
        vc.onlineConsultCtl = self
        present(vc, animated: false, completion: nil)
    }

    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 114, width: kScreenWidth, height: kScreenHeight - 114), style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

}

extension OnlineConsultController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DoctorListCell.setupDoctorListCellWithTableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.model = doctors[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = InitiateConsultationController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
