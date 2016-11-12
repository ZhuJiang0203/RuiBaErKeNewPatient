//
//  MyConsultationController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/19.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  我的咨询

import UIKit

class MyConsultationController: BaseViewController {

    var tableView: UITableView!
    var consultations = [MyConsultation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = kMyConsultation
        
        setupTableView()
        
        // 测试数据
        for i in 0..<3 {
            let model = MyConsultation()
            model.consultationId = "\(i)"
            model.doctorIconString = "http://pic72.nipic.com/file/20150713/20189787_140001855219_2.jpg"
            model.doctorSex = "M"
            model.doctorName = "俺的沙发"
            model.consultationState = "4"
            model.patientName = "打算"
            model.patientComplaint = "东方大道发生的发的所发生的"
            model.consultationTime = "2016-09-08"
            consultations.append(model)
        }
        tableView.reloadData()
    }
    
    private func setupTableView() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 174
        tableView.backgroundColor = rgb244
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
}

extension MyConsultationController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consultations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyConsultationCell.setupMyConsultationCell(tableView, cellForRowAtIndexPath: indexPath)
        cell.model = consultations[indexPath.row];
        cell.delegate = self
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
        
    }
}

extension MyConsultationController: MyConsultationCellDelegate {
    func stateButtonOfMyConsultationCellClicked(_ btn: UIButton, cell: MyConsultationCell) {
        print(btn.titleLabel?.text)
        print(cell.model?.consultationId)
    
    }
}
