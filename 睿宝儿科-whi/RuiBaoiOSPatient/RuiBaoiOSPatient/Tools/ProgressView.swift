//
//  ProgressView.swift
//  XLWBSwift20160314
//
//  Created by whj on 16/4/6.
//  Copyright © 2016年 mifengyiliao. All rights reserved.
//
// 
//  圆形进度条

import UIKit

class ProgressView: UIView {
    
    // 进度值 0.0~1.0
    var progress: CGFloat = 0 {
        didSet{
            // 只要调用setNeedsDisplay就会调用drawRect方法重新绘制
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 底部控件
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.layer.cornerRadius = 16
        bottomView.clipsToBounds = true
        return bottomView
    }()


    // 传入的rect就是当前控件的bounds
    override func draw(_ rect: CGRect) {
        if progress >= 1 {
            return
        }
        
        /**
         * 画圆弧:
         * 1.圆心
         * 2.半径
         * 3.开始的位置
         * 4.结束位置
         */

        // 1.准备数据
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let lineW: CGFloat = 3.0
        let radius = min(rect.width * 0.5, rect.height * 0.5) - lineW/2.0
        let startAngle = -CGFloat(M_PI_2)
        let endAngle = CGFloat(M_PI) * 2 * progress + startAngle
        
        // 2.创建路径
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        // 3.设置属性
        UIColor.white.setStroke()
        path.lineWidth = 3.0
        path.lineCapStyle = CGLineCap.round
        
        // 4.绘制图片
        path.stroke()
    }
}
