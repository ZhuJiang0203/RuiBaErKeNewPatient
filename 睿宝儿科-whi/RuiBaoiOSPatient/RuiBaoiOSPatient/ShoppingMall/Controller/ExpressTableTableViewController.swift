//
//  ExpressTableTableViewController.swift
//  querendingdan
//
//  Created by whj on 16/6/14.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  配送方式 -> 快递

import UIKit
import AFNetworking
import MBProgressHUD

class ExpressTableTableViewController: UITableViewController {

    // 确认订单
    var confirmOrderCtl: ConfirmOrderController?
    var addressModel: ExpressModel?

    var data = [ExpressModel]()
    var isNeedRefresh = false
    
    var maskingFailed: ExpressMaskingView?
    var maskingNoData: ExpressMaskingView?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 130
        tableView.backgroundColor = rgb244
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none

//        for i in 0..<12 {
//            let mdl = ExpressModel()
//            mdl.expressID = "\(i)"
//            mdl.name = "米苏苏"
//            mdl.phone = "18233323231"
//            mdl.provincialCityCounty = "北京 北京市 昌平区"
//            mdl.specificAddress = "发大水发的说法都是大多数"
//            data.append(mdl)
//            
//            if addressModel != nil {
//                if addressModel?.expressID == mdl.expressID && addressModel?.specificAddress == mdl.specificAddress {
//                    mdl.selected = true
//                }
//            }
//        }
        
        // 加载数据
        toLoadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isNeedRefresh == true {
            isNeedRefresh = false
            
            // 发送请求
            toLoadData()
        }
    }
    
    // MARK:- 加载数据
    fileprivate func toLoadData() {
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
//        let user = CHUserDataHelper.SharedManager.user?.patient
//        let url = CHBaseURl + "/exPressAddress/\(user!.patientId)"
//        print(url)
//        
//        CHNetworking.sharedInstance.GET(url, parameters: nil, success: { (dataTask:NSURLSessionDataTask, object:AnyObject?) in
//            
//            print(object)
//            
//            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//            
//            if (object != nil) {
//                let dict = object as? Dictionary<String, AnyObject>
//                if dict != nil {
//                    
//                    let dics = dict!["values"] as? [NSDictionary]
//                    if dics?.count > 0 {
//                        // 去掉蒙版
//                        self.dismissMaskingView()
//                        
//                        self.data.removeAll()
//                        self.data = ExpressModel.setupExpressModelsWithDictionarys(dics!)
//                        
//                        if self.addressModel != nil {
//                            for i in 0..<self.data.count {
//                                let mdl = self.data[i]
//                                if self.addressModel?.expressID == mdl.expressID && self.addressModel?.specificAddress == mdl.specificAddress {
//                                    mdl.selected = true
//                                }
//                            }
//                        }
//                        
//                        // 刷新数据
//                        self.tableView.reloadData()
//                    } else {
//                        self.loadNoData()
//                    }
//                } else {
//                    self.loadNoData()
//                }
//            } else {
//                self.loadNoData()
//            }
//            
//        }) { (dataTask:NSURLSessionDataTask?, error:NSError) in
//            print(error)
//            self.loadFailed()
//        }
    }
    
    
    /*********************** 以下是数据处理（待整合） **********************/
    
    // MARK:- 加载数据为nil----数据处理
    fileprivate func loadNoData() {
        dismissMaskingView()
        if maskingNoData == nil {
            maskingNoData = ExpressMaskingView.setUpMaskingView(CGRect(x: 0, y: 0, width: kScreenWidth, height: tableView.bounds.size.height), type: ExpressMaskingViewPicture.noData)
            maskingNoData!.delegate = self
        }
        view.addSubview(maskingNoData!)
    }
    
    // MARK:- 加载失败----数据处理
    fileprivate func loadFailed() {
        endMyFreshing()
        if maskingFailed == nil {
            maskingFailed = ExpressMaskingView.setUpMaskingView(CGRect(x: 0, y: 0, width: kScreenWidth, height: tableView.bounds.size.height), type: ExpressMaskingViewPicture.reloadFail)
            maskingFailed!.delegate = self
        }
        view.addSubview(maskingFailed!)
    }
    
    // 结束刷新
    fileprivate func endMyFreshing() {
        MBProgressHUD.hide(for: view, animated: true)
        dismissMaskingView()
    }
    
    // 去掉蒙版
    fileprivate func dismissMaskingView() {
        if maskingFailed?.superview == view {
            maskingFailed?.removeFromSuperview()
        }
        if maskingNoData?.superview == view  {
            maskingNoData?.removeFromSuperview()
        }
    }
    
    /*********************** 以上是数据处理（待整合） **********************/

    
    
    
    
    // MARK:- 确定删除此地址
    fileprivate func determineDelegateThisAddress(_ addressID: String) {
        
        CustomMBProgressHUD.showHUDAndTip("删除中", view: view)
    
//        let url = CHBaseURl + "/exPressAddress/\(addressID)"
//        
//        CHNetworking.sharedInstance.DELETE(url, parameters: nil, success: { (dataTask:NSURLSessionDataTask,object: AnyObject?) in
//
//            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//            
//            print(object)
//            if object != nil {
//                let dict = object as? Dictionary<String, AnyObject>
//                print(dict)
//                if dict != nil {
//                    let state = dict!["status"] as? String
//                    if state  == "SUCCESS" {
//                        
//                        CustomMBProgressHUD.showSuccess("删除成功", view: self.view)
//                        
//                        for mdl in self.data {
//                            if mdl.expressID == addressID {
//                                self.data.removeAtIndex(self.data.indexOf(mdl)!)
//                            }
//                        }
//                        self.tableView.reloadData()
//                        
//                        if self.data.count == 0 {
//                            self.loadNoData()
//                        }
//                        
//                    } else {
//                        CustomMBProgressHUD.showFailed("删除失败", view: self.view)
//                    }
//                } else {
//                    CustomMBProgressHUD.showFailed("删除失败", view: self.view)
//                }
//            } else {
//                CustomMBProgressHUD.showFailed("删除失败", view: self.view)
//            }
//            }, failure: { (dataTask:NSURLSessionDataTask?, error:NSError) in
//                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//                CustomMBProgressHUD.showFailed("删除失败", view: self.view)
//        })
    }

    
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ExpressTableViewCell.setupExpressTableViewCell(tableView, indexPath: indexPath)
        cell.model = data[indexPath.row]
        cell.delegate = self
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
        
        confirmOrderCtl?.addressModel =  data[indexPath.row]
        confirmOrderCtl?.addressChanged = true
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK:- MaskingViewDelegate
extension ExpressTableTableViewController: ExpressMaskingViewDelegate {
    func toTellTheDelegaterToDoSomeThing() {
        MBProgressHUD.showAdded(to: view, animated: true)
        toLoadData()
    }
}

// MARK:- ExpressTableViewCellDelegate
extension ExpressTableTableViewController: ExpressTableViewCellDelegate {
    func changeButtonClicked(_ cell: ExpressTableViewCell) {
//        let vc = AddAddressController()
//        vc.title = "修改收货地址"
//        vc.okTitle = "确定"
//        vc.addressModel = cell.model
//        vc.previousCtl = self
//        print(vc.previousCtl)
//        let nav = UINavigationController(rootViewController: vc)
//        presentViewController(nav, animated: true, completion: nil)
    }
    
    func deleteButtonClicked(_ cell: ExpressTableViewCell) {
        
        let alertController = UIAlertController(title: "", message: "确定要删除此收货地址吗？", preferredStyle: UIAlertControllerStyle.alert)
        let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancle)
        
        let ok = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (action) in
            // 发送网络请求
            let mdl = cell.model
            if mdl != nil {
                self.determineDelegateThisAddress(mdl!.expressID!)
            }
        }
        alertController.addAction(ok)

        present(alertController, animated: true, completion: nil)
    }
}
