//
//  ConslationModel.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class ConslationModel: NSObject {
   
    // 会话唯一标识
    var conslationID = ""
    
    // 每一条消息的唯一标识
    var messageId = ""
    
    // 头像
    var icon = ""

    // 时间
    var time: String? {
        didSet{
            if time != nil {
                let timeAll = Date.chatCellTimeStampToString(time!)
                handerTime = Date.dateWithStr(timeAll)
            }
        }
    }
    var handerTime: String?
    
    var text: String? // 文字
    var pictureString: String? // 图片String
    var voicePath: String? // 语音路径
    var voiceDuration: Int32 = 0 // 语音时长
    
    var message: EMMessage? // 环信消息模型
    
    var shareIcon: UIImage?
    
    
    
    // 咨询 还是 随访（0、咨询 1、随访）
    var ConsultOrFollowUp: String?
    
    // 随访类型（-1、患者给医生留言 0、随访中 1、随访已结束）
    var FollowUpType: String?
    
    // 咨询类型（0、预约 1、接诊 2、咨询 3、咨询结束）
    var ConsultType: String?
    // 默认：“0”（“0”：图文咨询，“1”：语音咨询）
    var IsTelephone = "0"

    // 咨询ID
    var ConsultID: String?
    /**
     * 当ConsultType == 0时，此字段代表的是预约时间；
     * 当ConsultType == 1时，此字段代表的是等待患者付款时间；
     * 当ConsultType == 2 或 3时，此字段代表的是开始咨询时间
     */
    var ConsultTime = ""
    
    
    // 用户类型（0、患者 1、医生 2、医生助手）
    var UserType = ""
    /**
     * 1、医生未接诊，该咨询结束  （医生15分钟后可以发起，患者20分钟后可以发起）
     * 2、医生已接诊，待患者付款  （只有医生在15分钟内才能发起）
     * 3、患者未付款，该咨询结束  （患者15分钟后可以发起，医生20分钟后可以发起）
     * 4、患者已付款，开始咨询   （只有患者在15分钟内才能发起）
     * 5、时间到了，该咨询结束   （患者15分钟后可以发起，医生20分钟后可以发起）
     * 6、医生想患者开启随访     （只有医生在上个咨询结束后 或 上个随访结束后 才能发起）
     * 7、该随访结束            （医生在发起随访后随时可以结束，患者在发起下一个预约时也可以结束）
     */
    var AssistantTip: String?


}
