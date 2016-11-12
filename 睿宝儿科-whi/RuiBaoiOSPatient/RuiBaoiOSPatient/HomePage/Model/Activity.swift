//
//  Activity.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class Activity: NSObject {
    
    var activityId = ""
    /// 文章title
    var title = ""
    /// 图片id
    var imageId = ""
    /// 开始时间
    var startTime = ""
    /// 结束时间
    var endTime = ""
    /// 活动url
    var url = ""
    /// 活动状态：进行中、结束
    var state = ""
}
