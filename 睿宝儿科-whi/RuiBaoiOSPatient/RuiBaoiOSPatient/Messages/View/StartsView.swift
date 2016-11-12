//
//  StartsView.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/21.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

@objc
protocol StartsViewDelegate: NSObjectProtocol {
    @objc optional func clickedNumberOfStarts(starsView: StartsView, number: Int)
}

class StartsView: UIView {
    
    private var selectedStars = [UIButton]()
    weak var delegate: StartsViewDelegate?

    class func setupStartsView(frame: CGRect, starsNumber: Int) -> StartsView {
        return StartsView(frame: frame, starsNumber: starsNumber)
    }
    
    init(frame: CGRect, starsNumber: Int) {
        super.init(frame: frame)
        
        let starWH: CGFloat = 45
        let starMargin: CGFloat = (kScreenWidth - starWH*CGFloat(starsNumber))/CGFloat(starsNumber + 1)
        for i in 0..<starsNumber {
            let startX = (starWH + starMargin)*CGFloat(i) + starMargin
            let start = StartButton(frame: CGRect(x: startX, y: 0, width: starWH, height: starWH))
            start.tag = i
            start.addTarget(self, action: #selector(StartsView.startClicked(start:)), for: .touchUpInside)
            addSubview(start)
            selectedStars.append(start)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(StartsView.startsViewClicked(tap:)))
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func startsViewClicked(tap: UITapGestureRecognizer) {
        
        let tapPoint = tap.location(in: tap.view)
        
        /// 选中 or 取消选中
        selectedOrCancle(point: tapPoint)
        
        /// 通知代理
        goToNotifyDelegate()
    }

    @objc private func startClicked(start: UIButton) {
        for btn in selectedStars {
            btn.isSelected = btn.tag <= start.tag
        }
        print(start.tag + 1)
        delegate?.clickedNumberOfStarts?(starsView: self, number: start.tag + 1)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for touch: AnyObject in touches {
            
            let t: UITouch = touch as! UITouch
            let point = t.location(in: self)
            print(point)
            
            /// 选中 or 取消选中
            selectedOrCancle(point: point)
        }
    }
    
    // MARK:- 选中 or 取消选中
    private func selectedOrCancle(point: CGPoint) {
        if point.y > 0 && point.y < 45 {
            
            for start in selectedStars {
                start.isSelected = point.x > start.frame.origin.x
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// 通知代理
        goToNotifyDelegate()
    }
    
    // MARK:- 通知代理
    private func goToNotifyDelegate() {
        var number = 0
        for start in selectedStars {
            number = start.isSelected ? number + 1 : number
        }
        print(number)
        delegate?.clickedNumberOfStarts?(starsView: self, number: number)
    }
}
