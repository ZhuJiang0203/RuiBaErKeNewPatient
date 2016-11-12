//
//  ShoppingMallController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

private let kShoppingMallControllerCollectionCellReuseIdentifier = "ShoppingMallControllerCollectionCellReuseIdentifier"

let ShoppingMallCtlTopScrollViewH = (kScreenWidth/320.0)*130
// 彩虹币、兑换记录 模块
private let backViewH: CGFloat = 40


class ShoppingMallController: BaseViewController {
    
    fileprivate var topView: UIView?
    fileprivate var topScrollView: UIScrollView?
    // 轮播的数据
    fileprivate var recommendGoods = [Goods]()
    /// 彩虹币
    fileprivate var rainbowButton: UIButton?
    fileprivate var myRainbowNumber = 0

    /// 兑换记录
    fileprivate var exchangeButton: UIButton?

    fileprivate var collectionView: UICollectionView?
    // collectionView的数据
    fileprivate var goods = [Goods]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 测试
        for i in 0..<3 {
            let good = Goods()
            good.goodsId = "\(i)"
            good.goodsName = "轮播标题\(i)"
            switch i {
            case 0:
                good.goodsImageString = "http://att.bbs.duowan.com/forum/201502/26/07145918v8xcce2tvy27s8.jpg"
            case 1:
                good.goodsImageString = "http://img04.tooopen.com/images/20131015/sy_42548452881.jpg"
            default:
                good.goodsImageString = "http://pic29.nipic.com/20130510/11580604_130834284120_2.jpg"
            }
            good.price = 300.0
            good.stock = 20
            recommendGoods.append(good)
        }
        
        
        for i in 0..<20 {
            let model = Goods()
            model.goodsId = "\(i)"
            model.goodsName = "标题"
            model.goodsImageString = "http://pic4.nipic.com/20091031/1624052_102919381984_2.jpg"
            model.price = 300.0
            model.stock = 3
            
            goods.append(model)
        }
        collectionView?.reloadData()

        // 创建collectionView
        setupCollectionView()
        
        // 创建topView
        setupTopView()
    }
    
    // MARK:- 创建collectionView
    fileprivate func setupCollectionView() {
       
        // 1. 创建UICollectionViewFlowLayout
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // 1.1 滚动方向
        flowLayout.scrollDirection = .vertical
        // 1.2 设置section的边距
        let insetMargin: CGFloat = 15
        let flowLayoutTop: CGFloat = ShoppingMallCtlTopScrollViewH + backViewH + insetMargin
        let flowLayoutLeft: CGFloat = insetMargin
        let flowLayoutBottom: CGFloat = insetMargin
        let flowLayoutRight: CGFloat = insetMargin
        flowLayout.sectionInset = UIEdgeInsetsMake(flowLayoutTop, flowLayoutLeft, flowLayoutBottom, flowLayoutRight);
        // 1.3 行间距、列间距
        let marginXY: CGFloat = 10
        flowLayout.minimumLineSpacing = marginXY
        flowLayout.minimumInteritemSpacing = marginXY
        // 1.4 item的大小
        let itemW: CGFloat = (kScreenWidth - flowLayoutLeft - flowLayoutRight - marginXY)/2.0
        let itemH: CGFloat = itemW*(230.0/152)
        flowLayout.itemSize = CGSize(width: itemW, height: itemH)
        
        // 2. 创建UICollectionView
        let collectionViewY: CGFloat = 64
        let collectionViewH = kScreenHeight - collectionViewY - 49
        collectionView = UICollectionView(frame: CGRect(x: 0, y: collectionViewY, width: kScreenWidth, height: collectionViewH), collectionViewLayout: flowLayout)
        collectionView!.backgroundColor = rgb244
        collectionView!.dataSource = self
        collectionView!.delegate = self
        //  注册UICollectionViewCell
        collectionView!.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: kShoppingMallControllerCollectionCellReuseIdentifier)
        view.addSubview(collectionView!)
    }
    
    // MARK:- 创建topView
    fileprivate func setupTopView() {
        
        let topViewH = ShoppingMallCtlTopScrollViewH + backViewH
        topView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: topViewH))
        collectionView!.addSubview(topView!)
        
        topScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: ShoppingMallCtlTopScrollViewH))
        topScrollView!.showsHorizontalScrollIndicator = false
        topScrollView!.delegate = self
        topScrollView!.isPagingEnabled = true
        topScrollView!.backgroundColor = UIColor.red
        topView!.addSubview(topScrollView!)

        // 添加轮播模块
        seupShoppingCarouselView()
        
        
        let backView = UIView(frame: CGRect(x:0 , y: ShoppingMallCtlTopScrollViewH, width: kScreenWidth, height: backViewH))
        backView.backgroundColor = UIColor.white
        topView!.addSubview(backView)
        
        /// 彩虹币
        let rainbowButtonW = kScreenWidth/2
        rainbowButton = UIButton(frame: CGRect(x: 0, y: 0, width: rainbowButtonW, height: backViewH))
        rainbowButton!.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        rainbowButton!.setTitle(kRainbowCoin, for: .normal)
        rainbowButton!.setTitleColor(rgbSameColor(76), for: .normal)
        rainbowButton!.titleLabel?.font = font13
        rainbowButton!.setImage(UIImage(named: "CaiHongBiIcon"), for: .normal)
        rainbowButton!.addTarget(self, action: #selector(ShoppingMallController.rainbowButtonClicked as (ShoppingMallController) -> () -> ()), for: .touchUpInside)
        backView.addSubview(rainbowButton!)
        
        /// 兑换记录
        exchangeButton = UIButton(frame: CGRect(x: rainbowButtonW, y: 0, width: rainbowButtonW, height: backViewH))
        exchangeButton!.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        exchangeButton!.setTitle("兑换记录", for: .normal)
        exchangeButton!.setTitleColor(rgbSameColor(76), for: .normal)
        exchangeButton!.titleLabel?.font = font13
        exchangeButton!.setImage(UIImage(named: "DuiHuanJiLuIcon"), for: .normal)
        exchangeButton!.addTarget(self, action: #selector(ShoppingMallController.exchangeButtonClicked), for: .touchUpInside)
        backView.addSubview(exchangeButton!)
        
        let line = UIView(frame: CGRect(x: rainbowButtonW, y: 0, width: 0.5, height: backViewH))
        line.backgroundColor = rgbSameColor(237)
        backView.addSubview(line)
    }
    
    // MARK:- 轮播模块
    fileprivate func seupShoppingCarouselView() {
        
        let carousel = ShoppingCarouselView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: ShoppingMallCtlTopScrollViewH))
        carousel.delegate = self
        carousel.data = recommendGoods
        carousel.backgroundColor = UIColor.orange
        topScrollView!.addSubview(carousel)
    }
    
    
    // MARK: - 彩虹币
    @objc fileprivate func rainbowButtonClicked() {
        let vc = MyRainbowController()
        vc.shopCtl = self
        vc.myRainbowNumber = myRainbowNumber
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - 兑换记录
    @objc fileprivate func exchangeButtonClicked() {
        let view = ExchangeRecordController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    
    
}


extension ShoppingMallController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kShoppingMallControllerCollectionCellReuseIdentifier, for: indexPath) as! GoodsCollectionViewCell
        cell.model = goods[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = ShopDetailsController()
        vc.good = goods[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ShoppingMallController: UIScrollViewDelegate {

}

extension ShoppingMallController: ShoppingCarouselViewDelegate {

    func shoppingCarouselViewCellClicked(_ index: Int) {
        let vc = ShopDetailsController()
        vc.good = recommendGoods[index]
        navigationController?.pushViewController(vc, animated: true)
    }
}
