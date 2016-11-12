//
//  SelectedPatientController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/23.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class SelectedPatientController: BaseViewController {

    weak var pictureConsultingController: PictureConsultingController?
    
    var tableView: UITableView!
    var patients = [PatientModel]()
    var selectedButton: UIButton?
    var selectedModel: PatientModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = kSelectPatient
        
        // 假数据
        for i in 0..<60 {
            let model = PatientModel()
            model.patientId = "\(i)"
            switch i {
            case 0:
                model.iconUrlString = "http://www.taopic.com/uploads/allimg/100603/52-100603193T20.jpg"
            default:
                model.iconUrlString = "http://pic33.nipic.com/20130923/12712906_181229735000_2.jpg"
            }
            model.name = "小尹\(i)"
            model.sex = "M"
            model.age = "\(i+31)"
            patients.append(model)
        }
        
        // 创建tableView
        setupTableView()
        
        // 创建 确定 按钮
        setupOkButton()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64 - 48), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }

    // MARK:- 创建 确定 按钮
    fileprivate func setupOkButton() {
        
        let okH: CGFloat = 48
        let ok = UIButton(frame: CGRect(x: 0, y: kScreenHeight - okH, width: kScreenWidth, height: okH));
        ok.setTitle(kEnsure, for: .normal)
        ok.setTitleColor(UIColor.white, for: .normal)
        ok.titleLabel?.font = font16
        ok.setBackgroundImage(UIImage(named: "ToEvaluateControllerSubmitBackImage"), for: .normal)
        ok.addTarget(self, action: #selector(SelectedPatientController.okButtonClicked), for: .touchUpInside)
        view.addSubview(ok)
    }
    
    @objc fileprivate func okButtonClicked() {
        pictureConsultingController?.patient = selectedModel
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - 转场动画
    lazy var animator: PopoverAnimator = {
        let animator = PopoverAnimator.init(presentedViewController: self, presenting: nil)
        return animator
    }()
}

extension SelectedPatientController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PatientCell.setupPatientCellWithTableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.delegate = self

        let model = patients[indexPath.row]
        cell.model = model
        if model.patientId == selectedModel?.patientId {
            cell.circle.isSelected = true
            selectedButton = cell.circle
        } else {
            cell.circle.isSelected = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedButton?.isSelected = false
        let cell = tableView.cellForRow(at: indexPath) as! PatientCell
        cell.circle.isSelected = true
        selectedButton = cell.circle
        
        selectedModel = patients[indexPath.row];
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

extension SelectedPatientController: PatientCellDelegate {
    func iconButtonOfPatientCellClicked(_ cell: PatientCell, icon: UIButton) {
        
        let pictures = [cell.model!.iconUrlString]
        let vc = PicturesBrowseController(pictures: pictures, index: 0)
        vc.transitioningDelegate = animator
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        present(vc, animated: true, completion: nil)
    }
}







private let PatientCellIdentifier = "PatientCellIdentifier"

@objc
protocol PatientCellDelegate: NSObjectProtocol {
    @objc optional func iconButtonOfPatientCellClicked(_ cell: PatientCell, icon: UIButton)
}

class PatientCell: UITableViewCell {
    
    weak var delegate: PatientCellDelegate?
    
    var model: PatientModel? {
        didSet{
            if model != nil {
                iconButton.sd_setImage(with: URL(string: model!.iconUrlString), for: .normal, placeholderImage: UIImage(named: "CHDefaultAvatar_45Icon_0"))
                nameLbel.text = model!.name
            }
        }
    }
    
    class func setupPatientCellWithTableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> PatientCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: PatientCellIdentifier) as? PatientCell
        if cell == nil {
            cell = PatientCell(style: .default, reuseIdentifier: PatientCellIdentifier)
            cell!.selectionStyle = .none
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(iconButton)
        contentView.addSubview(nameLbel)
        contentView.addSubview(circle)
        contentView.addSubview(line)

        let cellH: CGFloat = 60
        let iconWH: CGFloat = 45
        let iconY: CGFloat = (cellH - iconWH)/2
        iconButton.frame = CGRect(x: 15, y: iconY, width: iconWH, height: iconWH)
        nameLbel.frame = CGRect(x: iconButton.frame.maxX + 10, y: iconY, width: 200, height: iconWH)
        let circleWH: CGFloat = 20
        let circleX: CGFloat = kScreenWidth - 21 - circleWH
        let circleY: CGFloat = (cellH - circleWH)/2
        circle.frame = CGRect(x: circleX, y: circleY, width: circleWH, height: circleWH)
        line.frame = CGRect(x: 15, y: cellH - 0.5, width: kScreenWidth - 30, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate lazy var iconButton: UIButton = {
        let icon = UIButton()
        icon.imageView?.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 45.0/2.0
        icon.clipsToBounds = true
        icon.addTarget(self, action: #selector(PatientCell.iconButtonClicked(_:)), for: .touchUpInside)
        return icon
    }()
    
    @objc fileprivate func iconButtonClicked(_ btn: UIButton) {
        delegate?.iconButtonOfPatientCellClicked?(self, icon: btn)
    }

    fileprivate lazy var nameLbel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font16
        return lbl
    }()

    lazy var circle: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "CircleButtonGray2020"), for: .normal)
        btn.setImage(UIImage(named: "CircleButtonPink2020"), for: .selected)
        btn.isUserInteractionEnabled = false
        return btn
    }()

    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(237)
        return line
    }()
}







class PatientModel: NSObject {
    
    var patientId = ""
    var iconUrlString = ""
    var name = ""
    var sex = ""
    var age = ""
}







