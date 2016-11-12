//
//  PopoverAnimtor.swift
//  XMGWeibo
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 小码哥. All rights reserved.
//

import UIKit

// 菜单弹出和消失的通知名称
let XMGPopoverAnimatorDidShow = "XMGPopoverAnimatorDidShow"
let XMGPopoverAnimatorDidDismiss = "XMGPopoverAnimatorDidDismiss"

class PopoverAnimator: UIPresentationController,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning
{
    /// 定义属性保存菜单的尺寸
    var presentedFrame: CGRect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
    
    /// 定义变量记录当前是否是展现
    var isPresent: Bool = false
    
    /// MARK: - UIViewControllerTransitioningDelegate
    /// 返回负责自定义转场的对象
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        let pc = PopoverPresentationController(presentedViewController: presented, presenting: presenting)
        pc.presentedFrame = presentedFrame
        return pc
    }
    
    /// 告诉系统谁来负责转场出现的样式
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        // 展现
        isPresent = true
        return self
    }
    
    /// 告诉系统谁来负责转场消失的样式
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        // 消失
        isPresent = false
        return self
    }
    
    /// MARK: - UIViewControllerAnimatedTransitioning
    /// 告诉系统执行转场动画的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        // 暂时用不上
        return 0.25
    }
    /// 告诉系统如何执行转场动画, 无论展现还是消失都会调用这个方法
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        if isPresent{
            print("展现")
            // 1.拿到被弹出的控制器的view
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            
            // 2.将拿到的view添加到容器视图上
            transitionContext.containerView.addSubview(toView)
            
            // 3.执行我们自定义的动画
            toView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            // 锚点
//            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
                toView.transform = CGAffineTransform.identity
                }, completion: { (_) -> Void in
                    // 告诉系统, 自动以转场动画执行完毕
                    transitionContext.completeTransition(true)
            }) 
        } else {
            print("消失")
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
                // 由于CGFloat是不准确的, 所以传入0.0之后没有动画效果
                fromView.transform = CGAffineTransform(scaleX: 1.0, y: 0.000001)
                }, completion: { (_) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
        
    }
}
