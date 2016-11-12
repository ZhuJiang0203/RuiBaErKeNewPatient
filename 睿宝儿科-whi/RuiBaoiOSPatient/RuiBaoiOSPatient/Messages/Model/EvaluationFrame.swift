//
//  EvaluationFrame.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/18.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class EvaluationFrame: NSObject {
    
    var phoneFrame: CGRect = CGRect.zero
    var degreeFrame: CGRect = CGRect.zero
    var contentFrame: CGRect = CGRect.zero
    var timeFrame: CGRect = CGRect.zero
    var typeFrame: CGRect = CGRect.zero
    var lineFrame: CGRect = CGRect.zero
    var cellH: CGFloat = 0
    
    var model: Evaluation? {
        didSet{
            if model != nil {
                phoneFrame = CGRect(x: 15, y: 10, width: 90, height: 18)
                degreeFrame = CGRect(x: phoneFrame.maxX, y: 13, width: 70, height: 13)
                let contentW: CGFloat = kScreenWidth - 30
                let contentH = model!.content.calculateTheHeightOfTheString(font14, width: contentW, margin: 6.0, maxRow: 0)
                contentFrame = CGRect(x: 15, y: phoneFrame.maxY + 11, width: contentW, height: contentH)
                let timeY: CGFloat = contentFrame.maxY + 6
                timeFrame = CGRect(x: 15, y: timeY, width: 102, height: 17)
                typeFrame = CGRect(x: timeFrame.maxX, y: timeY, width: 100, height: 17)
                cellH = typeFrame.maxY + 10
                lineFrame = CGRect(x: 0, y: cellH - 0.5, width: kScreenWidth, height: 0.5)
            }
        }
    }

}
