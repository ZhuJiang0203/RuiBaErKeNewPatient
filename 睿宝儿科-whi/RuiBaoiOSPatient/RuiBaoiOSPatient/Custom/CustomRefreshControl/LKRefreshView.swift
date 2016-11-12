 //
//  LKRefreshView.swift
//  gfdfhgf
//
//  Created by whj on 16/8/5.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

/// 刷新视图 - 负责刷新相关的 UI 显示和动画
class LKRefreshView: UIView {
    
    /// 箭头
    @IBOutlet weak var arrow: UIImageView!
    /// 提示标签
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    class func refreshView() -> LKRefreshView {
        let nib = UINib.init(nibName: "LKRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! LKRefreshView
    }
    
    override func awakeFromNib() {
        refreshState = .normal
    }
    
    
    /// 刷新状态
    var refreshState: LKRefreshState = .normal {
        didSet {
            
            switch refreshState {
            case .normal:
                
                tipLabel.text = kPullDownRefresh
//                frame.size.width = 

                // 恢复状态
                arrow.isHidden = false
                icon.isHidden = true
                
                // 改变箭头方向
                UIView.animate(withDuration: 0.25, animations: { 
                    self.arrow.transform = CGAffineTransform.identity
                })
                
            case .willRefresh:
               
                tipLabel.text = kLetRefresh

                // 改变箭头方向
                UIView.animate(withDuration: 0.25, animations: {
                    self.arrow.transform = self.arrow.transform.rotated(by: CGFloat(M_PI - 0.001))
                })
                
            case .refreshing:
                
                tipLabel.text = kRefreshing
                
                // 隐藏提示图标
                arrow.isHidden = true
                
                // 显示菊花
                icon.isHidden = false
                
                // 添加动画
                icon.image = UIImage(named: "RefreshIcon")
                icon.layer.add(animation, forKey: nil)

            case .refreshSuccess:
                tipLabel.text = kRefreshSuccess

                // 移除动画
                icon.layer.removeAllAnimations()
                
                icon.image = UIImage(named: "RefreshRight")
                
            case .refreshFailed:
                tipLabel.text = kRefreshFailed
                // 移除动画
                icon.layer.removeAllAnimations()
                icon.image = UIImage(named: "RefreshError")

            }
        }
    }

    fileprivate lazy var animation: CABasicAnimation = {
        // 1.创建动画对象
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        
        // 2.设置动画属性
        animation.toValue = 2*M_PI
        animation.duration = 0.5
        animation.repeatCount = MAXFLOAT
        // !!! removedOnCompletion默认：true --->（只要动画执行完毕就会移除动画）!!!
        animation.isRemovedOnCompletion = false
        
        return animation
    }()
}
