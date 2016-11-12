//
//  ClinicViewController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/26.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  诊所

import UIKit

class ClinicViewController: BaseViewController {

    private var tableView: UITableView!
    fileprivate var clinics = [ClinicListModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = kClinic
        view.backgroundColor = UIColor.white
        
        // tableView
        setupTableView()
        
        // 测试数据
        for _ in 0..<30 {
            let model = ClinicListModel()
            model.clinicID = "1"
            model.clinicIconUrlString = "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1477036568&di=81bb5ee2cdedb6d7dcdfcd149f54b3c7&src=http://pic2.ooopic.com/13/63/86/08b1OOOPICbb.jpg"
            model.clinicName = "上海睿宝儿科"
            model.clinicAddress = "上海吴浦路88号延展18米"
            clinics.append(model)
        }
        tableView.reloadData()
    }
    
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
}

extension ClinicViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clinics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ClinicCell.setupClinicCell(tableView, cellForRowAtIndexPath: indexPath)
        cell.model = clinics[indexPath.row]
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
        
        let vc = DepartmentsController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


private let ClinicCellIdentifier = "ClinicCellIdentifier"

class ClinicCell: UITableViewCell {
    
    var model: ClinicListModel? {
        didSet{
            if model != nil {
                
                 // progressiveDownload：这个标志可以渐进式下载,显示的图像是逐步在下载
                iconView.sd_setImage(with: URL(string: model!.clinicIconUrlString), placeholderImage: UIImage(named: "RuiBaoPlacehoderIcon"), options: [.progressiveDownload])
                
                nameLabel.text = model!.clinicName
                addressLabel.text = model!.clinicAddress
            }
        }
    }
    
    class func setupClinicCell(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> ClinicCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ClinicCellIdentifier) as? ClinicCell
        if cell == nil {
            cell = ClinicCell(style: .default, reuseIdentifier: ClinicCellIdentifier)
            cell!.selectionStyle = .none
        }
        return cell!
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(line)
        
        let cellH: CGFloat = 100
        let marginX: CGFloat = 15
        iconView.frame = CGRect(x: marginX, y: 10, width: 100, height: 80)
        
        let nameX: CGFloat = iconView.frame.maxX + 10
        let nameW = kScreenWidth - nameX - marginX
        let nameY: CGFloat = 18
        nameLabel.frame = CGRect(x: nameX, y: nameY, width: nameW, height: 22)
        
        let addressLabelH: CGFloat = 20
        let addressLabelY: CGFloat = nameLabel.frame.maxY + 14
        addressLabel.frame = CGRect(x: nameX, y: addressLabelY, width: nameW, height: addressLabelH)
        
        line.frame = CGRect(x: marginX, y: cellH - 0.5, width: kScreenWidth - marginX*2, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        return icon
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb51
        lbl.font = font16
        return lbl
    }()
    
    fileprivate lazy var addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        return lbl
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
}


class ClinicListModel: NSObject {
   
    var clinicID = ""
    var clinicIconUrlString = ""
    var clinicName = ""
    var clinicAddress = ""
}

