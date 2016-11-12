//
//  MyRainbowController.swift
//  querendingdan
//
//  Created by whj on 16/6/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  我的彩虹币

import UIKit
import AFNetworking
import MBProgressHUD

class MyRainbowController: BaseViewController {
    
    var myRainbowNumber = 0
    weak var shopCtl: ShoppingMallController?
    
    var tableView: UITableView!
    var data = [MyRainbowModel]()
    var money: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myRainbowNumber = defaults.value(forKey: kRainbowCoinValueKey) as? Int ?? 0
        
        // 创建navigationBar
        setupNavigationBar()

        // 创建tableView
        setupTableView()
        
        // 发送请求
//        toLoadData()
        
        // 假数据
        let coinsArray = defaults.value(forKey: kRainbowCoinsArrayKey) as? [String] ?? [String]()
        let timesArray = defaults.value(forKey: kGetRainbowCoinsTimeArrayKey) as? [String] ?? [String]()
        for i in 0..<coinsArray.count {
            let model = MyRainbowModel()
            model.rainbowID = "\(i)"
            model.rainbowType = "1"
            let time = timesArray[i]
            let timeString = Date.dateWithStr(time) ?? ""
            model.rainbowTime = timeString
            model.rainbowNumber = coinsArray[i]
            data.append(model)
        }
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customNavigationBar.setBackgroundImage(UIImage(named: "MyRainbowNavigationBar"), for: .default)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        customNavigationBar.setBackgroundImage(UIImage(named: ""), for: .default)
   }

    
    // MARK:- 加载数据
    fileprivate func toLoadData() {
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
//        let user = CHUserDataHelper.SharedManager.user?.patient
//        let url = CHBaseURl + "/rainbowCoinLogs/\(user!.patientId)"
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
//                    let dic = dict!["values"] as? Dictionary<String, AnyObject>
//                    if dic != nil {
//                        
//                        let number = "\(dic!["coinTotalNumber"]!)"
//                        print(number)
//                        self.setupCaiHongBinumber(number)
//                        
//                        let dictionarys = dic!["rainbowCoinLogs"] as? [NSDictionary]
//                        if dictionarys?.count > 0 {
//                            self.data.removeAll()
//                            self.data = MyRainbowModel.setupMyRainbowModelsWithDictionarys(dictionarys!)
//                            
//                            // 刷新数据
//                            self.tableView.reloadData()
//                        }
//                    }
//                }
//            }
//
//        }) { (dataTask:NSURLSessionDataTask?, error:NSError) in
//            print(error)
//            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//        }
    }
    

    // MARK:- 创建navigationBar
    fileprivate func setupNavigationBar() {

        title = kMyRainbowCoin

        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        rightBtn.setTitle("获取规则", for: .normal)
        rightBtn.setTitleColor(UIColor.white, for: .normal)
        rightBtn.titleLabel?.font = font13
        rightBtn.contentHorizontalAlignment = .right
        rightBtn.addTarget(self, action: #selector(MyRainbowController.rightBtnClicked), for: .touchUpInside)
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }

    // 获取规则
    func rightBtnClicked() {
        let vc = RainbowRuleiController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.backgroundColor = rgb244
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 55
        tableView.tableHeaderView = setupTableHeaderView()
        view.addSubview(tableView)
    }
    
    // MARK:- 创建tableHeaderView
    fileprivate func setupTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 259))

        let topView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 193))
        header.addSubview(topView)
        topView.backgroundColor = UIColor.white
        
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 108))
        img.image = UIImage(named: "MyRainbowTopIcon")
        topView.addSubview(img)
        
        let iconBackWH: CGFloat = 90
        let iconBackX = (kScreenWidth - iconBackWH)/2
        let iconBackY: CGFloat = 30
        let iconBack = UIView(frame: CGRect(x: iconBackX, y: iconBackY, width: iconBackWH, height: iconBackWH))
        iconBack.backgroundColor = UIColor.white
        iconBack.layer.cornerRadius = iconBackWH/2
        iconBack.clipsToBounds = true
        topView.addSubview(iconBack)
        
        let iconXY: CGFloat = 2
        let iconWH: CGFloat = iconBackWH - iconXY*2
        let icon = UIImageView(frame: CGRect(x: iconXY, y: iconXY, width: iconWH, height: iconWH))
        icon.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "IconPlacehoderGray60"))
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = iconWH/2
        icon.clipsToBounds = true
        iconBack.addSubview(icon)
        
        let name = UILabel(frame: CGRect(x: 0, y: iconBack.frame.maxY + kMargin, width: kScreenWidth, height: 22))
        name.textColor = rgb50
        name.font = font16
        name.text = ""
        name.textAlignment = .center
        topView.addSubview(name)
        
        money = UILabel(frame: CGRect(x: 0, y: name.frame.maxY, width: kScreenWidth, height: 28))
        money.textColor = rgb50
        money.font = font16
        money.textAlignment = .center
        topView.addSubview(money)
        
        let myRainbowNumberString = "\(myRainbowNumber) \(kRainbowCoin)"
        let attributedString = NSMutableAttributedString(string: myRainbowNumberString)
        attributedString.addAttributes([NSForegroundColorAttributeName: rgb153], range: NSMakeRange(myRainbowNumberString.characters.count - 3, 3))
        attributedString.addAttributes([NSFontAttributeName: font13], range: NSMakeRange(myRainbowNumberString.characters.count - 3, 3))
        
        attributedString.addAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)], range: NSMakeRange(0, myRainbowNumberString.characters.count - 4))
        attributedString.addAttributes([NSForegroundColorAttributeName: rgbColor(253, g: 119, b: 142)], range: NSMakeRange(0, myRainbowNumberString.characters.count - 4))
        money.attributedText = attributedString
        
        
        let btnViewH: CGFloat = 56
        let btnView = UIView(frame: CGRect(x: 0, y: topView.frame.maxY, width: kScreenWidth, height: btnViewH))
        btnView.backgroundColor = UIColor.white
        header.addSubview(btnView)
        print(topView.frame.maxY)
        
        let btnW = kScreenWidth/2
        let shopBtn = ShopRecordButton(frame: CGRect(x: 0, y: 0, width: btnW, height: btnViewH))
        shopBtn.setImage(UIImage(named: "RainbowTypeShop"), for: .normal)
        shopBtn.setTitle("积分商城", for: .normal)
        shopBtn.titleLabel?.layer.cornerRadius = 10
        shopBtn.titleLabel?.clipsToBounds = true
        shopBtn.titleLabel?.layer.borderColor = UIColor.black.cgColor
        shopBtn.titleLabel?.layer.borderWidth = 0.5
        shopBtn.titleLabel?.textAlignment = .center
        shopBtn.titleLabel?.backgroundColor = rgbColor(255, g: 119, b: 142)
        shopBtn.addTarget(self, action: #selector(MyRainbowController.shopBtnClicked), for: .touchUpInside)
        btnView.addSubview(shopBtn)
        
        let recordBtn = ShopRecordButton(frame: CGRect(x: btnW, y: 0, width: btnW, height: btnViewH))
        recordBtn.setImage(UIImage(named: "RainbowTypeRecord"), for: .normal)
        recordBtn.setTitle("兑换记录", for: .normal)
        recordBtn.titleLabel?.layer.cornerRadius = 10
        recordBtn.titleLabel?.clipsToBounds = true
        recordBtn.titleLabel?.layer.borderColor = UIColor.black.cgColor
        recordBtn.titleLabel?.layer.borderWidth = 0.5
        recordBtn.titleLabel?.textAlignment = .center
        recordBtn.titleLabel?.backgroundColor = rgbColor(255, g: 218, b: 0)
        recordBtn.addTarget(self, action: #selector(MyRainbowController.recordBtnClicked), for: .touchUpInside)
        btnView.addSubview(recordBtn)
        
        let lineH: CGFloat = 15
        let lineY = (btnViewH - lineH)/2
        let line = UIView(frame: CGRect(x: btnW, y: lineY, width: 0.5, height: lineH))
        line.backgroundColor = lineColor
        btnView.addSubview(line)
        
        return header
    }
    
    // MARK:- 跳转到 积分商城
    func shopBtnClicked() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 跳转到 兑换记录
    func recordBtnClicked() {
        let view = ExchangeRecordController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    // 设置彩虹币数量
    fileprivate func setupCaiHongBinumber(_ number: String) {
        let totalText = "\(number) \(kRainbowCoin)"
        let attributedString = NSMutableAttributedString(string: totalText)
        
        attributedString.addAttributes([NSForegroundColorAttributeName: rgb153], range: NSMakeRange(totalText.characters.count - 3, 3))
        attributedString.addAttributes([NSFontAttributeName: font13], range: NSMakeRange(totalText.characters.count - 3, 3))
        
        attributedString.addAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)], range: NSMakeRange(0, totalText.characters.count - 4))
        attributedString.addAttributes([NSForegroundColorAttributeName: rgbColor(253, g: 119, b: 142)], range: NSMakeRange(0, totalText.characters.count - 4))
        money.attributedText = attributedString
    }
}

extension MyRainbowController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyRainbowCell.setupMyRainbowCell(tableView, indexPath: indexPath)
        cell.model = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
