//
//  ShoppingCarouselView.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/29.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit


private let kShoppingCarouselCellIndetefy = "kShoppingCarouselCellIndetefy"
private let kMaxSections = 3 // 共有3组图片

class ShoppingCarouselCell: UICollectionViewCell {
    
    var model: Goods? {
        didSet{
            if model != nil {
                let imgstr = model!.goodsImageString 
                imageView.sd_setImage(with: URL(string: imgstr), placeholderImage: UIImage(named: "RuiBaoPlacehoderIcon"))
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 子控件
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: ShoppingMallCtlTopScrollViewH)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
}


@objc
protocol ShoppingCarouselViewDelegate: NSObjectProtocol {
    @objc optional func shoppingCarouselViewCellClicked(_ index: Int)
}

class ShoppingCarouselView: UIView {
    
    var collectionView: UICollectionView?
    var timer: Timer?
    weak var delegate: ShoppingCarouselViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionViewWithFrame(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionViewWithFrame(_ frame: CGRect) {
        if collectionView == nil {
            // 1. 创建UICollectionViewFlowLayout
            let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            // 1.1 滚动方向
            flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
            // 1.2 行间距、列间距
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.itemSize = frame.size
            // 1.4 设置section的边距
            flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
            // 2. 创建UICollectionView
            collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
            collectionView?.backgroundColor = UIColor.red
            collectionView!.backgroundColor = UIColor.white
            // 2.1 滚动范围
            collectionView!.contentSize = CGSize(width: 0, height: 0)
            collectionView!.isPagingEnabled = true
            // 2.2 设置数据源、代理
            collectionView!.dataSource = self
            collectionView!.delegate = self
            // 2.3 不显示滚动条
            collectionView!.showsHorizontalScrollIndicator = false
            // 2.4 注册UICollectionViewCell
            collectionView!.register(ShoppingCarouselCell.self, forCellWithReuseIdentifier: kShoppingCarouselCellIndetefy)
            addSubview(collectionView!)
        }
    }
    
    var data: [Goods]? {
        didSet{
            if data != nil {
                if data!.count > 1 {
                    collectionView?.isScrollEnabled = true
                    addTimer()
                } else {
                    collectionView?.isScrollEnabled = false
                }
            }
        }
    }
    
    /**
     *  添加定时器
     */
    fileprivate func addTimer() {

        if timer == nil && data!.count > 1 {
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ShoppingCarouselView.nextPage), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    /**
     *  下一页，因为在同一组显示下一张图片，所以可以使用动画
     */
    func nextPage() {
        // 获得中间那一组的IndexPath
        let currentIndexPathReset = resetIndexPath()
        // 如果无数据，则返回，防止crash
        //        if !currentIndexPathReset {
        //            return
        //        }
        
        // 计算出下一个需要展示的位置
        var nextSection = currentIndexPathReset!.section
        var nextItem = currentIndexPathReset!.item + 1;
        if(nextItem == data?.count) {
            // 如果滚动完了某一组，就回到下一组的起点，组数加1.
            nextItem = 0
            nextSection += 1
        }
        let nextIndexPath = IndexPath(item: nextItem, section: nextSection)
        
        // 动画的显示中间那一组的下一张图片，这里可以用动画，因为不是组间的跳转
        collectionView?.scrollToItem(at: nextIndexPath, at: .left, animated: true)
    }
    
    /**
     *  不用动画快速的滚回到中间那一组的同一张图片位置
     */
    func resetIndexPath() -> IndexPath? {
        
//        print(collectionView)
        
        // 获取正在展示的位置
        let currentIndexPath = collectionView!.indexPathForItem(at: CGPoint(x: collectionView!.contentOffset.x, y: 0))
        
//        print(currentIndexPath)
        
        // 如果无数据，则返回，防止crash
        if currentIndexPath == nil {
            return nil
        }
        
        // 马上显示回最中间的那组数据
        let currentIndexPathReset = IndexPath(item: currentIndexPath!.item, section: kMaxSections/2)
        
        // 快速地滚回到中间那一组，所以不能再用动画了。
        collectionView?.scrollToItem(at: currentIndexPathReset, at: .left, animated: false)
        
        return currentIndexPathReset
    }
    
    
    /**
     * 移除定时器
     */
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
}

extension ShoppingCarouselView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return kMaxSections
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kShoppingCarouselCellIndetefy, for: indexPath) as! ShoppingCarouselCell
        cell.model = data?[indexPath.row]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.shoppingCarouselViewCellClicked?(indexPath.row)
    }
    
}



extension ShoppingCarouselView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UICollectionView.self) {
            removeTimer()
            _ = resetIndexPath()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.isKind(of: UICollectionView.self) {
            addTimer()
        }
    }
    
}
