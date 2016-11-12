//
//  DoctorListModel.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/12.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class DoctorListModel: NSObject {
    var doctorID = ""
    // 医生头像
    var doctorIconUrlString = ""
    // 医生头像（M：男，F：女）
    var doctorSex = ""
    // 医生名称
    var doctorName = ""
    // 状态（是否在线）
    var doctorState = false
    /// 预约挂号：true，在线咨询：false
    var isHideState = false
    // 科室
    var doctorKeShiZhi = ""
    // 职称
    var doctorZhiCheng = ""
    // 擅长
    var doctorGoods = ""
    // 问诊量
    var wenZhenLiang = ""
    // 图文咨询价格
    var TuWenZiXunPrice = ""
    // 在线电话价格
    var zaiXianPhonePrice = ""
}
