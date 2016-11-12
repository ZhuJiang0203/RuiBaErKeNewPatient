//
//  PickUpTableViewController.swift
//  querendingdan
//
//  Created by whj on 16/6/14.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  配送方式 -> 自取

import UIKit


class PickUpTableViewController: UITableViewController {

    // 确认订单
    var confirmOrderCtl: ConfirmOrderController?
    var addressModel: ExpressModel?
    var pickUpAddress: String?

    var data = [ExpressModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 90
        tableView.backgroundColor = rgb244
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        if pickUpAddress != nil {
            let addresses = pickUpAddress?.components(separatedBy: "&&")
            if addresses != nil && addresses?.count ?? 0 > 0 {
                for address in addresses! {
                    let mdl = ExpressModel()
                    mdl.expressID = "-1"
//                    let user = CHUserDataHelper.SharedManager.user?.patient
//                    mdl.name = user!.realName
//                    mdl.phone = user!.mobile
                    mdl.provincialCityCounty = address
                    mdl.specificAddress = "睿宝儿科门诊"
                    mdl.isPickUp = true
                    if addressModel != nil && addressModel?.expressID == mdl.expressID && addressModel?.provincialCityCounty == mdl.provincialCityCounty {
                        mdl.selected = true
                    }
                    data.append(mdl)
                }
            }
        }
        
        if data.count == 0 {
        print(view.bounds.size.height)
           let masking = ExpressMaskingView.setUpMaskingView(CGRect(x: 0, y: 0, width: kScreenWidth, height: view.bounds.size.height - 104), type: ExpressMaskingViewPicture.noData)
            view.addSubview(masking!)
            masking?.btn.isHidden = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PickUpTableViewCell.setupPickUpTableViewCell(tableView, indexPath: indexPath)
        cell.model = data[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        confirmOrderCtl?.addressModel = data[indexPath.row]
        confirmOrderCtl?.addressChanged = true
        _ = navigationController?.popViewController(animated: true)
    }
}

