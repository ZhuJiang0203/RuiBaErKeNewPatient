//
//  MemberCardViews.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/10.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

@objc
protocol MemberCardViewsDelegate: NSObjectProtocol {
    @objc optional func memberCardViewsClicked(_ card: CardView?, memberCardViews: MemberCardViews?)
}

class MemberCardViews: UIView {

    var models = [MemberModel]()
    weak var delegate: MemberCardViewsDelegate?
    fileprivate var cardViews = [CardView]()

    
    init(frame: CGRect, members: [MemberModel]) {
        super.init(frame: frame)
        
        models = members
        
        // 创建子控件
        for i in 0..<members.count {
            
            let cardX: CGFloat = (kScreenWidth - kMemberCarViewW)/2
            let cardY: CGFloat = (kScreenHeight - 64 - kMemberCarViewH)/2
            let card = CardView(frame: CGRect(x: cardX, y: cardY, width: kMemberCarViewW, height: kMemberCarViewH))
            card.tag = i
            // 设置卡片的 中心位置、宽度、是否显示（最多显示3张卡片）、各个卡片的颜色
            setupCenterAndWidthOfView(i, cardView: card)
            // 给卡片的子控件赋值
            card.model = models[i]
            // 添加手势
            setupGestureRecognizerOfSuperView(card)
            addSubview(card)
            cardViews.append(card)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  设置卡片的 中心位置、宽度、是否显示（最多显示3张卡片）、各个卡片的颜色
     */
    func setupCenterAndWidthOfView(_ index: Int, cardView: CardView) {
        // 设置 宽度
        let scale = scaleAtIndex(index)
        cardView.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale);
        // 设置 中心位置
        cardView.center = centerAtIndex(index)

        /**
         最多只显示3张
         */
        cardView.isHidden = index < models.count - 3
        
        switch index {
        case models.count - 1:
            cardView.backgroundColor = UIColor.white
        case models.count - 2:
            cardView.backgroundColor = rgbColor(255, g: 162, b: 178)
        case models.count - 3:
            cardView.backgroundColor = rgbColor(254, g: 139, b: 159)
        default:
            cardView.backgroundColor = appMainColor
        }
    }
    
    /**
     *  设置 中心位置
     */
    func centerAtIndex(_ index: Int) -> CGPoint {
        
        let scale = scaleAtIndex(index)
        
        let orginY = (kScreenHeight - 64.0)/2.0
        let marginY = CGFloat(models.count - 1 - index)*10.0
        let offsetY = (1.0 - scale)*kMemberCarViewH/2.0
        let centerY: CGFloat = orginY - marginY - offsetY
        return CGPoint(x: kScreenWidth*0.5, y: centerY)
    }
    
    /**
     *  设置 宽度
     */
    fileprivate func scaleAtIndex(_ index: Int) -> CGFloat {

        var kScale: CGFloat = 1.0
        if index == models.count - 1 {
            kScale = 1.0
        } else if index == models.count - 2 {
            kScale = 0.8
        } else if index == models.count - 3 {
            kScale = 2.0/3.0
        }
        return kScale
    }
    
    
    
    /**
     *  添加手势
     */
    fileprivate func setupGestureRecognizerOfSuperView(_ vw: CardView) {
        
        if models.count > 1 {
            // 左滑
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MemberCardViews.handleSwipeFrom(_:)))
            leftSwipe.direction = .left
            vw.addGestureRecognizer(leftSwipe)
            
            // 右滑
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MemberCardViews.handleSwipeFrom(_:)))
            rightSwipe.direction = .right
            vw.addGestureRecognizer(rightSwipe)
        }
        
        // 点击
        let tap = UITapGestureRecognizer(target: self, action: #selector(MemberCardViews.tapClicked(_:)))
        vw.addGestureRecognizer(tap)
    }
    
    /**
     左滑、右滑
     */
    @objc fileprivate func handleSwipeFrom(_ recognizer: UISwipeGestureRecognizer) {
        
        let lastCard = cardViews.last
        
        UIView.animate(withDuration: 0.25, animations: { 
            
            if recognizer.direction == .left { // 向左滑动
                lastCard!.center = CGPoint(x: -lastCard!.frame.width/2, y: lastCard!.center.y);
                lastCard!.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_4/2.0));
            } else { // 向右滑动
                lastCard!.center = CGPoint(x: kScreenWidth + lastCard!.frame.width/2, y: lastCard!.center.y);
                lastCard!.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4/2.0));
            }

            }, completion: { (isFinished) in
                
                // 设置最后一个卡片的transform、中心位置、宽度、是否显示（最多显示3张卡片）、各个卡片的颜色（非动画）
                lastCard!.transform = CGAffineTransform.identity;
                self.setupCenterAndWidthOfView(0, cardView: lastCard!)
                
                // 移动self.viewArray的lastObject到第一的位置
                self.cardViews.insert(lastCard!, at: 0)
                self.cardViews.removeLast()
                
                // 设置self.viewArray中各个控件的中心位置、宽度
                for (index, object) in self.cardViews.enumerated() {
                    if index > self.models.count - 3 { //（动画）
                        UIView.animate(withDuration: 0.25, animations: {
                            // 设置卡片
                            self.setupCardViewAndBringToFront(index, cardView: object)
                        })
                    } else { //（非动画）
                        // 设置卡片
                        self.setupCardViewAndBringToFront(index, cardView: object)
                    }
                }
        }) 
    }
    
    /**
     设置卡片
     */
    fileprivate func setupCardViewAndBringToFront(_ index: Int, cardView: CardView) {
        // 设置卡片的 中心位置、宽度、是否显示（最多显示3张卡片）、各个卡片的颜色
        setupCenterAndWidthOfView(index, cardView: cardView)
        bringSubview(toFront: cardView)
    }
    
    /**
     点击
     */
    @objc fileprivate func tapClicked(_ tap: UITapGestureRecognizer) {
        let card = tap.view as? CardView
        delegate?.memberCardViewsClicked?(card, memberCardViews: self)
    }

}
