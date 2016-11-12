//
//  DepartmentsController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  科室

import UIKit

class DepartmentsController: BaseViewController {

    fileprivate var departments = [DepartmentA]()
    fileprivate var tableViewA: UITableView!
    fileprivate var tableViewB: UITableView!
    fileprivate var departmentsOfB = [DepartmentB]()
    fileprivate var currentIndexPath: IndexPath?
    fileprivate var sectionButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = kDepartment

        // 创建tableViewA、tableViewB
        setupTableView()
        
        let titlesA = ["内科", "外科", "妇产科", "耳鼻喉科", "营养科", "牙科"]
        let titlesB1 = ["内科", "内科", "内科", "内科"]
        let titlesB2 = ["妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科", "妇产科"]
        for i in 0..<titlesA.count {
            let depA = DepartmentA()
            depA.departmentName = titlesA[i]
            
            if i%2 == 0 {
                for ttl in titlesB1 {
                    let depB = DepartmentB()
                    depB.departmentName = "\(ttl)\(i)"
                    depA.departmentSubs.append(depB)
                }
            } else {
                for ttl in titlesB2 {
                    let depB = DepartmentB()
                    depB.departmentName = "\(ttl)\(i)"
                    depA.departmentSubs.append(depB)
                }
            }
            departments.append(depA)
        }
        
        departmentsOfB = departments[0].departmentSubs
        
        tableViewA.reloadData()
        tableViewB.reloadData()
    }
    
    // MARK:- 创建tableViewA、tableViewB
    private func setupTableView() {
        
        let tableViewAW: CGFloat = 120
        let tableViewAH: CGFloat = kScreenHeight - 64
        tableViewA = UITableView(frame: CGRect(x: 0, y: 64, width: tableViewAW, height: tableViewAH), style: .plain)
        tableViewA.showsVerticalScrollIndicator = false
        tableViewA.delegate = self
        tableViewA.dataSource = self
        tableViewA.rowHeight = 50
        tableViewA.backgroundColor = rgb244
        tableViewA.separatorStyle = .none
        view.addSubview(tableViewA)
        
        let line = UIView(frame: CGRect(x: tableViewAW - 0.5, y: 0, width: 0.5, height: tableViewAH))
        line.backgroundColor = rgbSameColor(228)
        tableViewA.addSubview(line)
        
        tableViewB = UITableView(frame: CGRect(x: 120, y: 64, width: kScreenWidth - 120, height: kScreenHeight - 64), style: .plain)
        tableViewB.showsVerticalScrollIndicator = false
        tableViewB.delegate = self
        tableViewB.dataSource = self
        tableViewB.rowHeight = 46
        tableViewB.separatorStyle = .none
        tableViewB.backgroundColor = UIColor.white
        view.addSubview(tableViewB)
    }

    /**
     全部
     */
    @objc fileprivate func totalSubDepartments() {
        
        sectionButton?.isSelected = true
        
        departmentsOfB = departments[0].departmentSubs
        if currentIndexPath != nil {
            tableViewA.deselectRow(at: currentIndexPath!, animated: false)
        }
        tableViewB.reloadData()
    }

}

extension DepartmentsController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewA {
            return departments.count - 1
        } else {
            return departmentsOfB.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if tableView == tableViewA { // 一级科室
            let cell = ClassADepartmentCell.setupClassADepartmentCell(tableView, cellForRowAtIndexPath: indexPath)
            cell.model = departments[indexPath.row]
            return cell
        }

        let cell = ClassBDepartmentCell.setupClassBDepartmentCell(tableView, cellForRowAtIndexPath: indexPath)
        cell.model = departmentsOfB[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableViewA {
            departmentsOfB = departments[indexPath.row + 1].departmentSubs
            currentIndexPath = indexPath
            sectionButton?.isSelected = false
            tableViewB.reloadData()
        } else {
            let vc = DepartmentDoctorListController()
            let model = departmentsOfB[indexPath.row]
            vc.title = model.departmentName
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tableViewA {
            return 60
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tableViewA {
            if sectionButton == nil {
                sectionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 60))
                sectionButton!.setTitle(kTotal, for: .normal)
                sectionButton!.setTitleColor(UIColor.white, for: .normal)
                sectionButton!.titleLabel?.font = font16
                sectionButton!.setBackgroundImage(UIImage(named: "TotalDeparments"), for: .normal)
                sectionButton!.setBackgroundImage(UIImage(named: "TotalDeparmentsSelected"), for: .selected)
                sectionButton!.isSelected = currentIndexPath == nil
                sectionButton!.addTarget(self, action: #selector(DepartmentsController.totalSubDepartments), for: .touchUpInside)
            }
            return sectionButton!
        }
        return nil
    }
}



/// 一级科室

private let ClassADepartmentCellIdentifier = "ClassADepartmentCellIdentifier"

class ClassADepartmentCell: UITableViewCell {
    
    var model: DepartmentA? {
        didSet{
            if model != nil {
                titleLbl.text = model!.departmentName
            }
        }
    }
    
    class func setupClassADepartmentCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> ClassADepartmentCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ClassADepartmentCellIdentifier) as? ClassADepartmentCell
        if cell == nil {
            cell = ClassADepartmentCell(style: .default, reuseIdentifier: ClassADepartmentCellIdentifier)
            cell!.backgroundColor = rgb244
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLbl)
        contentView.addSubview(line)
        
        let cellW: CGFloat = 120
        let cellH: CGFloat = 50
        titleLbl.frame = CGRect(x: 0, y: 0, width: cellW, height: cellH)
        line.frame = CGRect(x: 0, y: cellH - 0.5, width: cellW, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font16
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(228)
        return line
    }()
}

/// 二级科室

private let ClassBDepartmentCellIdentifier = "ClassBDepartmentCellIdentifier"

class ClassBDepartmentCell: UITableViewCell {
    
    var model: DepartmentB? {
        didSet{
            if model != nil {
                titleLbl.text = model!.departmentName
            }
        }
    }
    
    class func setupClassBDepartmentCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> ClassBDepartmentCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ClassBDepartmentCellIdentifier) as? ClassBDepartmentCell
        if cell == nil {
            cell = ClassBDepartmentCell(style: .default, reuseIdentifier: ClassBDepartmentCellIdentifier)
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLbl)
        contentView.addSubview(line)
        
        let cellW: CGFloat = kScreenWidth - 120
        let cellH: CGFloat = 46
        titleLbl.frame = CGRect(x: 15, y: 0, width: cellW, height: cellH)
        line.frame = CGRect(x: 0, y: cellH - 0.5, width: cellW, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font14
        return lbl
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
}





class DepartmentA: NSObject {
    
    // 科室ID
    var departmentId = ""
    // 科室名称（一级科室）
    var departmentName = ""
    // 子科室（二级科室）
    var departmentSubs = [DepartmentB]()
}

class DepartmentB: NSObject {
    
    // 科室ID
    var departmentId = ""
    // 科室名称（二级科室）
    var departmentName = ""
}

