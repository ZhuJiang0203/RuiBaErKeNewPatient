//
//  RainbowRuleiController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/6/17.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  获取规则

import UIKit

class RainbowRuleiController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "获取规则"
        view.backgroundColor = UIColor.white
        
        
        // 创建mainScrollView
        let mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight))
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.alwaysBounceVertical = true
        mainScrollView.backgroundColor = UIColor.white
        view.addSubview(mainScrollView)
        
        var imgH: CGFloat = 577.5
        var imgstr = "RainbowRulei5"
        if kScreenWidth == 375 {
            imgH = 677
            imgstr = "RainbowRulei6"
        } else if kScreenWidth == 414 {
            imgH = 2242/3
            imgstr = "RainbowRulei6p"
        }
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: imgH))
        imgView.image = UIImage(named: imgstr)
        mainScrollView.addSubview(imgView)
        
        mainScrollView.contentSize = CGSize(width: kScreenWidth, height: imgH + 64)
    }
}
