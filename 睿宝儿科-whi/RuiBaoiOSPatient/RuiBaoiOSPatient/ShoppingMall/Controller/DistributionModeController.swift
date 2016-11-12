//
//  DistributionModeController.swift
//  querendingdan
//
//  Created by whj on 16/6/14.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  选择配送方式

import UIKit

class DistributionModeController: BaseViewController {

    var confirmOrderCtl: ConfirmOrderController?
    var addressModel: ExpressModel?
    var pickUpAddress: String?
    
    var topView: UIView?
    var mainScrollView: UIScrollView?
    var mainScrollViewH: CGFloat = 0
    var expressBtn: UIButton!
    var pickUpBtn: UIButton!
    var expressTableView: UITableView!
    var pickUpTableView: UITableView!
    var tts = ["快递", "自取"]
    
    var expressVC: ExpressTableTableViewController!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "选择配送方式"

        // 创建收货地址等
        setupTopView()
        
        // 创建mainScrollView
        setupMainScrollView()

        // 添加子控制器
        addChildViewControllers()
        
        // 创建添加按钮
        setupAddButton()
    }
    
    // MARK:- 创建收货地址等
    fileprivate func setupTopView () {
        let topViewH: CGFloat = 60
        topView = UIView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: topViewH))
        topView!.backgroundColor = UIColor.white
        view.addSubview(topView!)
        
        let btnW: CGFloat = 80
        let btnH: CGFloat = 30
        let btnY = (topViewH - btnH)/2
        expressBtn = UIButton(frame: CGRect(x: kMargin, y: btnY, width: btnW, height: btnH))
        expressBtn.layer.cornerRadius = 2.5
        expressBtn.clipsToBounds = true
        expressBtn.layer.borderColor = rgbSameColor(186).cgColor
        expressBtn.layer.borderWidth = 0.5
        expressBtn.setTitleColor(rgbSameColor(76), for: .normal)
        expressBtn.setTitleColor(UIColor.white, for: .selected)
        expressBtn.setBackgroundImage(UIImage(named: "SubmitButtonBackImageCornerRadius"), for: .selected)
        expressBtn.setTitle("快递", for: .normal)
        expressBtn.titleLabel?.font = font15
        expressBtn.addTarget(self, action: #selector(DistributionModeController.expressBtnClicked(_:)), for: .touchUpInside)
        topView!.addSubview(expressBtn)
        expressBtn.isSelected = true
        
        pickUpBtn = UIButton(frame: CGRect(x: expressBtn.frame.maxX + kMargin, y: btnY, width: btnW, height: btnH))
        pickUpBtn.layer.cornerRadius = 2.5
        pickUpBtn.clipsToBounds = true
        pickUpBtn.layer.borderColor = rgbSameColor(186).cgColor
        pickUpBtn.layer.borderWidth = 0.5
        pickUpBtn.setTitleColor(rgbSameColor(76), for: .normal)
        pickUpBtn.setTitleColor(UIColor.white, for: .selected)
        pickUpBtn.setBackgroundImage(UIImage(named: "SubmitButtonBackImageCornerRadius"), for: .selected)
        pickUpBtn.setTitle("自取", for: .normal)
        pickUpBtn.titleLabel?.font = font15
        pickUpBtn.addTarget(self, action: #selector(DistributionModeController.pickUpBtnClicked(_:)), for: .touchUpInside)
        topView!.addSubview(pickUpBtn)

    }
    
    // 快递
    func expressBtnClicked(_ btn: UIButton) {
        expressBtn.isSelected = true
        pickUpBtn.isSelected = false
        
        // 改变mainScrollView的contentOffset
        if mainScrollView != nil {
            mainScrollView!.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    // 自取
    func pickUpBtnClicked(_ btn: UIButton) {
        expressBtn.isSelected = false
        pickUpBtn.isSelected = true
        
        // 改变mainScrollView的contentOffset
        mainScrollView!.contentOffset = CGPoint(x: kScreenWidth, y: 0)
        addViewOfOneChildViewController(1)
    }
    
    // MARK:- 创建mainScrollView
    fileprivate func setupMainScrollView() {
        let mainScrollViewY = topView!.frame.maxY + kMargin
        mainScrollViewH = kScreenHeight - mainScrollViewY
        mainScrollView = UIScrollView(frame: CGRect(x: 0, y: mainScrollViewY, width: kScreenWidth, height: mainScrollViewH))
        mainScrollView!.showsHorizontalScrollIndicator = false
        mainScrollView!.alwaysBounceVertical = false
        mainScrollView!.backgroundColor = UIColor.clear
        mainScrollView?.backgroundColor = UIColor.red
        view.addSubview(mainScrollView!)
    }
    
    // MARK:- 添加子控制器
    fileprivate func addChildViewControllers() {
        for i in 0..<tts.count {
            if i == 0 {
                let vc = ExpressTableTableViewController()
                vc.confirmOrderCtl = confirmOrderCtl
                vc.addressModel = addressModel
                addChildViewController(vc)
                expressVC = vc
                
                // 添加控制器的view到mainScrollView
                addViewOfOneChildViewController(i)
            } else {
                let vc = PickUpTableViewController()
                vc.confirmOrderCtl = confirmOrderCtl
                vc.addressModel = addressModel
                vc.pickUpAddress = pickUpAddress
                addChildViewController(vc)
            }
        }
    }

    /// 添加控制器的view
    fileprivate func addViewOfOneChildViewController(_ index: Int) {
        let vc = childViewControllers[index]
        if (vc.view.superview != nil) {
            return
        }
        
        
        let vcViewH = index == 0 ? mainScrollViewH - 40 : mainScrollViewH
        vc.view.frame = CGRect(x: kScreenWidth*CGFloat(index), y: 0, width: kScreenWidth, height: vcViewH)
        mainScrollView!.addSubview(vc.view)
    }
    
    // MARK:- 创建添加按钮
    fileprivate func setupAddButton() {
        let bottomViewH: CGFloat = 40
        let bottomView = UIView(frame: CGRect(x: 0, y: mainScrollViewH - 40, width: kScreenWidth, height: bottomViewH))
        bottomView.backgroundColor = UIColor.white
        mainScrollView!.addSubview(bottomView)
        
        let imgWH: CGFloat = 15
        let titleW: CGFloat = 62
        let titleH: CGFloat = 18
        let imgX = (kScreenWidth - imgWH - titleW)/2
        let imgY = (bottomViewH - imgWH)/2
        let titleX = imgX + imgWH
        let titleY = (bottomViewH - titleH)/2

        let img = UIImageView(frame: CGRect(x: imgX, y: imgY, width: imgWH, height: imgWH))
        img.image = UIImage(named: "ExpressPlus")
        bottomView.addSubview(img)
        
        let ttl = UILabel(frame: CGRect(x: titleX, y: titleY, width: titleW, height: titleH))
        ttl.text = "新增地址"
        ttl.font = font13
        ttl.textColor = rgb50
        ttl.textAlignment = .center
        bottomView.addSubview(ttl)

        img.isUserInteractionEnabled = true
        ttl.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DistributionModeController.bottomViewClicked))
        bottomView.addGestureRecognizer(tap)
    }
    
    // MARK:- 新增地址
    func bottomViewClicked() {
        let vc = AddAddressController()
        vc.title = "新增收货地址"
        vc.okTitle = "保存地址"
        vc.previousCtl = expressVC
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}


