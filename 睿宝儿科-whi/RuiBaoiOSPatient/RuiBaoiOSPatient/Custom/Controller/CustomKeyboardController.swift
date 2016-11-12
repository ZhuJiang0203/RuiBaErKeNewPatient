//
//  CustomKeyboardController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/8.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class CustomKeyboardController: UIViewController {

    // block
    fileprivate var callBack: (_ btn: KeyboardSelecteButton)->()
    init(oneallBack: @escaping (_ btn: KeyboardSelecteButton)->()) {
        callBack = oneallBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let pictures = ["Group 8", "Group 10-1", "Group 7 Copy"]
    let texts = [kChoicePicture, kChoiceMakePhone, kTelePhone]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = rgbColor(244, g: 244, b: 246)

        // 1.初始化UI
        setupUI()
    }

    fileprivate func setupUI() {
        // 分割线
        let line = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5))
        line.backgroundColor = lineColor
        view.addSubview(line)
        
        for i in 0..<texts.count {
            let btnY: CGFloat = 15
            let btnWH: CGFloat = 70
            let btn = KeyboardSelecteButton(frame: CGRect(x: (kMargin + btnWH)*CGFloat(i) + kMargin, y: btnY, width: btnWH, height: btnWH))
            btn.tag = i
            btn.setImage(UIImage(named: pictures[i]), for: .normal)
            btn.setTitle(texts[i], for: .normal)
            btn.addTarget(self, action: #selector(CustomKeyboardController.toDoSomeThing(_:)), for: .touchUpInside)
            view.addSubview(btn)
        }
    }
    
    func toDoSomeThing(_ btn: KeyboardSelecteButton) {
        // 通知外界表情被点击了, 并且将当前被点击的按钮传递出去
        callBack(btn)
    }
}
