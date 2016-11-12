//
//  LKRefreshControl.swift
//  gfdfhgf
//
//  Created by whj on 16/8/5.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit


/// 刷新状态切换的临界点
private let LKRefreshOffsetCriticalPoint: CGFloat = 60

enum LKRefreshState {
    case normal // 超过临界点（"下拉可以刷新"）
    case willRefresh // 超过临界点，但还未放手（"松开立即刷新"）
    case refreshing // 超过临界点，并且放手（"正在刷新数据中..."）
    case refreshSuccess // 超过临界点，并且放手（"正在刷新数据中..."）
    case refreshFailed // 超过临界点，并且放手（"正在刷新数据中..."）
}

/// 刷新控件 - 负责刷新相关的‘逻辑’处理
class LKRefreshControl: UIControl {


    // MARK:- 属性
    /**
     *  刷新控件的父视图，下拉刷新控件应该适用于 UITableView && UICollectionView
     */
    fileprivate weak var scrollView: UIScrollView?
    fileprivate lazy var refreshView = LKRefreshView.refreshView()

    // MARK:- 构造函数
    init() {
        super.init(frame: CGRect())
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupUI()
    }
    
    /**
     willMoveToSuperview 在调用addSubView()方法时会调用
     
     - parameter newSuperview: 父视图
     
     - 当添加到父视图的时候，newSuperview 是父视图
     - 当父视图被移除的时候，newSuperview 是nil
     
     */
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        // 判断父视图的类型
        guard let superView = newSuperview as? UIScrollView else {
            return
        }
        
        // 记录父视图
        scrollView = superView
        
        // KVO 监听父视图的 contentOffset
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    // 本视图从父视图上移除
    // 提示：所有的下拉刷新框架都是监听父视图的 contentOffset
    // 所有的框架的 KVO 监听实现思路都是这个！
    override func removeFromSuperview() {
        // 此时，scrollView 为 nil，superView还有值
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
        
        // 此时，scrollView 为 nil，superView 也为 nil
    }
    
    // 所有 KVO 方法会统一调用此方法
    // 在程序中，通常只监听某一个对象的某几个属性，如果属性太多，方法会很乱！
    // 观察者模式，在不需要的时候，都需要释放
    // - 通知中心：如果不释放，什么也不会发生，但是会有内存泄漏，会有多次注册的可能
    // - KVO：如果不释放，会崩溃！
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // contentOffset 的 y 值跟 contentInset 的 top 有关
        print(scrollView?.contentOffset)
        
        guard let sv = scrollView else {
            return
        }
        
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        if height <= 0 {
            return
        }

        self.frame = CGRect(x: 0, y: -height, width: kScreenWidth, height: height)
        
        if sv.isDragging { // 拉拽中
            
            if height > LKRefreshOffsetCriticalPoint && refreshView.refreshState == .normal { // 大于临界点

                print("松开立即刷新")

                refreshView.refreshState = .willRefresh
                
            } else if height <= LKRefreshOffsetCriticalPoint && refreshView.refreshState == .willRefresh { // 小于临界点
              
                print("下拉可以刷新")

                refreshView.refreshState = .normal

            }
            
        } else { // 放手
            
            if refreshView.refreshState == .willRefresh {
              
                print("正在刷新数据中...")
                
                // 开始刷新
                beginRefreshing()
                
                // 发送刷新数据事件
                sendActions(for: .valueChanged)
            }
        }
        
    }
    
    
    
    /**
     开始刷新
     */
    func beginRefreshing() {
        
        guard let sv = scrollView else {
            return
        }

        // 防止下拉刷新、上拉刷新同时进行，引起一些问题
        if refreshView.refreshState == .refreshing {
            return
        }
        
        // 刷新结束之后，需要将状态改回为 .Normal
        refreshView.refreshState = .refreshing
        
        // 让整个刷新视图能够显示出来
        // 解决方法：修改表格的 contentInset
        var inset = sv.contentInset
        inset.top += LKRefreshOffsetCriticalPoint
        UIView.animate(withDuration: 0.25, animations: { 
            sv.contentInset = inset
            }, completion: nil)
    }
    
    /**
     结束刷新
     */
    func endRefreshing(_ isSuccess: Bool, isHideNow: Bool = false) {
        
        guard let sv = scrollView else {
            return
        }
        
        // 判断状态，是否正在刷新，如果不是，直接返回
        if refreshView.refreshState != .refreshing {
            return
        }
        
        if isHideNow == true {
            // 恢复表格视图的 contentInset
            var inset = sv.contentInset
            inset.top -= LKRefreshOffsetCriticalPoint
            sv.contentInset = inset
            refreshView.refreshState = .normal

        } else {
            if isSuccess == true {
                self.refreshView.refreshState = .refreshSuccess
            } else {
                self.refreshView.refreshState = .refreshFailed
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                
                // 恢复表格视图的 contentInset
                var inset = sv.contentInset
                inset.top -= LKRefreshOffsetCriticalPoint
                UIView.animate(withDuration: 0.25, animations: {
                    sv.contentInset = inset
                }, completion: { (_) in
                    // 恢复刷新视图的状态
                    self.refreshView.refreshState = .normal
                }) 
            }
        }
    }
}

extension LKRefreshControl {
    
    func setupUI() {
//        backgroundColor = UIColor.blueColor()
        
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 0)

        // 超出边界不显示
//        clipsToBounds = true
        
        // 添加刷新视图 - 从 xib 加载出来，默认是 xib 中指定的宽高
        addSubview(refreshView)
        
        // 自动布局 - 设置 xib 控件的自动布局，需要指定 宽高 约束
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        // CenterX
        addConstraint(NSLayoutConstraint(
            item: refreshView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        // Bottom
        addConstraint(NSLayoutConstraint(
            item: refreshView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0))
        // Width
        addConstraint(NSLayoutConstraint(
            item: refreshView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: refreshView.bounds.width))
        // Height
        addConstraint(NSLayoutConstraint(
            item: refreshView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: refreshView.bounds.height))

//        NSLayoutConstraint(item: <#T##AnyObject#>, attribute: NSLayoutAttribute, relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##AnyObject?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
    }

}
