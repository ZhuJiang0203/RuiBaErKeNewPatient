//
//  ConfirmOrderController.swift
//  querendingdan
//
//  Created by whj on 16/6/14.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  确认订单

import UIKit
import AFNetworking
import MBProgressHUD

class ConfirmOrderController: BaseViewController {

    // 商品模型
    var goodData: Goods!
    var previousCtl: ShopDetailsController!
    // 彩虹币
    var rainbowNumber: String!
    
    var addressModel: ExpressModel?
    // 地址是否发生改变
    var addressChanged = false
    
    var mainScrollView: UIScrollView!
    var topView: UIView!
    var name: UILabel! // 收件人姓名
    var phone: UILabel! // 收件人手机号
    var provincialCity: UILabel! // 收件人省市区
    var specificAddress: UILabel! // 收件人具体地址
    var topPlaceHoder: UILabel!
    var total: UILabel!
    
    var orderView: UIView!
    var goodsNumber: UILabel!
    var reduceBtn: UIButton!
    var addBtn: UIButton!
    var totalPrice = 0
    var distributionStyle: UILabel! // 配送方式
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "确认订单"
        view.backgroundColor = rgb244
        
        
//        print(goodData.goodsName)
//        print(goodData.fictitious)
//        print(goodData.price)
//        print(goodData.stock)
//        print(goodData.shelvesTime)
//        print(goodData.goodsImageId)
//        print(goodData.advertisementImageId)
//        print(goodData.desc)
//        print(goodData.limitNumber)
//        print(goodData.homePage)
//        print(goodData.pickUp)
//        print(goodData.pickUpAddress)
//        print(goodData.goodsId)
        
        // 创建mainScrollView
        setupMainScrollView()
        
        if goodData.fictitious == true {
            // 创建收货地址等
            setupTopView()
        }
        
        // 创建订单模块
        setupOrderView()
        
        // 创建确认模块
        setupOKView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if addressChanged == true {
            addressChanged = false
            
            // 更新地址信息
            changeAddressInfos()
        }
    }
    
    fileprivate func changeAddressInfos() {
        
        print(addressModel?.name)
        print(addressModel?.phone)
        print(addressModel?.provincialCityCounty)
        print(addressModel?.specificAddress)
        print(addressModel?.name)

        name.text = addressModel?.name
        phone.text = addressModel?.phone
        provincialCity.text = addressModel?.provincialCityCounty
        specificAddress.text = addressModel?.specificAddress
        topPlaceHoder.isHidden = !(name.text?.isEmpty ?? false)
        distributionStyle.text = addressModel?.isPickUp == true ? "自取" : "快递"
    }

    // MARK:- 创建mainScrollView
    fileprivate func setupMainScrollView() {
        mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.alwaysBounceVertical = true
        view.addSubview(mainScrollView)
    }
    
    // MARK:- 创建收货地址等
    fileprivate func setupTopView () {
        let topViewH: CGFloat = 90
        topView = UIView(frame: CGRect(x: 0, y: kMargin, width: kScreenWidth, height: topViewH))
        topView.backgroundColor = UIColor.white
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConfirmOrderController.topViewClicked))
        topView.addGestureRecognizer(tap)
        mainScrollView.addSubview(topView)
        
        let lineH: CGFloat = 3
        let topLine = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: lineH))
        topLine.image = UIImage(named: "ConfirmOrderLine")
        topView.addSubview(topLine)
        
        let bottomLineY = topViewH - lineH
        let bottomLine = UIImageView(frame: CGRect(x: 0, y: bottomLineY, width: kScreenWidth, height: lineH))
        bottomLine.image = UIImage(named: "ConfirmOrderLine")
        topView.addSubview(bottomLine)
        
        let arrowW: CGFloat = 8
        let arrowH: CGFloat = 15
        let arrowX: CGFloat = kScreenWidth - kMargin - arrowW
        let arrowY: CGFloat = (topViewH - arrowH)/2
        let arrow = UIImageView(frame: CGRect(x: arrowX, y: arrowY, width: arrowW, height: arrowH))
        arrow.image = UIImage(named: "ConfirmOrderArrow")
        topView.addSubview(arrow)
        
        let nameY: CGFloat = 11
        let nameH: CGFloat = 22
        name = UILabel(frame: CGRect(x: kMargin, y: nameY, width: 200, height: nameH))
        name.font = font16
        name.textColor = rgbSameColor(76)
        topView.addSubview(name)
        
        let phoneW: CGFloat = 150
        let phoneX = kScreenWidth - kMargin - arrowW - kMargin - phoneW
        phone = UILabel(frame: CGRect(x: phoneX, y: nameY, width: phoneW, height: nameH))
        phone.font = font16
        phone.textColor = rgbSameColor(76)
        phone.textAlignment = .right
        topView.addSubview(phone)
        
        let provincialCityH: CGFloat = 18
        provincialCity = UILabel(frame: CGRect(x: kMargin, y: name.frame.maxY + 4, width: 200, height: provincialCityH))
        provincialCity.font = font13
        provincialCity.textColor = rgbSameColor(76)
        topView.addSubview(provincialCity)
        
        specificAddress = UILabel(frame: CGRect(x: kMargin, y: provincialCity.frame.maxY + 4, width: 200, height: provincialCityH))
        specificAddress.font = font13
        specificAddress.textColor = rgbSameColor(76)
        topView.addSubview(specificAddress)
        
        // 请选择配送方式
        topPlaceHoder = UILabel(frame: CGRect(x: 0, y: 3, width: kScreenWidth - 2*kMargin, height: 84))
        topPlaceHoder.backgroundColor = UIColor.white
        topPlaceHoder.text = "请选择配送方式"
        topPlaceHoder.font = font16
        topPlaceHoder.textColor = rgb102
        topPlaceHoder.textAlignment = .center
        topView.addSubview(topPlaceHoder)
    }
    
    // MARK:- 选择配送方式
    func topViewClicked() {
        let vc = DistributionModeController()
        vc.confirmOrderCtl = self
        vc.addressModel = addressModel
        
        print(goodData.pickUp)
        print(goodData.pickUpAddress)
        // 是否可自取，自取的地址是什么
        if "\(goodData.pickUp)" == "1" && goodData.pickUpAddress.characters.count == 0 {
            vc.pickUpAddress = goodData.pickUpAddress
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK:- 创建订单模块
    fileprivate func setupOrderView() {
        let orderViewY: CGFloat = goodData.fictitious ? topView.frame.maxY + kMargin : 0
        let orderViewH: CGFloat = goodData.fictitious ? 300 : 252
        orderView = UIView(frame: CGRect(x: 0, y: orderViewY, width: kScreenWidth, height: orderViewH))
        orderView.backgroundColor = UIColor.white
        mainScrollView.addSubview(orderView)
        
        let tipH: CGFloat = 40
        let tip = UILabel(frame: CGRect(x: kMargin, y: 0, width: 100, height: tipH))
        tip.text = "商品"
        tip.textColor = rgbSameColor(76)
        tip.font = font14
        orderView.addSubview(tip)
        
        let cellH: CGFloat = 104
        let cell = UIView(frame: CGRect(x: 0, y: tipH, width: kScreenWidth, height: cellH))
        cell.backgroundColor = rgb244
        orderView.addSubview(cell)
        
        let iconWH: CGFloat = 90
        let iconY = (cellH - iconWH)/2
        let icon = UIImageView(frame: CGRect(x: kMargin, y: iconY, width: iconWH, height: iconWH))
//        let goodID = "\(goodData!.goodsImageId)"
        let url = "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1476241109&di=5549f2b343831062f4c045795073b1ee&src=http://img.sccnn.com/bimg/337/28093.jpg"//CHGetPicUrl + goodID + "/photo.jpg"
        icon.sd_setImage(with: URL.init(string: url), placeholderImage: UIImage(named: "picturePlacehoder"))
        cell.addSubview(icon)
        
        let nameX = icon.frame.maxX + kMargin
        let nameW = kScreenWidth - kMargin - nameX
        let name = UILabel(frame: CGRect(x: nameX, y: 14, width: nameW, height: 22))
        name.text = goodData.goodsName
        name.textColor = rgbSameColor(76)
        name.font = UIFont.boldSystemFont(ofSize: 16)
        cell.addSubview(name)
        
        let money = UILabel(frame: CGRect(x: nameX, y: name.frame.maxY, width: nameW, height: 28))
        money.text = "¥\(goodData.price)"
        money.textColor = rgbColor(253, g: 119, b: 142)
        money.font = UIFont.boldSystemFont(ofSize: 20)
        cell.addSubview(money)
        
        let detail = UILabel(frame: CGRect(x: nameX, y: money.frame.maxY + 9, width: nameW, height: 17))
        detail.text = "\(kRainbowCoin)"
        detail.textColor = rgb153
        detail.font = font12
        cell.addSubview(detail)
        
        let numberViewH: CGFloat = 48
        let numberView = UIView(frame: CGRect(x: 0, y: cell.frame.maxY + kMargin, width: kScreenWidth, height: numberViewH))
        orderView.addSubview(numberView)
        
        let numberTip = UILabel(frame: CGRect(x: kMargin, y: kMargin, width: 100, height: 28))
        numberTip.text = "购买数量"
        numberTip.textColor = rgbSameColor(76)
        numberTip.font = font14
        numberView.addSubview(numberTip)
        
        let addViewW: CGFloat = 96
        let addViewH: CGFloat = 26
        let addViewY = (numberViewH - addViewH)/2
        let addViewX = kScreenWidth - kMargin - addViewW
        let addView = UIView(frame: CGRect(x: addViewX, y: addViewY, width: addViewW, height: addViewH))
        numberView.addSubview(addView)
        
        let btnW: CGFloat = 30
        reduceBtn = UIButton(frame: CGRect(x: 0, y: 0, width: btnW, height: addViewH))
        reduceBtn.setImage(UIImage(named: "ReduceGoods"), for: .normal)
        reduceBtn.addTarget(self, action: #selector(ConfirmOrderController.reduceBtnClicked), for: .touchUpInside)
        reduceBtn.isEnabled = false
        addView.addSubview(reduceBtn)
        
        goodsNumber = UILabel(frame: CGRect(x: 30, y: 0, width: 36, height: addViewH))
        goodsNumber.text = "1"
        goodsNumber.textColor = rgbSameColor(76)
        goodsNumber.font = font14
        goodsNumber.textAlignment = .center
        addView.addSubview(goodsNumber)
        
        addBtn = UIButton(frame: CGRect(x: 66, y: 0, width: btnW, height: addViewH))
        addBtn.setImage(UIImage(named: "AddGoods"), for: .normal)
        addBtn.addTarget(self, action: #selector(ConfirmOrderController.addBtnClicked), for: .touchUpInside)
        addView.addSubview(addBtn)
        
        let line = UIView(frame: CGRect(x: kMargin, y: numberViewH - 0.5, width: kScreenWidth - kMargin, height: 0.5))
        line.backgroundColor = lineColor
        numberView.addSubview(line)
        
        var totalY = numberView.frame.maxY
        if goodData.fictitious {
            let distributionStyleView = UIView(frame: CGRect(x: 0, y: numberView.frame.maxY, width: kScreenWidth, height: numberViewH))
            orderView.addSubview(distributionStyleView)
            
            let distributionStyleTipH: CGFloat = 28
            let distributionStyleTip = UILabel(frame: CGRect(x: kMargin, y: kMargin, width: 100, height: distributionStyleTipH))
            distributionStyleTip.text = "配送方式"
            distributionStyleTip.textColor = rgbSameColor(76)
            distributionStyleTip.font = font14
            distributionStyleView.addSubview(distributionStyleTip)
            
            let distributionStyleW: CGFloat = 28
            let distributionStyleX = kScreenWidth - kMargin - distributionStyleW
            distributionStyle = UILabel(frame: CGRect(x: distributionStyleX, y: kMargin, width: distributionStyleW, height: distributionStyleTipH))
            distributionStyle.textColor = rgbSameColor(76)
            distributionStyle.font = font14
            distributionStyleView.addSubview(distributionStyle)
            
            let line2 = UIView(frame: CGRect(x: kMargin, y: numberViewH - 0.5, width: kScreenWidth - kMargin, height: 0.5))
            line2.backgroundColor = lineColor
            distributionStyleView.addSubview(line2)
            
            totalY = distributionStyleView.frame.maxY
        }

        total = UILabel(frame: CGRect(x: kMargin, y: totalY, width: kScreenWidth - 2*kMargin, height: 50))
        total.textAlignment = .right
        orderView.addSubview(total)
        let totalText = "\(kTotalRainbowCoin)¥\(goodData.price)"
        setupTotalValue(totalText)
    }
    
    fileprivate func setupTotalValue(_ totalText: String!) {
        let attributedString = NSMutableAttributedString(string: totalText)
        attributedString.addAttributes([NSFontAttributeName: font13], range: NSMakeRange(0, 6))
        attributedString.addAttributes([NSForegroundColorAttributeName: rgbSameColor(76)], range: NSMakeRange(0, 6))
        attributedString.addAttributes([NSFontAttributeName: font14], range: NSMakeRange(6, 1))
        attributedString.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 20)], range: NSMakeRange(7, totalText.characters.count - 7))
        attributedString.addAttributes([NSForegroundColorAttributeName: rgbColor(253, g: 119, b: 142)], range: NSMakeRange(6, totalText.characters.count - 6))
        total.attributedText = attributedString
    }
    
    // MARK:- 购买数量 “-”
    func reduceBtnClicked() {
        let number = goodsNumber.text
        var num = Int(number!)!
        num = num - 1
        goodsNumber.text = "\(num)"
        
        // 重置总价
        totalPrice = Int(goodData.price)*Int(num)
        let totalText = "\(kTotalRainbowCoin)¥\(totalPrice)"
        setupTotalValue(totalText)

        if num == 1 {
            reduceBtn.isEnabled = false
        }
        
        addBtn.isEnabled = true
    }
    
    // MARK:- 购买数量 “+”
    func addBtnClicked() {
        let number = goodsNumber.text
        var num = Int(number!)!
        num = num + 1
        goodsNumber.text = "\(num)"
        
        // 重置总价
        totalPrice = Int(goodData.price)*Int(num)
        print(Float(goodData.price))
        print(Float(number!)!)
        print(totalPrice)
        let totalText = "\(kTotalRainbowCoin)¥\(totalPrice)"
        setupTotalValue(totalText)

        if num > 1 {
            reduceBtn.isEnabled = true
        }
        
        let addPrice = Float(goodData.price)*Float(number!)! + Float(goodData.price)
        if addPrice > Float(rainbowNumber) ?? 0 {
            addBtn.isEnabled = false
        }
    }

    // MARK:- 创建确认模块
    fileprivate func setupOKView() {
        let bottomViewY = orderView.frame.maxY + kMargin
        var bottomViewH: CGFloat = 206
        let bottomView = UIView(frame: CGRect(x: 0, y: bottomViewY, width: kScreenWidth, height: bottomViewH))
        bottomView.backgroundColor = UIColor.white
        mainScrollView.addSubview(bottomView)
        
        var imgstr = "OKViewTip5"
        var tipImageViewH: CGFloat = 110.0
        if kScreenWidth == 375 {
            imgstr = "OKViewTip6"
        } else if kScreenWidth == 414 {
            imgstr = "OKViewTip6p"
            tipImageViewH = 73
        }
        print(tipImageViewH)
        let tipImageView = UIImageView(frame: CGRect(x: kMargin, y: kMargin, width: kScreenWidth - 2*kMargin, height: tipImageViewH))
        tipImageView.image = UIImage(named: imgstr)
        bottomView.addSubview(tipImageView)
    
        let okBtn = UIButton(frame: CGRect(x: kMargin, y: tipImageView.frame.maxY + 32, width: kScreenWidth - 2*kMargin, height: 44))
        
        okBtn.setBackgroundImage(UIImage(named: "SubmitButtonBackImageCornerRadius"), for: .normal)
        okBtn.setTitle(kEnsure, for: .normal)
        okBtn.setTitleColor(UIColor.white, for: .normal)
        okBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        okBtn.addTarget(self, action: #selector(ConfirmOrderController.okBtnClicked(_:)), for: .touchUpInside)
        bottomView.addSubview(okBtn)
        
        bottomViewH = okBtn.frame.maxY + kMargin
        if bottomViewH < kScreenHeight - bottomViewY - 64 {
            bottomViewH = kScreenHeight - bottomViewY - 64
        }
        bottomView.frame.size.height = bottomViewH
        mainScrollView.contentSize = CGSize(width: kScreenWidth, height: bottomView.frame.maxY)
    }
    
    // MARK:- 确认
    func okBtnClicked(_ btn: UIButton) {
        
        if addressModel == nil {
            CustomMBProgressHUD.showTipAndHideImmediately("请选择配送方式", details: nil, view: view)
            return
        }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
//        let url = ""//CHBaseURl + "/exchanges"
//        var parm: Dictionary<String, String> = Dictionary()
//        if isMaterialObject {
//            if addressModel!.isPickUp == false { // 快递
//                parm["type"] = "1"
//                parm["addressId"] = addressModel!.expressID ?? "0"
//                parm["getAddress"] = ""
//            } else { // 自取
//                parm["type"] = "0"
//                parm["addressId"] = ""
//                parm["getAddress"] = addressModel!.provincialCityCounty ?? ""
//            }
//        }
//        parm["goodsId"] = "\(goodData.goodsId!)"
//        parm["coinTotalNumber"] = "\(totalPrice)"
//        parm["buyNumber"] = goodsNumber.text!
//        
//        let user = CHUserDataHelper.SharedManager.user?.patient
//        parm["userId"] = "\(user!.patientId)"
//        
//        print(url)
//        print(parm)
//        
//        CHNetworking.sharedInstance.POST(url, parameters: parm, success: { (dataTask:NSURLSessionDataTask, object:AnyObject?) in
//            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//            
//            print(object)
//            if object != nil {
//                let dict = object as? Dictionary<String, AnyObject>
//                if dict != nil {
//                    let state = dict!["status"] as? String
//                    if state  == "SUCCESS" {
//                        
//                        // 通知商品详情界面刷新数据
//                        self.previousCtl.isNeedFresh = true
//                        
//                        CustomMBProgressHUD.showSuccess("提交成功", view: self.view)
//                        
//                        let time: NSTimeInterval = 2.0
//                        let delay = dispatch_time(DISPATCH_TIME_NOW,
//                            Int64(time * Double(NSEC_PER_SEC)))
//                        dispatch_after(delay, dispatch_get_main_queue()) {
//                            
//                            // 发通知
//                            self.previousCtl.shopCtl!.isJuppToCHRecordListViewController = true
//                            
//                            // 跳到兑换记录界面
//                            self.navigationController?.popToRootViewControllerAnimated(false)
//                        }
//                        
//                    } else {
//                        let tip = dict!["message"] as? String ?? "提交失败"
//                        print(dict!["message"])
//                        print(tip)
//                        CustomMBProgressHUD.showTipAndHideImmediately(tip, details: nil, view: self.view)
//                    }
//                } else {
//                    CustomMBProgressHUD.showFailed("提交失败", view: self.view)
//                }
//            } else {
//                CustomMBProgressHUD.showFailed("提交失败", view: self.view)
//            }
//            }, failure: { (dataTask:NSURLSessionDataTask?, error:NSError) in
//                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//                CustomMBProgressHUD.showFailed("提交失败", view: self.view)
//        })
    }
}
