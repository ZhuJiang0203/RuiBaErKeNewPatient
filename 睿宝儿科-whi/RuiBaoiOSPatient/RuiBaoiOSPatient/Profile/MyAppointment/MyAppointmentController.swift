//
//  MyAppointmentController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/20.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class MyAppointmentController: BaseViewController {
    
    var tableView: UITableView!
    var appointments = [MyAppointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = kBookingInformation
        
        setupTableView()
        
        // 测试数据
        for i in 0..<3 {
            let model = MyAppointment()
            model.appointId = "\(i)"
            model.hospital = "北京协和医院"
            model.appointMoney = "¥20"
            switch i {
            case 0:
                model.doctorIconUrlString = "http://img.taopic.com/uploads/allimg/140220/234996-1402200TZ282.jpg"
            case 1:
                    model.doctorIconUrlString = "http://img01.taopic.com/150530/318764-1505300J34843.jpg"
            default:
                model.doctorIconUrlString = "http://pic8.nipic.com/20100720/4843356_151744289327_2.jpg"
            }
            model.doctorSex = "M"
            model.dcotorName = "赵恩"
            model.doctorDeparment = "小儿外科"
            model.appointState = "1"
            model.appointTime = "2016-09-18 上午"
            model.jiuZhenRen = "就诊人：尹小铮"
            appointments.append(model)
        }
        tableView.reloadData()
    }
    
    private func setupTableView() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 177
        tableView.backgroundColor = rgb244
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
}

extension MyAppointmentController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyAppointmentCell.setupMyAppointmentCell(tableView, cellForRowAtIndexPath: indexPath)
        cell.model = appointments[indexPath.row];
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
        
        let vc = AppointmentDetailsController()
        vc.type = .ZiXunXiangQing
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyAppointmentController: MyAppointmentCellDelegate {
    func stateButtonOfMyAppointmentCellClicked(_ btn: UIButton, cell: MyAppointmentCell) {
    
    }
}
