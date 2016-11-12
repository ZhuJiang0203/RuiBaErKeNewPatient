//
//  InsuranceTypeController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/31.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  选择保险类型

import UIKit

class InsuranceTypeController: BaseViewController {

    var addPatientInfoCtl: AddPatientInfoController!
    
    private var tableView: UITableView!
    
    fileprivate var insurances = [Insurance]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = kSelectTypeInsurance
        
        // 测试数据
        for i in 0..<10 {
            let model = Insurance()
            model.insuranceName = "人寿保险\(i)"
            insurances.append(model)
        }
        
        // 创建tableView
        setupTableView()
    }
    
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = kCellHeight
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    

}


extension InsuranceTypeController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return insurances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = InsuranceCell.setupInsuranceCellWithTableView(tableView, cellForRowAtIndexPath: indexPath)
        
        let model = insurances[indexPath.row]
        model.isSelected = addPatientInfoCtl.insuranceTypeText == model.insuranceName
        LLog(addPatientInfoCtl.insuranceTypeText)
        LLog(model.insuranceName)
        cell.model = model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = insurances[indexPath.row]
        addPatientInfoCtl?.insuranceTypeText = model.insuranceName
        _ = navigationController!.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kMargin
    }
}








private let InsuranceCellIdentifier = "PatientCellIdentifier"

@objc
protocol InsuranceCellDelegate: NSObjectProtocol {
    @objc optional func iconButtonOfPatientCellClicked(_ cell: PatientCell, icon: UIButton)
}

private class InsuranceCell: UITableViewCell {
    
    weak var delegate: InsuranceCellDelegate?
    
    var model: Insurance? {
        didSet{
            if model != nil {
                nameLbel.text = model!.insuranceName
                circleButton.isSelected = model!.isSelected
                LLog("~~~~~~~~~~~~~~~~\(circleButton.isSelected)")
            }
        }
    }
    
    class func setupInsuranceCellWithTableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> InsuranceCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: InsuranceCellIdentifier) as? InsuranceCell
        if cell == nil {
            cell = InsuranceCell(style: .default, reuseIdentifier: InsuranceCellIdentifier)
            cell!.selectionStyle = .none
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLbel)
        contentView.addSubview(circleButton)
        contentView.addSubview(line)
        
        
        nameLbel.frame = CGRect(x: kMargin15, y: 0, width: 200, height: kCellHeight)
        let circleButtonWH: CGFloat = 20
        let circleButtonX: CGFloat = kScreenWidth - 21 - circleButtonWH
        let circleButtonY: CGFloat = (kCellHeight - circleButtonWH)/2
        circleButton.frame = CGRect(x: circleButtonX, y: circleButtonY, width: circleButtonWH, height: circleButtonWH)
        line.frame = CGRect(x: 0, y: kCellHeight - 0.5, width: kScreenWidth, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var nameLbel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font16
        return lbl
    }()
    
    fileprivate lazy var circleButton: UIButton = {
        let circle = UIButton()
        circle.setImage(UIImage.init(named: "CircleButtonGray2020"), for: .normal)
        circle.setImage(UIImage.init(named: "CircleButtonPink2020"), for: .selected)
        circle.isUserInteractionEnabled = false
        return circle
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
}








private class Insurance: NSObject {
    
    var InsuranceID = ""
    var insuranceName = ""
    var isSelected = false
}
