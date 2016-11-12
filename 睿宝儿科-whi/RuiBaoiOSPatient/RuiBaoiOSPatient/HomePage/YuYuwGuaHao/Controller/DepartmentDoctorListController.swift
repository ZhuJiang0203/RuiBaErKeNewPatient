//
//  DepartmentDoctorListController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  科室对应的医生列表

import UIKit

class DepartmentDoctorListController: BaseViewController {

    private var topView: UIView!
    private var tableView: UITableView!
    fileprivate var doctors = [DoctorModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = rgb244
        
        // 创建topView
        setupTopView()
        
        // 创建tableView
        setupTableView()
        
        // 测试
        for _ in 0..<3 {
            let model = DoctorModel()
            model.doctorIconUrlString = "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1474959128&di=5537d23288fd9945653b9f662a10ab9f&src=http://p.3761.com/pic/85171413852949.jpg"
            model.doctorSex = "M"
            model.doctorName = "Jhone Name"
            model.doctorDeparment = "小儿内科"
            model.doctorPosition = "主治医师"
            model.isAbout = true
            model.goods = "擅长：牙龈出血、口腔溃疡"
            doctors.append(model)
        }
        tableView.reloadData()
    }
    
    // MARK:- 创建topView
    private func setupTopView() {
        
        topView = UIView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: 100))
        topView.backgroundColor = UIColor.white
        view.addSubview(topView)        
    }
    
    // MARK:- 创建tableView
    private func setupTableView() {
        
        let tableViewY = topView.frame.maxY + 10
        let tableViewH = kScreenHeight - tableViewY
        tableView = UITableView(frame: CGRect(x: 0, y: tableViewY, width: kScreenWidth, height: tableViewH), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
    }
    
}



extension DepartmentDoctorListController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DeparmentDoctorListCell.setupDeparmentDoctorListCell(tableView, cellForRowAtIndexPath: indexPath)
        cell.model = doctors[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DoctorAppointmentController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}





private let DeparmentDoctorListCellIdentifier = "DeparmentDoctorListCellIdentifier"

class DeparmentDoctorListCell: UITableViewCell {
    
    var model: DoctorModel? {
        didSet{
            
            if model != nil {
                
                let placehoderString = model!.doctorSex == "M" ? "DoctorPlacehoderMan" : "DoctorPlacehoderWoman"
                iconView.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: placehoderString))
                nameLabel.text = model!.doctorName
                if model!.isAbout == true {
                    stateIconView.backgroundColor = rgbColor(121, g: 234, b: 117)
                    stateLabel.text = kThereIsNo
                    stateLabel.textColor = rgb51
                } else {
                    stateIconView.backgroundColor = rgbSameColor(153)
                    stateLabel.text = kThis
                    stateLabel.textColor = rgb153
                }
                deparmentPositionLabel.text = "\(model!.doctorDeparment) \(model!.doctorPosition)"
                goodsLabel.text = model!.goods
            }
        }
    }
    
    class func setupDeparmentDoctorListCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> DeparmentDoctorListCell {
    
        var cell = tableView.dequeueReusableCell(withIdentifier: DeparmentDoctorListCellIdentifier) as? DeparmentDoctorListCell
        if cell == nil {
            cell = DeparmentDoctorListCell(style: .default, reuseIdentifier: DeparmentDoctorListCellIdentifier)
            cell!.selectionStyle = .none
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(stateIconView)
        contentView.addSubview(stateLabel)
        contentView.addSubview(deparmentPositionLabel)
        contentView.addSubview(goodsLabel)
        contentView.addSubview(line)

        
        iconView.frame = CGRect(x: 15, y: 21, width: 45, height: 45)
        let nameLabelX = iconView.frame.maxX + 15
        nameLabel.frame = CGRect(x: nameLabelX, y: 17, width: 200, height: 22)
        
        let stateLabelW: CGFloat = 31
        let stateLabelX: CGFloat = kScreenWidth - 15 - stateLabelW
        stateLabel.frame = CGRect(x: stateLabelX, y: 19, width: stateLabelW, height: 18)
        
        let stateIconViewWH: CGFloat = 6
        let stateIconViewX: CGFloat = stateLabel.frame.minX - stateIconViewWH
        let stateIconViewY: CGFloat = 25
        stateIconView.frame = CGRect(x: stateIconViewX, y: stateIconViewY, width: stateIconViewWH, height: stateIconViewWH)
        
        let deparmentPositionLabelW = kScreenWidth - 15 - nameLabelX
        deparmentPositionLabel.frame = CGRect(x: nameLabelX, y: nameLabel.frame.maxY + 1, width: deparmentPositionLabelW, height: 18)
        
        goodsLabel.frame = CGRect(x: nameLabelX, y: deparmentPositionLabel.frame.maxY + 6, width: deparmentPositionLabelW, height: 18)
        
        let cellH: CGFloat = 100
        line.frame = CGRect(x: 15, y: cellH - 0.5, width: kScreenWidth - 30, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 22.5
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font16
        return lbl
    }()
    
    private lazy var stateIconView: UIView = {
        let vw = UIView()
        vw.layer.cornerRadius = 3
        vw.clipsToBounds = true
        return vw
    }()

    private lazy var stateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = font13
        lbl.textAlignment = .right
        return lbl
    }()
    
    
    private lazy var deparmentPositionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb153
        lbl.font = font13
        return lbl
    }()
    
    private lazy var goodsLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font13
        return lbl
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
}
