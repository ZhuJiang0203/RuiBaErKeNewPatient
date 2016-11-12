//
//  ExchangeRecordController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/7.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  兑换记录

import UIKit

class ExchangeRecordController: BaseViewController {
    
    var tableView: UITableView?
    var shops = [ExchangeRecord]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "兑换记录"
        view.backgroundColor = rgb244

        // 创建tableView
        setupTableView()
        
        for i in 0..<20 {
            let model = ExchangeRecord()
            model.shopID = "\(i)"
            switch i {
            case 0:
                model.shopIcon = "http://img.taopic.com/uploads/allimg/140720/240470-140H00I43143.jpg"
                model.shopIcon = ""
            case 1:
                model.shopIcon = "http://pic.58pic.com/58pic/13/52/89/058PICY58PICM2b_1024.jpg"
            default:
                model.shopIcon = "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1473221775&di=6ebe27b6174b8be8ac9e41e8f9478f31&src=http://pic1.16pic.com/00/10/20/16pic_1020597_b.jpg"
            }
            model.shopIconPlachoder = "ShopJiaShuJu1"
            model.shopName = "Goo.N 大王面纸"
            model.shopPrice = "360"
            model.shopTime = "2016-09-07"
            model.shopNumber = "1"
            model.shopCode = "8741324123RE23"
            model.shippingStyle = "快递"
            model.receiver = "米苏苏"
            model.address = "北京海淀区中关村鼎好大厦A层太库"
            
            shops.append(model)
        }
        
        tableView!.reloadData()
    }

    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.separatorStyle = .none
        tableView!.rowHeight = 180
        view.addSubview(tableView!)
    }
}

extension ExchangeRecordController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ExchangeRecordCell.setupExchangeRecordCell(tableView, indexPath: indexPath)
        cell.model = shops[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ExchangeDetailsController()
        vc.model = shops[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
