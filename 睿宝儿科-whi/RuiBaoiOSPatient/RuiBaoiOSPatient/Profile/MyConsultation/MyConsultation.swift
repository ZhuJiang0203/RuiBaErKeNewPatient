//
//  MyConsultation.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/19.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class MyConsultation: NSObject {
    
    // 咨询id
    var consultationId = ""
    // 医生头像
    var doctorIconString = ""
    // 医生性别
    var doctorSex = ""
    // 医生姓名
    var doctorName = ""
    /**
     * 状态：
     *
     * 1：待接诊
     * 2：待付款
     * 3：咨询中
     * 4：已取消
     * 5：待评价
     * 6：再次咨询
     */
    var consultationState = ""
    // 就诊人
    var patientName = ""
    // 主诉
    var patientComplaint = ""
    // 时间
    var consultationTime = ""
}
