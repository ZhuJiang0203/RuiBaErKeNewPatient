//
//  AddAddressController.swift
//  querendingdan
//
//  Created by whj on 16/6/14.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  添加收货地址、修改收货地址

import UIKit
import AFNetworking
import MBProgressHUD
//import NJKWebViewProgress

class AddAddressController: UIViewController {
    
    var addressModel: ExpressModel?
    var previousCtl: ExpressTableTableViewController?
    var okTitle: String?

    fileprivate var mainScrollView: UIScrollView!
    fileprivate var topView: UIView!
    fileprivate var nameTextField: UITextField!
    fileprivate var phoneTextField: UITextField!
    fileprivate var pccValueLabel: UILabel!
    fileprivate var addressTextField: UITextField!
    
    /** 省市县选择器 */
    fileprivate var masking: UIView?
    fileprivate var pickerVw: UIView?

    /** 省市县 */
    fileprivate var provinceIndex: Int = 0
    fileprivate var cityIndex: Int = 0
    fileprivate var countyIndex: Int = 0
    fileprivate var provinceArr = [AnyObject]()
    fileprivate var cityArr = [AnyObject]()
    fileprivate var countyArr = [String]()
    
    fileprivate var pickerH: CGFloat = 212

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = rgb244
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddAddressController.dismissCurrentCtl))
        
        // 获取省市区数据
        getPCCData()
        
        // 创建mainScrollView
        setupMainScrollView()

        // 创建topView
        setupTopView()

        // 创建保存按钮
        setupSaveButton()
    }
    
    func dismissCurrentCtl() {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()

        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- 获取省市区数据
    fileprivate func getPCCData() {
        
        DispatchQueue.global(qos: .default).async {
            let plistPath = Bundle.main.path(forResource: "address", ofType: "plist")
            let dataDictionary = NSMutableDictionary(contentsOfFile: plistPath!)!
            let dataDict = NSDictionary(dictionary: dataDictionary)
            let dataArr = dataDict["address"] as! [[String: AnyObject]]
            let provinceArrs = NSMutableArray(array: dataArr)
            print(provinceArrs)
            
            self.provinceArr = provinceArrs as [AnyObject]
            print(self.provinceArr)
            
            self.reloadCityDatas()
            self.reloadCountyDatas()
        }
    }

    // MARK:- 创建mainScrollView
    fileprivate func setupMainScrollView() {
        mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        mainScrollView!.showsHorizontalScrollIndicator = false
        mainScrollView!.alwaysBounceVertical = true
        view.addSubview(mainScrollView!)
    }
    
    // MARK:- 创建topView
    fileprivate func setupTopView () {
    
        let tipViewH: CGFloat = 210
        topView = UIView(frame: CGRect(x: 0, y: kMargin, width: kScreenWidth, height: 210))
        topView.backgroundColor = UIColor.white
        mainScrollView.addSubview(topView)
        
        
        // 收货人
        let keyW: CGFloat = 60 + kMargin
        let cellH = tipViewH/4
        let nameView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: cellH))
        topView.addSubview(nameView)
        
        let nameKey = UILabel(frame: CGRect(x: kMargin, y: 0, width: keyW, height: cellH))
        nameKey.text = "收货人："
        nameKey.textColor = rgb153
        nameKey.font = font15
        nameView.addSubview(nameKey)
        
        let nameTextFieldX = nameKey.frame.maxX
        let nameTextFieldW = kScreenWidth - kMargin - nameTextFieldX
        nameTextField = UITextField(frame: CGRect(x: nameTextFieldX, y: 0, width: nameTextFieldW, height: cellH))
        nameTextField.borderStyle = UITextBorderStyle.none
        nameTextField.font = font15
        nameTextField.textColor = rgb50
        nameTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        nameView.addSubview(nameTextField)
        
        let nameLine = UIView(frame: CGRect(x: 0, y: cellH - 0.5, width: kScreenWidth, height: 0.5))
        nameLine.backgroundColor = lineColor
        nameView.addSubview(nameLine)
        
        

        // 手机
        let phoneView = UIView(frame: CGRect(x: 0, y: cellH, width: kScreenWidth, height: cellH))
        topView.addSubview(phoneView)
        
        let phoneKey = UILabel(frame: CGRect(x: kMargin, y: 0, width: keyW, height: cellH))
        phoneKey.text = "手   机："
        phoneKey.textColor = rgb153
        phoneKey.font = font15
        phoneView.addSubview(phoneKey)

        phoneTextField = UITextField(frame: CGRect(x: nameTextFieldX, y: 0, width: nameTextFieldW, height: cellH))
        phoneTextField.borderStyle = UITextBorderStyle.none
        phoneTextField.font = font15
        phoneTextField.textColor = rgb50
        phoneTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        phoneTextField.keyboardType = UIKeyboardType.numberPad
        phoneView.addSubview(phoneTextField)
        
        let phoneLine = UIView(frame: CGRect(x: 0, y: cellH - 0.5, width: kScreenWidth, height: 0.5))
        phoneLine.backgroundColor = lineColor
        phoneView.addSubview(phoneLine)
        
        
        
        
        // 省市区
        let pccView = UIView(frame: CGRect(x: 0, y: cellH*2, width: kScreenWidth, height: cellH))
        topView.addSubview(pccView)
        
        let pccKey = UILabel(frame: CGRect(x: kMargin, y: 0, width: keyW, height: cellH))
        pccKey.text = "地   区："
        pccKey.textColor = rgb153
        pccKey.font = font15
        pccView.addSubview(pccKey)
        
        pccValueLabel = UILabel(frame: CGRect(x: nameTextFieldX, y: 0, width: nameTextFieldW, height: cellH))
        pccValueLabel.font = font15
        pccValueLabel.textColor = rgb153
        pccValueLabel.text = "省份 | 城市 | 地区"
        pccView.addSubview(pccValueLabel)
        pccValueLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddAddressController.pccValueLabelClicked))
        pccValueLabel.addGestureRecognizer(tap)
        
        let pccLine = UIView(frame: CGRect(x: 0, y: cellH - 0.5, width: kScreenWidth, height: 0.5))
        pccLine.backgroundColor = lineColor
        pccView.addSubview(pccLine)
        
        
        
        
        // 地址
        let addressView = UIView(frame: CGRect(x: 0, y: cellH*3, width: kScreenWidth, height: cellH))
        topView.addSubview(addressView)
        
        let addressKey = UILabel(frame: CGRect(x: kMargin, y: 0, width: keyW, height: cellH))
        addressKey.text = "地   址："
        addressKey.textColor = rgb153
        addressKey.font = font15
        addressView.addSubview(addressKey)
        
        addressTextField = UITextField(frame: CGRect(x: nameTextFieldX, y: 0, width: nameTextFieldW, height: cellH))
        addressTextField.borderStyle = UITextBorderStyle.none
        addressTextField.font = font15
        addressTextField.textColor = rgb50
        addressTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        addressView.addSubview(addressTextField)
        
        let addressLine = UIView(frame: CGRect(x: 0, y: cellH - 0.5, width: kScreenWidth, height: 0.5))
        addressLine.backgroundColor = lineColor
        addressView.addSubview(addressLine)
        
        
        // 修改收货地址
        if addressModel != nil {
            nameTextField.text = addressModel!.name
            phoneTextField.text = addressModel!.phone
            pccValueLabel.text = addressModel!.provincialCityCounty
            pccValueLabel.textColor = rgb50
            addressTextField.text = addressModel!.specificAddress
        }
    }
    
    // MARK:- 选择 省市区
    func pccValueLabelClicked() {
//        nameTextField.resignFirstResponder()
//        phoneTextField.resignFirstResponder()
//        addressTextField.resignFirstResponder()
        view.endEditing(true)

        addPickVw()
    }
    
    fileprivate func addPickVw() {
        if masking == nil {
            masking = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            masking?.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0.3)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(AddAddressController.cancleBtnClicked))
            masking?.addGestureRecognizer(tap)
        }
        if pickerVw == nil {
            pickerVw = UIView(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: pickerH))
            pickerVw?.backgroundColor = rgb244
            let tap = UITapGestureRecognizer(target: self, action: #selector(AddAddressController.doNothing))
            pickerVw?.addGestureRecognizer(tap)

            let topViewH: CGFloat = 44
            let topview = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: topViewH))
            topview.backgroundColor = UIColor.white
            pickerVw!.addSubview(topview)
            
            let btnW: CGFloat = 55
            let cancleBtn = UIButton(frame: CGRect(x: 0, y: 0, width: btnW, height: topViewH))
            cancleBtn.setTitle("取消", for: .normal)
            cancleBtn.setTitleColor(rgbColor(253, g: 119, b: 142), for: .normal)
            cancleBtn.titleLabel?.font = font16
            cancleBtn.addTarget(self, action: #selector(AddAddressController.cancleBtnClicked), for: .touchUpInside)
            pickerVw!.addSubview(cancleBtn)

            let btn = UIButton(frame: CGRect(x: kScreenWidth - btnW, y: 0, width: btnW, height: topViewH))
            btn.setTitle("完成", for: .normal)
            btn.setTitleColor(rgbColor(253, g: 119, b: 142), for: .normal)
            btn.titleLabel?.font = font15
            btn.addTarget(self, action: #selector(AddAddressController.cityFinished), for: .touchUpInside)
            pickerVw!.addSubview(btn)

            let pickerView = UIPickerView(frame: CGRect(x: 0, y: topview.frame.maxY, width: kScreenWidth, height: pickerH - topViewH))
            pickerView.delegate = self;
            pickerView.dataSource = self;
            pickerVw!.addSubview(pickerView)
            
            masking!.addSubview(self.pickerVw!)
        }
        
        view.addSubview(masking!)
        UIView.animate(withDuration: 0.25, animations: { 
            self.masking!.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0.3)
            self.pickerVw!.frame.origin.y = kScreenHeight - self.pickerH
        }) 
    }
    
    // doNothing
    func doNothing() {
        
    }
    
    func cancleBtnClicked() {
        if self.pickerVw != nil {
            UIView.animate(withDuration: 0.25, animations: {
                self.pickerVw!.frame.origin.y = kScreenHeight
            }, completion: { (_) in
                UIView.animate(withDuration: 0.25, animations: {
                    self.masking!.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0)
                    }, completion: { (_) in
                        self.masking!.removeFromSuperview()
                })
            }) 
        }
    }
    
    func cityFinished() {
        let dic1 = provinceArr[provinceIndex] as! [String: AnyObject]
        let s1 = dic1["name"] as? String
        let dic2 = cityArr[cityIndex] as! [String: AnyObject]
        let s2 = dic2["name"] as? String
        let s3 = countyArr[countyIndex]
        pccValueLabel.text = s1! + " " + s2! + " " + s3
        pccValueLabel.textColor = rgbSameColor(76)

        UIView.animate(withDuration: 0.25, animations: {
            self.pickerVw!.frame.origin.y = kScreenHeight
            }, completion: { (_) in
                UIView.animate(withDuration: 0.25, animations: { 
                    self.masking!.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0)
                    }, completion: { (_) in
                        self.masking!.removeFromSuperview()
                })
        }) 
    }
    
    
    

    
    
    
    
    
    
    // MARK:- 创建保存按钮
    fileprivate func setupSaveButton() {
        let save = UIButton(frame: CGRect(x: kMargin, y: topView.frame.maxY + 64, width: kScreenWidth - 2*kMargin, height: 44))
        save.setBackgroundImage(UIImage(named: "SubmitButtonBackImageCornerRadius"), for: .normal)
        save.setTitle(okTitle ?? "确定", for: .normal)
        save.setTitleColor(UIColor.white, for: .normal)
        save.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        save.addTarget(self, action: #selector(AddAddressController.saveClicked), for: .touchUpInside)
        mainScrollView.addSubview(save)
    }
    
    func saveClicked() {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
        cancleBtnClicked()

        
        if nameTextField.hasText == false {
            CustomMBProgressHUD.showTipAndHideImmediately("", details: "请输入收货人姓名", view: view)
            return
        }
        if phoneTextField.hasText == false {
            CustomMBProgressHUD.showTipAndHideImmediately("", details: "请输入手机号", view: view)
            return
        }
        if pccValueLabel.text?.isEmpty == true {
            CustomMBProgressHUD.showTipAndHideImmediately("", details: "请输入省市区", view: view)
            return
        }
        if addressTextField.hasText == false {
            CustomMBProgressHUD.showTipAndHideImmediately("", details: "请输入详细地址", view: view)
            return
        }
        
        if okTitle == "保存地址" {
            addNewAddress()
        } else {
            changeAddress()
        }
    }
    
    // MARK:- 新增收货地址
    fileprivate func addNewAddress() {
        
        // 发送请求
        CustomMBProgressHUD.showHUDAndTip("保存中", view: view)

//        let url = CHBaseURl + "/exPressAddress"
//
//        var parm: Dictionary<String, String> = Dictionary()
//        let user = CHUserDataHelper.SharedManager.user?.patient
//        parm["userId"] = "\(user!.patientId)"
//        parm["mobile"] = phoneTextField.text
//        parm["region"] = pccValueLabel.text
//        parm["consigneeName"] = nameTextField.text?.stringByReplacingOccurrencesOfString("", withString: " ")
//        parm["detailAddress"] = addressTextField.text
//        
//        print(url)
//        print(parm)
//        
//        CHNetworking.sharedInstance.POST(url, parameters: parm, success: { (dataTask:NSURLSessionDataTask, object:AnyObject?) in
//            
//          
//            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//            
//            print(object)
//           
//            if object != nil {
//                let dict = object as? Dictionary<String, AnyObject>
//                if dict != nil {
//                    let state = dict!["status"] as? String
//                    if state  == "SUCCESS" {
//                        
//                        if self.previousCtl != nil {
//                            self.previousCtl!.isNeedRefresh = true
//                        }
//                        CustomMBProgressHUD.showSuccess("保存成功", view: self.view)
//                        
//                        let time: NSTimeInterval = 2.0
//                        let delay = dispatch_time(DISPATCH_TIME_NOW,
//                            Int64(time * Double(NSEC_PER_SEC)))
//                        dispatch_after(delay, dispatch_get_main_queue()) {
//                            
//                            self.dismissViewControllerAnimated(true, completion: nil)
//                        }
//                        
//                    } else {
//                        let tip = dict!["message"] as? String ?? "保存失败"
//                        print(dict!["message"])
//                        print(tip)
//                        CustomMBProgressHUD.showTipAndHideImmediately(tip, details: nil, view: self.view)
//                    }
//                } else {
//                    CustomMBProgressHUD.showFailed("保存失败", view: self.view)
//                }
//            } else {
//                CustomMBProgressHUD.showFailed("保存失败", view: self.view)
//           
//            }
//           
//            }, failure: { (dataTask:NSURLSessionDataTask?, error:NSError) in
//                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//                CustomMBProgressHUD.showFailed("保存失败", view: self.view)
//        })
    }
    
    // MARK:- 修改收货地址
    fileprivate func changeAddress() {
        
        // 提交给服务器
        CustomMBProgressHUD.showHUDAndTip("保存中", view: view)
        
//        let url = CHBaseURl + "/exPressAddress"
//        var parm: Dictionary<String, String> = Dictionary()
//        parm["exPressAddressId"] = addressModel!.expressID!
//        let user = CHUserDataHelper.SharedManager.user?.patient
//        parm["userId"] = "\(user!.patientId)"
//        parm["mobile"] = phoneTextField.text
//        parm["region"] = pccValueLabel.text
//        parm["consigneeName"] = nameTextField.text?.stringByReplacingOccurrencesOfString("", withString: " ")
//        parm["detailAddress"] = addressTextField.text
//        
//        
//        print(parm)
//        print(url)
//
//        CHNetworking.sharedInstance.PUT(url, parameters: parm) { (response:NSURLResponse, object:AnyObject?, error:NSError?) in
//            
//            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//            
//            print(object)
//            print(error)
//            if object != nil {
//                let dict = object as? Dictionary<String, AnyObject>
//                if dict != nil {
//                    let state = dict!["status"] as? String
//                    if state  == "SUCCESS" {
//                        
//                        if self.previousCtl != nil {
//                            self.previousCtl!.isNeedRefresh = true
//                        }
//                        CustomMBProgressHUD.showSuccess("保存成功", view: self.view)
//                        
//                        let time: NSTimeInterval = 2.0
//                        let delay = dispatch_time(DISPATCH_TIME_NOW,
//                                                  Int64(time * Double(NSEC_PER_SEC)))
//                        dispatch_after(delay, dispatch_get_main_queue()) {
//                            
//                            self.dismissViewControllerAnimated(true, completion: nil)
//                        }
//                        
//                    } else {
//                        let tip = dict!["message"] as? String ?? "保存失败"
//                        print(dict!["message"])
//                        print(tip)
//                        CustomMBProgressHUD.showTipAndHideImmediately(tip, details: nil, view: self.view)
//                    }
//                } else {
//                    CustomMBProgressHUD.showFailed("保存失败", view: self.view)
//                }
//            } else {
//                CustomMBProgressHUD.showFailed("保存失败", view: self.view)
//            }
//        }
    }

    fileprivate func reloadCityDatas() {
        cityArr.removeAll()
        
        let dic = provinceArr[provinceIndex] as! [String: AnyObject]
        print(dic)
        cityArr = dic["sub"] as! [AnyObject]
        print(cityArr)
    }
    
    fileprivate func reloadCountyDatas() {
        countyArr.removeAll()
        
        let dic = cityArr[cityIndex] as! [String: AnyObject]
        print(dic)
        countyArr = dic["sub"] as! [String]
        print(countyArr)
    }
}





extension AddAddressController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0 == component ? self.provinceArr.count : (1 == component ? self.cityArr.count : self.countyArr.count);
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if 0 == component {
            provinceIndex = row
            cityIndex = 0
            countyIndex = 0
            
            // 滚动省份，替换城市、区县数组
            reloadCityDatas()
            reloadCountyDatas()
            
            // 刷新
            pickerView.reloadAllComponents()
            
            // 滚动省份，让城市、区县默认选择第0个
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        } else if 1 == component {
            cityIndex = row
            countyIndex = 0
            
            // 滚动城市，替换区县数组
            reloadCityDatas()
            reloadCountyDatas()
            
            // 刷新
            pickerView.reloadAllComponents()
            
            // 滚动城市，让区县默认选择第0个
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        } else {
            countyIndex = row
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth/3, height: 44))
        lbl.font = font15
        lbl.textColor = rgb50
        lbl.textAlignment = .center
        
        switch component {
        case 0:
            provinceIndex = row;
            let dic = provinceArr[row] as! [String: AnyObject]
            lbl.text = dic["name"] as? String
        case 1:
            cityIndex = row;
            let dic = self.cityArr[row] as! [String: AnyObject]
            lbl.text = dic["name"] as? String
        default:
            countyIndex = row
            lbl.text = self.countyArr[row];
        }
        return lbl;
    }
}
