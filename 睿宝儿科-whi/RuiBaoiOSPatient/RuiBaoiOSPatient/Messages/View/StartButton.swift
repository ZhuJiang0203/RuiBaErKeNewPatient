//
//  StartButton.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/21.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class StartButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
        setImage(UIImage(named: "CHDoctorEvaluation_starUnselectIcon"), for: .normal)
        setImage(UIImage(named: "CHDoctorEvaluation_starSelectIcon"), for: .selected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 取消高亮状态（没什么看不到效果？？？？？？？？？？？？？？？？？？？？？？？？？？？？）
//    override var isHighlighted: Bool {
//        didSet{
//            
//        }
//    }
}
