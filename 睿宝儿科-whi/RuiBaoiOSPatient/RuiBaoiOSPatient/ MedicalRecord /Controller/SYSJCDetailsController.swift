//
//  SYSJCDetailsController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  实验室检查详情

import UIKit

class SYSJCDetailsController: BaseViewController {

    var model: ShiYanShiJianCha!
    
    var keys = ["\(kTime)", "\(kType)", "\(kResult)"]
    var values = [String]()
    
    fileprivate var models = [SYSJCDetailsModel]()
    
    fileprivate var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(kLaboratoryExaminationDetails)"

        // 创建数据
        setupData()
        
        // 创建tableView
        setupTableView()
    }
    
    // MARK:- 创建数据
    fileprivate func setupData() {
        values = [model.jianChaTime, model.jianChaName, model.jieGuo]
        
        for i in 0..<3 {
            let mdl = SYSJCDetailsModel()
            mdl.keyString = keys[i]
            mdl.valueString = values[i]
            models.append(mdl)
        }
    }
    
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40
        tableView.backgroundColor = rgb244
        view.addSubview(tableView)
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension SYSJCDetailsController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SYSJCDetailsCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.model = models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

private class SYSJCDetailsCell: UITableViewCell {
    
    var model: SYSJCDetailsModel? {
        didSet{
            if model != nil {
                key.text = model!.keyString
                value.text = model!.valueString
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.none

        // 添加子控件
        contentView.addSubview(key)
        contentView.addSubview(value)
        contentView.addSubview(line)
        
        let kMar: CGFloat = 15
        let keyValueW: CGFloat = 80
        let keyValueH: CGFloat = 40
        key.frame = CGRect(x: kMar, y: 0, width: keyValueW, height: keyValueH)
//        key.backgroundColor = UIColor.redColor()
        
        let valueX = key.frame.maxX
        let valueW = kScreenWidth - kMar - valueX
        value.frame = CGRect(x: valueX, y: 0, width: valueW, height: keyValueH)
//        value.backgroundColor = UIColor.blueColor()

        line.frame = CGRect(x: 0, y: keyValueH - 0.5, width: kScreenWidth, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var key: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font14
        return lbl
    }()
    
    fileprivate lazy var value: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = font14
        lbl.textColor = rgb51
        return lbl
    }()
    
    lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = rgbSameColor(231)
        return line
    }()
}

private class SYSJCDetailsModel: NSObject {
    var keyString = ""
    var valueString = ""
}
