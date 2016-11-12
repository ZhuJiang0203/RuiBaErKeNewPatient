//
//  ConsultationListModel.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/7.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class ConsultationListModel: NSObject, NSCoding {
    
    // 会话的唯一标示
    var conversationID: String?
    // 会话模型
    var conversation: EMConversation?
    // 未读书
    var unReadNumber = 0
   
    // 会话的最后一条消息
    var lastMessage: EMMessage?
    // 最后一条消息的 时间
    var time: String?
    // 最后一条消息的 “展示内容”
    var lastContent: String?

    // 用户ID
    var patientID: String?
    // 用户头像
    var iconUrl: String?
    // 用户姓名
    var name: String = ""

    
    
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
    var ConsultTime: String?
    
    // 用户类型（0、患者 1、医生 2、医生助手）
    var UserType: String?
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


    class func setupConsultationListModel(_ item: EMConversation) -> ConsultationListModel? {
        
        LLog(item)
        LLog(item.conversationId)
        LLog(item.unreadMessagesCount)
        LLog(item.lastReceivedMessage())
        
        let model = ConsultationListModel()
       
        // 会话的唯一标识
        model.conversationID = item.conversationId
        LLog(item.conversationId)
        // 会话模型
        model.conversation = item
        // 未读书
        model.unReadNumber = Int(item.unreadMessagesCount)

        // 会话的最后一条信息
        if let lastMsg = item.latestMessage {
            model.lastMessage = lastMsg
           
            // 最后一条消息的 时间
            if lastMsg.timestamp > 0 {
                let timeStr = Date.chatCellTimeStampToString("\(lastMsg.timestamp)")
                model.time = Date.dateWithStr(timeStr)
            }
            
            // 最后一条会话内容
            let body = lastMsg.body // 消息体
            switch body!.type {
            case EMMessageBodyTypeText: // 文本类型
                let txtBody = body as! EMTextMessageBody
                let txt = txtBody.text
                if txt!.hasPrefix("#^!#") { // 分享
                    model.lastContent = "[\(kProfileShareApp)]"
                } else { // 纯文本
                    model.lastContent = txt
                }
            case EMMessageBodyTypeImage: // 图片类型
                let imgBody = body as! EMImageMessageBody
                LLog(imgBody)
                model.lastContent = imgBody.displayName
                LLog("111" + imgBody.thumbnailDisplayName + "111")
            case EMMessageBodyTypeVoice: // 语音类型
                let voiceBody = body as! EMVoiceMessageBody
                model.lastContent = voiceBody.displayName
                LLog(voiceBody.displayName)
                
            default:
                LLog("")
            }
            
            
            // 消息扩展 获取用户信息
            if let dictionary = lastMsg.ext {
                
                model.ConsultOrFollowUp = dictionary["ConsultOrFollowUp"] as? String ?? ""
                model.FollowUpType = dictionary["FollowUpType"] as? String ?? ""
                model.ConsultType = dictionary["ConsultType"] as? String ?? ""
                model.ConsultID = dictionary["ConsultID"] as? String ?? ""
                model.ConsultTime = dictionary["ConsultTime"] as? String ?? ""
                model.UserType = dictionary["UserType"] as? String ?? ""
                
                if model.ConsultOrFollowUp == "0" { // 咨询
                    
                    switch model.ConsultType! {
                    case "0":
                        model.lastContent = "患者等待接诊中"
                    case "1":
                        model.lastContent = kHasBeenWaitingForPatientsToPay
                    case "2":
                        model.lastContent = kConsulting
                    case "3":
                        model.lastContent = kConsultationIsOver
                    default:
                        model.lastContent = ""
                    }
                } else if model.ConsultOrFollowUp == "1" { // 随访
                    if model.FollowUpType == "0" {
                        model.lastContent = kBeingFollowedUp
                    } else if model.FollowUpType == "1" {
                        model.lastContent = kFollowUpIsOver
                    } else {
                        model.lastContent = ""
                    }
                }
            } else {
            
            }
            

            
            
            
            
            
            
            
            
            
            /************************ 获取用户信息 ***********************/
            /************************ 获取用户信息 ***********************/
            /************************ 获取用户信息 ***********************/
            
            // 来自对方的最后一条消息
            if let msg = item.lastReceivedMessage() { // 患者 -> 医生 (患者先给医生发起会话)
                // 消息扩展 获取用户信息
                if let dic = msg.ext {
                    LLog(dic)

                    // 用户ID
                    model.patientID = dic["ID"] as? String ?? ""
                    // 用户头像
                    let headFiles = dic["Icon"] as? String ?? ""
                    model.iconUrl = kBaseUrlString + "files/\(headFiles)/ran.jpg"
                    // 用户姓名
                    model.name = dic["Name"] as? String ?? ""
                    LLog(model.patientID)
                    LLog(model.iconUrl)
                    LLog(model.name)
                }
            } else { // 医生 -> 患者 (医生先给患者发起会话)
                // 以医生id为标志，制作文件路径
                let doctorID = defaults.string(forKey: kPatientIDKey) ?? ""
                let fileName = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentationDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last)! + (doctorID + ".archive")
                // 根据文件路径，取出存储的数据
                if let patients = NSKeyedUnarchiver.unarchiveObject(withFile: fileName) as? [ConsultationListModel] {
                    for pp in patients {
                        if pp.conversationID == model.conversationID {
                            model.patientID = pp.patientID
                            model.iconUrl = pp.iconUrl
                            model.name = pp.name
                        }
                    }
                }
            }
        } else {
            return nil
        }

        return model
    }
    
    
    
    // 分享给患者列表用
    class func setupConsultationListModelWithShare(_ item: EMConversation) -> ConsultationListModel {
        
        let model = ConsultationListModel()
        model.conversationID = item.conversationId
        
        let msg = item.lastReceivedMessage()
        LLog(msg)
        if msg != nil {
            let dic = msg?.ext
            LLog(dic)
            if dic != nil {
                model.patientID = dic!["ID"] as? String ?? "1"
                let headFiles = dic!["Icon"] as? String ?? ""
                model.iconUrl = kBaseUrlString + "headFiles/\(headFiles)/ran.jpg"
                model.name = dic!["Name"] as? String ?? ""
            }
        } else {
            // 以医生id为标志，制作文件路径
            let doctorID = defaults.string(forKey: kPatientIDKey) ?? "1"
            let fileName = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentationDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last)! + (doctorID + ".archive")
            
            // 根据文件路径，取出存储的数据
            let patients = NSKeyedUnarchiver.unarchiveObject(withFile: fileName)
            var pps = [ConsultationListModel]()
            LLog(patients)
            if patients != nil {
                pps = patients as! [ConsultationListModel]
                for pp in pps {
                    if pp.patientID == model.conversationID {
                        model.patientID = pp.patientID
                        model.iconUrl = pp.iconUrl
                        model.name = pp.name
                    }
                }
            }
        }
        
        return model
    }
    
    /**
     *  当一个对象要归档进沙盒中时，就会调用这个方法
     *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
     */
    func encode(with aCoder: NSCoder) {
        aCoder.encode(conversationID, forKey: "conversationID")
        aCoder.encode(patientID, forKey: "patientID")
        aCoder.encode(iconUrl, forKey: "iconUrl")
        aCoder.encode(name, forKey: "name")
    }
    
    /**
     *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
     *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
     */
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        conversationID = aDecoder.decodeObject(forKey: "conversationID") as? String
        patientID = aDecoder.decodeObject(forKey: "patientID") as? String
        iconUrl = aDecoder.decodeObject(forKey: "iconUrl") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    }
}
