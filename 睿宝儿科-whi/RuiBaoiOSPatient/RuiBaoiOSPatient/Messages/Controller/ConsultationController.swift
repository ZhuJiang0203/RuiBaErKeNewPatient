//
//  ConsultationController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/7.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit
import IQKeyboardManager
import MBProgressHUD
//import SnapKit
import AFNetworking
//import MJRefresh
import AVFoundation




class ConsultationController: BaseViewController {
    
    var listModel: ConsultationListModel?
    weak var consultListCtl: ConsultationListController?
    
    // 顶部状态条
    fileprivate var topView: UIView!
    fileprivate var topViewH: CGFloat = 30
    fileprivate var progressTip: UILabel!
    fileprivate var progressBar: UIView!
    fileprivate var startTm = ""
    
    // 等待医生接诊计时
    fileprivate var waitReceptionTimer: Timer?
    fileprivate var waitReceptionTimerIsFirst = true
    // 等着患者支付计时
    fileprivate var waitPayTimer: Timer?
    fileprivate var waitPayTimerIsFirst = true
    // 咨询时间计时
    fileprivate var consultatingTimer: Timer?
    fileprivate var consultatingTimerIsFirst = true

    
    
    // 1、患者等待医生接诊时间 2、等着患者支付时间 3、咨询时间
    fileprivate var timer2Type = "0"
    
    // 目前是咨询还是随访（0、咨询 1、随访）
    fileprivate var ConsultOrFollowUp: String = ""
    // 目前随访类型（0、随访中 1、随访已结束）
    fileprivate var FollowUpType: String = ""
    // 目前咨询类型（0、预约 1、接诊 2、咨询 3、咨询结束）
    fileprivate var ConsultType: String = ""
    // 目前咨询ID
    fileprivate var ConsultID: String = ""
    /**
     * 目前对应的时间：
     *
     * 当ConsultType == 0时，此字段代表的是预约时间；
     * 当ConsultType == 1时，此字段代表的是等待患者付款时间；
     * 当ConsultType == 2 或 3时，此字段代表的是开始咨询时间
     */
    fileprivate var ConsultTime: String = ""


    
    fileprivate var textfield: UITextField!
    fileprivate var toolbar: ConsulationView!
    fileprivate var tableView: UITableView!
//    /// 顶部刷新
//    let header = MJRefreshNormalHeader()
    /// 自定义刷新控件
    fileprivate lazy var refreshControl: LKRefreshControl = LKRefreshControl()

    fileprivate var frameModels = [ConslationFrame]()
//    // 未知偏差（不知道为什么）
//    private var unknownDeviation: CGFloat = -50
    fileprivate var previousOffsetY: CGFloat = 0
    fileprivate var duration: Double = 0
    // 记录语音时长，不可低于1s
    fileprivate var timer: Timer?
    fileprivate var records = 0
    fileprivate var doctorIcon: String!
    fileprivate var doctorName = ""
    fileprivate var huanXinID = ""
    fileprivate var doctorID = ""
    
    // 是否为图片、语音键盘
    fileprivate var isPictureKeybord = false
    
    fileprivate var formatteryMdHms: DateFormatter!
    
    /// 浏览大图片的图片链接数组
    fileprivate var pictures = [String]()
    
    
    
    
    
    // 语音通话界面
    fileprivate var voiceCall: VoiceCallView?
    // 语音通话
    fileprivate var callSession:EMCallSession?
    // 音频？
    fileprivate var audioCategory: String?
    // 扬声器
    fileprivate var ringPlayer: AVAudioPlayer?
    // 计时器
    fileprivate var timeTimer: Timer?
    fileprivate var timeLength = 0
    // 电话图片动态变化
    fileprivate var voiceTimer:Timer?
    fileprivate var voiceImageArray = [
        UIImage.init(named: "CHChatAudio_soundIcon_0"),
        UIImage.init(named: "CHChatAudio_soundIcon_1"),
        UIImage.init(named: "CHChatAudio_soundIcon_2"),
        UIImage.init(named: "CHChatAudio_soundIcon_3")
    ]

    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = listModel?.name

        // 0.医生信息
        setupDoctorInfosAndSomePublicData()
        
        // 1.顶部状态条
        setupTopView()

        // 2.创建键盘
        setupKeyboard()
        
        // 3.创建tableView
        setupTableView()
        
        // 4.从本地获取聊天记录
        EMClient.shared().chatManager.add(self, delegateQueue: nil)
//        EMClient.sharedClient().callManager.addDelegate!(self, delegateQueue: nil)
        
        // 5.下拉刷新 加载数据
        loadData()
        
        // 6. 监听网络电话打进来，放弃第一响应者
        NotificationCenter.default.addObserver(self, selector: #selector(ConsultationController.notificatResignFirstResponder), name: NSNotification.Name(rawValue: kNotificatConsultationControllerResignFirst), object: nil)
    }
    
    @objc fileprivate func notificatResignFirstResponder() {
        textfield.resignFirstResponder()
    }
    
    deinit {
        EMClient.shared().chatManager.remove(self)
//        EMClient.sharedClient().callManager.removeDelegate?(self)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 所有消息已读
//        let error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
//        listModel!.conversation!.markAllMessages(asRead: error)
        listModel!.conversation?.markAllMessagesAsRead()
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        
        VoicePlayTool.stopPlay()
        

        // MARK:- ！！！！！！
        
        // 将计数器的repeats设置为YES的时候，self的引用计数会加1。因此可能会导致self（即viewController）不能release，所以，必须在viewWillAppear的时候，将计数器timer停止，否则可能会导致内存泄露。
        waitReceptionTimer?.invalidate()
        waitReceptionTimer = nil
        waitPayTimer?.invalidate()
        waitPayTimer = nil
        consultatingTimer?.invalidate()
        consultatingTimer = nil
    }
    
    // MARK:- 医生信息
    fileprivate func setupDoctorInfosAndSomePublicData() {

        doctorID = defaults.string(forKey: kPatientIDKey)!
        huanXinID = defaults.string(forKey: kOrganizationIDKey)! + "-" + doctorID
        doctorIcon = defaults.string(forKey: kPatientIconURLStringKey) ?? ""
        doctorName = defaults.string(forKey: kPatientNameKey) ?? ""
        LLog(huanXinID)
        
        LLog(listModel?.conversationID)
        LLog(listModel?.patientID)
        
        formatteryMdHms = DateFormatter()
        formatteryMdHms.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatteryMdHms.locale = Locale(identifier: "zh_CN")
    }

    // MARK:- 下拉刷新 加载数据
//    private func loadData() {
//        header.setRefreshingTarget(self, refreshingAction: #selector(ConsultationController.loadLocalChatRecords))
//        // 现在的版本要用mj_header
//        tableView.mj_header = header
//        // 进入刷新状态
//        tableView.mj_header.beginRefreshing()
//    }

    
    
    /*********************** 自定义刷新控件 **********************/
    
    fileprivate func loadData() {
        refreshControl.addTarget(self, action: #selector(ConsultationController.loadLocalChatRecords), for: .valueChanged)
        tableView!.addSubview(refreshControl)
        
        loadLocalChatRecords()
    }

    
    
    
    // MARK:- 从本地获取聊天记录
    func loadLocalChatRecords() {
        // 从本地获取聊天记录
        /*!
         *  获取一个会话
         *
         *  @param aConversationId  会话ID
         *  @param aType            会话类型
         *  @param aIfCreate        如果不存在是否创建
         *
         *  @result 会话对象 EMConversation
         */
        
        if self.listModel != nil {
            
            let to = self.listModel!.conversationID
            if to != nil {
                
                // 获取一个会话
                let conversation = EMClient.shared().chatManager.getConversation(to!, type: EMConversationTypeChat, createIfNotExist: true)
                LLog(conversation)
                
                /*!
                 *  从数据库加载聊天记录
                 *
                 *  从数据库获取指定数量的消息，取到的消息按时间排序，并且不包含参考的消息，如果参考消息的ID为空，则从最新消息向前取
                 *
                 *  @param aMessageId  参考消息的ID
                 *  @param aLimit      获取的条数
                 *  @param aDirection  消息搜索方向
                 *
                 *  @result 消息列表<EMMessage>
                 */
                var allMsges = [EMMessage]()
                var msgID: String?
                var isScrollToEnd = true
                if frameModels.count > 0 { // 加载最新的 或 加载更多（最多20条）
                    msgID = frameModels.first!.model!.messageId
                    isScrollToEnd = false
                }
                
                conversation!.loadMessagesStart(fromId: msgID, count: 20, searchDirection: EMMessageSearchDirectionUp, completion: { (objs, error) in
                    if error == nil {
                        allMsges = objs as! [EMMessage]
                        self.addToFrameModels(allMsges, isScrollToEnd: isScrollToEnd, isInsert: true)
                    }
                })
//                allMsges = conversation?.loadMoreMessages(fromId: msgID, limit: 20, direction: EMMessageSearchDirectionUp) as! [EMMessage]
                

//                header.endRefreshing()
                refreshControl.endRefreshing(true)
            }
        }
    }
    
    // MARK:- 添加会话Frame模型 文字 图片 语音
    func addToFrameModels(_ allMsges: [EMMessage]?, isScrollToEnd: Bool, isInsert: Bool) {

        if allMsges == nil || allMsges?.count == 0 {
            
            if frameModels.count == 0 {
                progressTip.text = kFollowedUpTip
                view.addSubview(startFollowUpView)
            }
            return
        }
        
        let msgs = addChatModel(allMsges)
        if isInsert == true {
            frameModels = msgs + frameModels
        } else {
            frameModels = frameModels + msgs
        }
        tableView.reloadData()
        
        if isInsert == false || frameModels.count <= 20 {
            // 滚到底部
            scrollToTheEnd(isScrollToEnd)
        }
        
        
        // 拿到最后一条信息，确定界面布局
        if frameModels.count > 0 {
            setupTopViewAndconfirmReceptButton()
        } else {
            progressTip.text = kFollowedUpTip
            view.addSubview(startFollowUpView)
        }
    }
    
    // MARK:- 添加会话模型 文字 图片 语音
    func addChatModel(_ allMsges: [EMMessage]?) -> [ConslationFrame] {
        
        var msgs = [ConslationFrame]()
        
        if allMsges != nil && allMsges!.count > 0 {
            for item in 0..<allMsges!.count {
                let msg = allMsges![item]
                LLog(msg)
                
                let model = ConslationModel()
                
                // 消息的唯一标识
                model.messageId = msg.messageId
                LLog(msg.messageId)
                
                // 消息扩展 获取用户信息
                let dic = msg.ext
                LLog(dic)
                if dic != nil {
                    // 用户类型（0、患者 1、医生 2、医生助手）
                    model.UserType = dic!["UserType"] as? String ?? "1"
                    model.AssistantTip = dic!["AssistantTip"] as? String
                    // 用户头像
                    if model.UserType == "0" { // 患者
                        model.icon = listModel?.iconUrl ?? ""
                    } else if model.UserType == "1" { // 医生
                        model.icon = doctorIcon
                    }
                    
                    // 咨询 还是 随访（0、咨询 1、随访）
                    model.ConsultOrFollowUp = dic!["ConsultOrFollowUp"] as? String ?? "0"
                    // 随访类型（0、随访中 1、随访已结束）
                    model.FollowUpType = dic!["FollowUpType"] as? String ?? "0"
                    // 咨询类型（0、预约 1、接诊 2、咨询 3、咨询结束）
                    model.ConsultType = dic!["ConsultType"] as? String ?? "0"
                    // 咨询ID
                    model.ConsultID = dic!["ConsultID"] as? String ?? "0"
                    /**
                     * 当ConsultType == 0时，此字段代表的是预约时间；
                     * 当ConsultType == 1时，此字段代表的是等待患者付款时间；
                     * 当ConsultType == 2 或 3时，此字段代表的是开始咨询时间
                     */
                    model.ConsultTime = dic!["ConsultTime"] as? String ?? "0"
                }
                model.time = "\(msg.timestamp)"
                
                let msgBody = msg.body
                switch msgBody!.type {
                case EMMessageBodyTypeText:
                    model.text = (msgBody as! EMTextMessageBody).text
                case EMMessageBodyTypeImage:
                    let body = (msgBody as! EMImageMessageBody)
                    if body.remotePath != nil {
                        let url = URL(string: body.remotePath)!
                        LLog(url)
                        model.pictureString = body.remotePath
                        pictures.append(body.remotePath)
                    }
                case EMMessageBodyTypeVoice:
                    let body = msgBody as! EMVoiceMessageBody
                    model.message = msg
                    model.voiceDuration = body.duration
                    var path = body.localPath
                    if path == nil || path!.characters.count == 0 {
                        path = body.remotePath
                    }
                    model.voicePath = path
                default:
                    LLog("其他")
                }
                
                if model.UserType == "2" { // 医生助手
                    let tip = model.AssistantTip ?? ""
                    switch tip {
                    case "1":
                        model.text = kNoAdmissionsTip
                    case "2":
                        model.text = kAdmissionsTip
                    case "3":
                        model.text = kNoPaymentTip
                    case "4":
                        model.text = kHasPaymentTip
                    case "5":
                        model.text = kTimeToTheEndTip
                    case "6":
                        model.text = kDoctorOpenFollowUpTip
                    case "7":
                        model.text = kTheEndOfTheFollowUpTip
                    default:
                        model.text = ""
                    }
                }
                
                let frameMdl = ConslationFrame()
                frameMdl.model = model
                msgs.append(frameMdl)
            }
        }
        
        return msgs
    }
    

    
    
    
    // MARK:- 拿到最后一条信息，确定界面布局
    func setupTopViewAndconfirmReceptButton() {
        
        // 更新最后一条信息
        updateRecordInfos()
        
        let frmMdl = frameModels.last!
        let mdl = frmMdl.model!
        if mdl.ConsultOrFollowUp == "0" { // 咨询
            if mdl.ConsultType == "0" { // 预约
                startTm = mdl.ConsultTime
//                startTm = "2016-07-18 15:08:00"
                forAdmissions()
            } else if mdl.ConsultType == "1" { // 已接诊，待付款
                startTm = mdl.ConsultTime
//                startTm = "2016-07-18 18:13:00"
                haveAdmissionsAndPendingPayment()
            } else if mdl.ConsultType == "2" { // 已付款，开始咨询，咨询中
                startTm = mdl.ConsultTime
//                startTm = "2016-07-18 18:00:00"
                inConsultation()
            } else if mdl.ConsultType == "3" { // 咨询结束
                consultationIsCompleted()
            }
        } else { // 随访
            if mdl.FollowUpType == "-1" { // 患者给医生留言
                patientLeaveAMessageToTheDoctor()
            } else if mdl.FollowUpType == "0" { // 随访中
                followingUp()
            } else { // 随访已结束
                endOfFollowUp()
            }
        }
    }
    
    /******************************* 六大状态 ***************************/
    // MARK:- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 六大状态
    
    // 1、待接诊
    fileprivate func forAdmissions() {
        
        // 停止其他那两个计时器
        waitPayTimer?.invalidate()
        waitPayTimer = nil
        consultatingTimer?.invalidate()
        consultatingTimer = nil

        // 开始计时
        startWaitReceptionTimer()
        
        // 确认接诊按钮
        toolbar.addSubview(confirmReceptView)
        startFollowUpView.removeFromSuperview()
        
        customNavigationItem.rightBarButtonItem = nil
    }
    
    // 2、已接诊，待付款
    fileprivate func haveAdmissionsAndPendingPayment() {
        
        // 停止其他那两个计时器
        waitReceptionTimer?.invalidate()
        waitReceptionTimer = nil
        consultatingTimer?.invalidate()
        consultatingTimer = nil
        
        // 开始计时
        startWaitPayTimer()
        
        // 移除“确认接诊”、“发起随访”模块
        confirmReceptView.removeFromSuperview()
        startFollowUpView.removeFromSuperview()
        
        customNavigationItem.rightBarButtonItem = nil
    }
    
    // 3、已付款，开始咨询，咨询中
    fileprivate func inConsultation() {
        // 停止其他那两个计时器
        waitReceptionTimer?.invalidate()
        waitReceptionTimer = nil
        waitPayTimer?.invalidate()
        waitPayTimer = nil
        
        // 开始计时
        startConsultatingTimer()
        
        // 移除“确认接诊”、“发起随访”模块
        confirmReceptView.removeFromSuperview()
        startFollowUpView.removeFromSuperview()
        
        customNavigationItem.rightBarButtonItem = nil
    }
    
    // 4、咨询完毕
    fileprivate func consultationIsCompleted() {
        // 停止所有计时器
        waitReceptionTimer?.invalidate()
        waitReceptionTimer = nil
        waitPayTimer?.invalidate()
        waitPayTimer = nil
        consultatingTimer?.invalidate()
        consultatingTimer = nil
        
        // 提示内容
        progressTip.text = kConsultationIsOver
        progressBar.frame.size.width = kScreenWidth
        
        // 添加“发起随访”模块 移除“确认接诊”模块
        view.addSubview(startFollowUpView)
        confirmReceptView.removeFromSuperview()
        
        // rightBarButtonItem
        customNavigationItem.rightBarButtonItem = nil
    }
    
    // 5、患者给医生留言
    fileprivate func patientLeaveAMessageToTheDoctor() {
        // 停止所有计时器
        waitReceptionTimer?.invalidate()
        waitReceptionTimer = nil
        waitPayTimer?.invalidate()
        waitPayTimer = nil
        consultatingTimer?.invalidate()
        consultatingTimer = nil
        
        // 提示内容
        progressTip.text = kNewMessageTip
        progressBar.frame.size.width = kScreenWidth
        
        // 添加“发起随访”模块 移除“确认接诊”模块
        confirmReceptView.removeFromSuperview()
        view.addSubview(startFollowUpView)
        
        // rightBarButtonItem
        customNavigationItem.rightBarButtonItem = nil
    }
    
    // 6、开启随访，随访中
    fileprivate func followingUp() {
        // 停止所有计时器
        waitReceptionTimer?.invalidate()
        waitReceptionTimer = nil
        waitPayTimer?.invalidate()
        waitPayTimer = nil
        consultatingTimer?.invalidate()
        consultatingTimer = nil

        // 提示内容
        progressTip.text = kBeingFollowedUp
        progressBar.frame.size.width = kScreenWidth
        
        // 移除“确认接诊”模块、“发起随访”模块
        confirmReceptView.removeFromSuperview()
        startFollowUpView.removeFromSuperview()
        
        // rightBarButtonItem
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(title: kEndFollowUp, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ConsultationController.endFollowUp))
    }
    
    // 7、随访结束
    fileprivate func endOfFollowUp() {
        // 停止所有计时器
        waitReceptionTimer?.invalidate()
        waitReceptionTimer = nil
        waitPayTimer?.invalidate()
        waitPayTimer = nil
        consultatingTimer?.invalidate()
        consultatingTimer = nil

        // 放弃第一响应者
        textfield.resignFirstResponder()
        
        // 提示内容
        progressTip.text = kFollowUpIsOver
        progressBar.frame.size.width = kScreenWidth
        
        // 添加“发起随访”模块 移除“确认接诊”模块
        view.addSubview(startFollowUpView)
        confirmReceptView.removeFromSuperview()
        
        // rightBarButtonItem
        customNavigationItem.rightBarButtonItem = nil
    }
    
   
    // 更新记录信息
    fileprivate func updateRecordInfos() {
        let frmMdl = frameModels.last!
        
        let mdl = frmMdl.model!
        
        // 咨询 还是 随访（0、咨询 1、随访）
        ConsultOrFollowUp = mdl.ConsultOrFollowUp ?? ""
        // 咨询类型（0、预约 1、接诊 2、咨询 3、咨询结束）
        ConsultType = mdl.ConsultType ?? ""
        ConsultID = mdl.ConsultID ?? ""
        
        /**
         * 当ConsultType == 0时，此字段代表的是预约时间；
         * 当ConsultType == 1时，此字段代表的是等待患者付款时间；
         * 当ConsultType == 2 或 3时，此字段代表的是开始咨询时间
         */
        ConsultTime = mdl.ConsultTime 
        // 随访类型（0、随访中 1、随访已结束）
        FollowUpType = mdl.FollowUpType ?? ""
        
        LLog(mdl.ConsultOrFollowUp)
        LLog(mdl.ConsultType)
        LLog(mdl.ConsultTime)
        LLog(mdl.FollowUpType)
    }
    
    
    
    // 等待医生接诊 开始计时
    fileprivate func startWaitReceptionTimer() {
        if waitReceptionTimer == nil {
            waitReceptionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ConsultationController.updateWaitReceptionTime(_:)), userInfo: nil, repeats: true)
            RunLoop.main.add(waitReceptionTimer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    // 等待医生接诊 更新时间
    func updateWaitReceptionTime(_ timer: Timer?) {
        
        if startTm.characters.count != 19 {
            return
        }
        
        if progressTip.text == kHasTimedOut {
            return
        }
        
        // 距离此时此刻的时间差（秒）
        let data = formatteryMdHms.date(from: startTm)
        let ss = Date().timeIntervalSince(data!)
        LLog(ss)
        
        if ss > 15*60 + 1 { // 时间已过、咨询结束
            
            waitReceptionTimer?.invalidate()
            waitReceptionTimer = nil
            
            self.progressTip.text = kHasTimedOut
            UIView.animate(withDuration: 0.25, animations: {
                self.progressBar.frame.size.width = 0
            })
            
            // 以助手身份 医生未接诊，该咨询结束  （医生15分钟后可以发起，患者20分钟后可以发起）
            doctorAssistantInitiateFollowUp("1")
                        
        } else {
            
            self.progressTip.text = String.init(format: "\(kThePatientHasBeenWaiting) %02d:%02d", Int(ss)/60, Int(ss)%60)
            let f = (CGFloat(ss)/(15*60))
            
            if waitReceptionTimerIsFirst == true {
                UIView.animate(withDuration: 0.25, animations: {
                    self.progressBar.frame.size.width = f*kScreenWidth
                })
            } else {
                progressBar.frame.size.width = f*kScreenWidth
            }
        }
        
        waitReceptionTimerIsFirst = false
    }

    
    // 等待患者付款 开始计时
    fileprivate func startWaitPayTimer() {
        if waitPayTimer == nil {
            waitPayTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ConsultationController.updateWaitPayTime(_:)), userInfo: nil, repeats: true)
            RunLoop.main.add(waitPayTimer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    // 等待患者付款 更新时间
    func updateWaitPayTime(_ timer: Timer?) {
        if startTm.characters.count != 19 {
            return
        }
        
        if progressTip.text == kHasTimedOut {
            return
        }

        // 距离此时此刻的时间差（秒）
        let data = formatteryMdHms.date(from: startTm)
        let ss = Date().timeIntervalSince(data!)
        LLog(ss)
        
        if ss > 20*60 + 1 { // 时间已过、咨询结束
            
            waitPayTimer?.invalidate()
            waitPayTimer = nil
            
            self.progressTip.text = kHasTimedOut
            UIView.animate(withDuration: 0.25, animations: {
                self.progressBar.frame.size.width = kScreenWidth
            })

            // 以助手身份 患者未付款，该咨询结束  （患者15分钟后可以发起，医生20分钟后可以发起）
            doctorAssistantInitiateFollowUp("3")
            
        } else {
            self.progressTip.text = String.init(format: "\(kHasBeenWaitingForPatientsToPay) %02d:%02d", Int(ss)/60, Int(ss)%60)
            let f = (CGFloat(ss)/(20*60))
            
            if waitPayTimerIsFirst == true {
                UIView.animate(withDuration: 0.25, animations: {
                    self.progressBar.frame.size.width = f*kScreenWidth
                })
            } else {
                progressBar.frame.size.width = f*kScreenWidth
            }
        }
        
        waitPayTimerIsFirst = false
    }
    
    
    // 咨询中 开始计时
    fileprivate func startConsultatingTimer() {
        if consultatingTimer == nil {
            consultatingTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ConsultationController.updateConsultatingTime(_:)), userInfo: nil, repeats: true)
            RunLoop.main.add(consultatingTimer!, forMode: RunLoopMode.commonModes)
        }
    }

    func updateConsultatingTime(_ timer: Timer?) {
        if startTm.characters.count != 19 {
            return
        }
        
        if progressTip.text == kConsultationIsOver {
            return
        }
        
        // 距离此时此刻的时间差（秒）
        let data = formatteryMdHms.date(from: startTm)
        let ss = Date().timeIntervalSince(data!)
        LLog(ss)
        
        if ss > 15*60 { // 时间已过、咨询结束
            
            consultatingTimer?.invalidate()
            consultatingTimer = nil
            
            self.progressTip.text = kConsultationIsOver
            UIView.animate(withDuration: 0.25, animations: {
                self.progressBar.frame.size.width = kScreenWidth
            })
            
            // 以助手身份 时间到了，该咨询结束   （患者15分钟后可以发起，医生20分钟后可以发起）
            doctorAssistantInitiateFollowUp("5")
            
        } else {
            if ss <= 15*60 + 1 {
                self.progressTip.text = String.init(format: "\(kConsulting) %02d:%02d", Int(ss)/60, Int(ss)%60)
                let f = (CGFloat(ss)/(15*60))
                
                if consultatingTimerIsFirst == true {
                    UIView.animate(withDuration: 0.25, animations: {
                        self.progressBar.frame.size.width = f*kScreenWidth
                    })
                } else {
                    progressBar.frame.size.width = f*kScreenWidth
                }
            }
        }
        
        consultatingTimerIsFirst = false
    }
    
    
    
    
    
    // 确认接诊模块
    fileprivate lazy var confirmReceptView: UIView = {
        let confirmReceptView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
        confirmReceptView.backgroundColor = rgbSameColor(240)
        
        let confirmReceptBtn = UIButton(frame: CGRect(x: 15, y: 8, width: kScreenWidth - 30, height: 34))
        confirmReceptBtn.setBackgroundImage(UIImage(named: kConfirmReceptBtnBack), for: .normal)
        confirmReceptBtn.setTitle(kConfirmationOfReception, for: .normal)
        confirmReceptBtn.titleLabel?.font = font15
        confirmReceptBtn.addTarget(self, action: #selector(ConsultationController.confirmReceptBtnClicked(_:)), for: .touchUpInside)
        confirmReceptView.addSubview(confirmReceptBtn)
        
        return confirmReceptView
    }()
    
    // 确认接诊
    func confirmReceptBtnClicked(_ btn: UIButton) {
        
        // 以助手身份 医生已接诊，待患者付款  （只有医生在15分钟内才能发起）
        doctorAssistantInitiateFollowUp("2")
        
        // 开始及时啊
        startTm = formatteryMdHms.string(from: Date())
//        haveAdmissionsAndPendingPayment()
    }
    
    // 发起随访模块
    fileprivate lazy var startFollowUpView: UIView = {
        
        let startFollowUpView = UIView(frame: CGRect(x: 0, y: kScreenHeight - 50, width: kScreenWidth, height: 50))
        startFollowUpView.backgroundColor = rgbSameColor(240)
        
        let startFollowUpBtn = UIButton(frame: CGRect(x: 15, y: 8, width: kScreenWidth - 30, height: 34))
        startFollowUpBtn.setBackgroundImage(UIImage(named: kConfirmReceptBtnBack), for: .normal)
        startFollowUpBtn.setTitle(kInitiateFollowUp, for: .normal)
        startFollowUpBtn.titleLabel?.font = font15
        startFollowUpBtn.addTarget(self, action: #selector(ConsultationController.startFollowUpBtnClicked(_:)), for: .touchUpInside)
        startFollowUpView.addSubview(startFollowUpBtn)
        
        return startFollowUpView
    }()
    
    // MARK:- 发起随访
    func startFollowUpBtnClicked(_ btn: UIButton) {
        
        // rightBarButtonItem
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(title: kEndFollowUp, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ConsultationController.endFollowUp))
        

        progressTip.text = kBeingFollowedUp
        progressBar.frame.size.width = kScreenWidth
        
        // 移除“确认接诊”模块
        confirmReceptView.removeFromSuperview()
        
        // 移除“发起随访”模块
        startFollowUpView.removeFromSuperview()
        
        
        // 以助手身份 发起随访
        doctorAssistantInitiateFollowUp("6")
    }
    
    // 结束随访
    func endFollowUp() {
        
        // 放弃第一响应者
        textfield.resignFirstResponder()
        
        // rightBarButtonItem
        customNavigationItem.rightBarButtonItem = nil
        
        progressTip.text = kFollowUpIsOver
        progressBar.frame.size.width = kScreenWidth
        
        // 移除“确认接诊”模块
        confirmReceptView.removeFromSuperview()
        
        // 移除“发起随访”模块
        view.addSubview(startFollowUpView)
        
        // 以助手身份 结束随访
        doctorAssistantInitiateFollowUp("7")
    }
    
    

    // MARK:- ################################################################# 以助手身份
    /**
     * 1、医生未接诊，该咨询结束  （医生15分钟后可以发起，患者20分钟后可以发起）
     * 2、医生已接诊，待患者付款  （只有医生在15分钟内才能发起）
     * 3、患者未付款，该咨询结束  （患者15分钟后可以发起，医生20分钟后可以发起）
     * 4、患者已付款，开始咨询   （只有患者在15分钟内才能发起）
     * 5、时间到了，该咨询结束   （患者15分钟后可以发起，医生20分钟后可以发起）
     * 6、医生想患者开启随访     （只有医生在上个咨询结束后 或 上个随访结束后 才能发起）
     * 7、该随访结束            （医生在发起随访后随时可以结束，患者在发起下一个预约时也可以结束）
     */
    fileprivate func doctorAssistantInitiateFollowUp(_ type: String) {
        /************************ 医生助手给患者发一句话 ***********************/
        
        // 通知患者
        // 将NSDate转换为字符串
        let nowTime = formatteryMdHms.string(from: Date())
        LLog(nowTime)
        
        // 咨询 还是 随访（0、咨询 1、随访）
        var consultFollowUp = "0"
        // 随访类型（0、随访中 1、随访已结束）
        var followUpType = ""
        // 咨询类型（0、预约 1、接诊 2、咨询 3、咨询结束）
        var consultType = ""
        
        switch type {
        case "1":
            consultType = "3"
        case "2":
            consultType = "1"
        case "3":
            consultType = "3"
        case "4":
            consultType = "2"
        case "5":
            consultType = "3"
        case "6":
            consultFollowUp = "1"
            followUpType = "0"
        case "7":
            consultFollowUp = "1"
            followUpType = "1"
        default:
            LLog("")
        }
        
        let diction = ["ID" : huanXinID,
                       "UserType" : "2",
                       "AssistantTip" : type,
                       "UserID" : doctorID,
                       "Icon" : doctorIcon,
                       "Name" : doctorName,
                       "ConsultOrFollowUp" : consultFollowUp,
                       "FollowUpType" : followUpType,
                       "ConsultType" : consultType,
                       "ConsultID" : ConsultID,
                       "ConsultTime" : nowTime,
                       ]
        
        LLog(consultFollowUp)
        LLog(type)
        LLog(time)
        
        
        // 1.创建一个消息对象
        // 1.1 构造文字消息
        let body = EMTextMessageBody.init(text: type)
        
        // 生成Message
        let conversationID = self.listModel!.conversationID!
        let message = EMMessage(conversationID: conversationID, from: huanXinID, to: conversationID, body: body, ext: diction)
        message?.chatType = EMChatTypeChat // 设置为单聊消息
        
        // 2 发送消息
        title = kSending
        
        EMClient.shared().chatManager.send(message, progress: { (_) in
            LLog(message)
            }) { (message, error) in
                self.title = self.listModel?.name
                LLog(error)
                if error == nil {
                    if self.consultListCtl != nil {
                        self.consultListCtl!.isRefresh = true
                    }
                    
                    self.addToFrameModels([message!], isScrollToEnd: true, isInsert: false)
                }
        }
    }
    
    
    // MARK:- 顶部状态条
    fileprivate func setupTopView() {
        topView = UIView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: topViewH))
        topView.backgroundColor = rgbSameColor(201)
        view.addSubview(topView)
        
        progressBar = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: topViewH))
        progressBar.backgroundColor = kProgressBarBackgroundColor
        topView.addSubview(progressBar)
        
        progressTip = UILabel(frame: topView.bounds)
        progressTip.textColor = UIColor.white
        progressTip.font = font12
        progressTip.text = "··· ···"
        progressTip.textAlignment = .center
        topView.addSubview(progressTip)
    }

    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        view.addSubview(tableView)
        
        
        let tableViewY: CGFloat = topView.frame.maxY + 64
        let tableViewH: CGFloat = kScreenHeight - tableViewY - 50
        tableView.frame = CGRect(x: 0, y: tableViewY, width: kScreenWidth, height: tableViewH)

//        tableView.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(view).offset(64 + topViewH)
//            make.bottom.equalTo(toolbar).offset(-50)
//            make.left.equalTo(view)
//            make.right.equalTo(view)
//        }
    }
    
    // MARK:- 创建底部控件
    fileprivate func setupBottomView() {
        let fieldH: CGFloat = 30
        let bottomViewH = fieldH + 2*kMargin
        let bottomViewY = kScreenHeight - bottomViewH - 64
        let bottomView = ConsulationView(frame: CGRect(x: 0, y: bottomViewY, width: kScreenWidth, height: bottomViewH))
        bottomView.delegate = self
        view.addSubview(bottomView)
    }
    
    // MARK:- 创建键盘
    fileprivate func setupKeyboard() {
        // 1.布局底部view（键盘工具条）
        toolbar = ConsulationView()
        textfield = toolbar.textField
        textfield.tintColor = appColor
        textfield.delegate = self
        textfield.returnKeyType = UIReturnKeyType.send
        textfield.enablesReturnKeyAutomatically = true
        toolbar.delegate = self
        view.addSubview(toolbar)
       
        
        let toolbarH: CGFloat = 50
        let toolbarY: CGFloat = kScreenHeight - toolbarH
        toolbar.frame = CGRect(x: 0, y: toolbarY, width: kScreenWidth, height: toolbarH)

//        toolbar.snp_makeConstraints { (make) -> Void in
//            make.bottom.equalTo(view)
//            make.left.equalTo(view)
//            make.right.equalTo(view)
//            make.height.equalTo(50)
//        }
        
        // 2.将表情键盘控制器添加为当前控制器的子控制器、将表情键盘控制器的veiw设置为 键盘的inputView
        addChildViewController(emoticonVC)
//        textfield.inputView = emoticonVC.view
//        textfield.inputAccessoryView = toolbar
        
        // 3.监听键盘弹出和隐藏
        NotificationCenter.default.addObserver(self, selector: #selector(ConsultationController.keyboardDidChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    // 监听键盘弹出和隐藏
    func keyboardDidChange(_ notify: Notification) {
        print(notify)
        // 1.取出键盘调整之后的frame
        let rect = ((notify as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        
        /*
         出来: "NSRect: {{0, 451}, {375, 216}}";
         隐藏: "NSRect: {{0, 667}, {375, 216}}";
         
         屏幕高度 - 键盘的Y值
         出来: 667 - 451 = 216
         隐藏: 667 - 667 = 0
         */
        LLog(toolbar)
        toolbar.frame.origin.y = -(kScreenHeight - (rect?.origin.y)!)

//        toolbar.snp_updateConstraints { (make) -> Void in
//            let height = -(UIScreen.mainScreen().bounds.height - rect.origin.y)
//            make.bottom.equalTo(view).offset(height)
//        }
        
        duration = ((notify as NSNotification).userInfo![UIKeyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue
        /*
         键盘弹出和隐藏时的动画节奏是7, 如果动画节奏是7特点:
         无论上一次动画是否执行完毕, 会直接过度到当前动画
         */
        UIView.animate(withDuration: duration, animations: { () -> Void in
            UIView.setAnimationCurve(UIViewAnimationCurve.init(rawValue: 7)!)
            self.view.layoutIfNeeded()
            self.scrollToTheEnd(false)
        }) 
    }
    
    /// 表情键盘
    // MARK:- ￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥ 图片 拍照 电话
    fileprivate lazy var emoticonVC: CustomKeyboardController = CustomKeyboardController { [unowned self] (btn) -> () in
        
        LLog(btn.tag)
        
        switch btn.tag {
        case 0:
            self.selectPictures()
        case 1:
            self.takePhoto()
        default:
            self.callPhone()
        }
    }
    
    // MARK:- 图片
    fileprivate func selectPictures() {
        // 弹出相册
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let alertController = UIAlertController(title: kAlbumLicenseNotOpen, message: kPleaseOpenTheAlbumAuthorizationInTheSystemSettings, preferredStyle: .alert)
            let action = UIAlertAction(title: kISeeTip, style: .cancel, handler: { (action) in
                LLog("点击了知道了")
            })
            alertController.addAction(action)
            present(alertController, animated: true, completion: {
                LLog("弹出了提示框")
            })
        
            return
        }
        
        let vc =  UIImagePickerController()
        // 设置打开数据源类型
        vc.sourceType = .photoLibrary
        vc.delegate = self
        
        // 弹出相册
        present(vc, animated: true, completion: nil)
    }
    
    // MARK:- 拍照
    fileprivate func takePhoto() {
        // 弹出相册
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let alertController = UIAlertController(title: kCameraLicenseNotTurnedOn, message: kPleaseOpenTheCameraAuthorizationInTheSystemSettings, preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: kISeeTip, style: UIAlertActionStyle.cancel, handler: { (action) in
                LLog("点击了知道了")
            })
            alertController.addAction(action)
            
            present(alertController, animated: true, completion: {
                LLog("弹出了提示框")
            })
            return
        }
        
        let vc =  UIImagePickerController()
        // 设置打开数据源类型
        vc.sourceType = UIImagePickerControllerSourceType.camera
        vc.delegate = self
        
        // 弹出拍照
        present(vc, animated: true, completion: nil)
    }
    
    // MARK:- 睿宝电话
    fileprivate func callPhone() {
        
        textfield.resignFirstResponder()
        
        if let aUsername = listModel?.conversationID {
            
            if consultListCtl != nil {
                let iconUrl = kBaseUrlString + listModel!.iconUrl!
                consultListCtl?.callPhone(aUsername, icon: iconUrl, name: listModel!.name)
            }
        }
    }
    
    
    
    
//    
//    // 开始计时，50s后自动挂断
//    var callTimer: NSTimer?
//    func startCallTimer() {
//        callTimer = NSTimer.scheduledTimerWithTimeInterval(50, target: self, selector: #selector(ConsultationController.cancelCall), userInfo: nil, repeats: false)
//    }
//    
//    func cancelCall() {
//        hangupCallWithReason(EMCallEndReasonNoResponse)
//        print("No response and Hang up")
//    }
// 
//    func hangupCallWithReason(aReason:EMCallEndReason) {
//        
//        stopCallTimer()
//        
//        if callSession != nil {
//            EMClient.sharedClient().callManager.endCall!(callSession?.sessionId, reason: EMCallEndReasonHangup)
//        }
//        
//        callSession = nil;
//
//        // 移除语音通话界面
//        self.voiceCall?.removeFromSuperview()
//        self.voiceCall = nil
//    }
//    
//    func stopCallTimer() {
//        if callTimer != nil {
//            callTimer?.invalidate()
//            callTimer = nil
//        }
//    }
    
    
    
    
    
    // MARK: - 转场动画
    fileprivate lazy var animator: PopoverAnimator = {
        let animator = PopoverAnimator.init(presentedViewController: self, presenting: nil)
        return animator
    }()
    

}

// MARK:- UITableViewDataSource, UITableViewDelegate
extension ConsultationController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LLog(frameModels.count)
        return frameModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ConsultationCell.setupMyConsultationCell(tableView)
        //        cell.backgroundColor = randomColor()
        cell.delegate = self
        cell.frameModel = frameModels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return frameModels[indexPath.row].cellH
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        textfield.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if previousOffsetY > scrollView.contentOffset.y {
            previousOffsetY = 0
            textfield.resignFirstResponder()
        } else {
            previousOffsetY = scrollView.contentOffset.y
        }
    }
    
    func addDate(_ text: String?) {
        
    }
}

// MARK:- UITextFieldDelegate
extension ConsultationController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        LLog(textfield.isFirstResponder)
        
        if textfield.isFirstResponder == true {
            if isPictureKeybord == true { // 图片键盘
                isPictureKeybord = false
                textfield.tintColor = UIColor.clear
                textfield.inputView = emoticonVC.view
            } else { // 文字键盘
                textfield.tintColor = appColor
                textfield.inputView = nil
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.hasText == false {
            return false
        }
        
        // 发送消息
        sendMessage(textField.text!)
        
        // 清空数据
        textfield.text = nil
        
        return true
    }
    
    // MARK:- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~发送文字
    fileprivate func sendMessage(_ txt: String) {
        LLog(txt)
        // 1.创建一个消息对象
        // 1.1 构造文字消息
        let body = EMTextMessageBody.init(text: txt)
        
        // 生成Message
        LLog(self.listModel!.conversationID)
        LLog(self.listModel!.patientID)
        let conversationID = self.listModel!.conversationID!
        
        

        // 扩展信息
        let doctorID = defaults.string(forKey: kPatientIDKey) ?? ""
        let dic = ["ID" : huanXinID,
                       "UserType" : "1",
                       "UserID" : doctorID,
                       "Icon" : doctorIcon,
                       "Name" : doctorName,
                       "ConsultOrFollowUp" : ConsultOrFollowUp,
                       "FollowUpType" : FollowUpType,
                       "ConsultType" : ConsultType,
                       "ConsultID" : ConsultID,
                       "ConsultTime" : ConsultTime,
                       ]
        
        LLog("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + ConsultOrFollowUp)
        LLog("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + FollowUpType)
        LLog(ConsultType)
        LLog(ConsultTime)

        let message = EMMessage(conversationID: conversationID, from: huanXinID, to: conversationID, body: body, ext: dic)
        message?.chatType = EMChatTypeChat // 设置为单聊消息

        // 2 发送消息
        title = kSending
        
        EMClient.shared().chatManager.send(message, progress: { (progress) in
            LLog(progress)
            }) { (msg, error) in
                self.title = self.listModel?.name
                LLog(error)
                if error == nil {
                    if self.consultListCtl != nil {
                        self.consultListCtl!.isRefresh = true
                    }
                    self.addToFrameModels([msg!], isScrollToEnd: true, isInsert: false)
                }
        }
    }
    
    // MARK:- 添加发送文字到会话列表
    func addChatCellThroughSend(_ msg: EMMessage, txt: String) {
        let model = ConslationModel()
        model.UserType = "1"

        model.ConsultOrFollowUp = ConsultOrFollowUp
        model.FollowUpType = FollowUpType
        model.ConsultType = ConsultType
        model.ConsultID = ConsultID
        model.ConsultTime = ConsultTime
        
        model.icon = doctorIcon
//        model.name = doctorName
        model.time = "\(msg.timestamp)"
        model.text = txt
        
        let frameMdl = ConslationFrame()
        frameMdl.model = model
        
        // 3.把发送消息添加到数据源
        frameModels.append(frameMdl)
        tableView.reloadData()
        scrollToTheEnd(true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ConsultationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK:- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~发送图片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        picker.dismiss(animated: true, completion: nil)
        
        VoiceTipView4.showVoiceTipView()

        DispatchQueue.global(qos: .default).async {
            
            let imageValue = UIImage.fixOrientation(image)
            
            // 生成Message
            let conversationID = self.listModel!.conversationID!
            let data: Data = UIImagePNGRepresentation(imageValue)!
            let body = EMImageMessageBody(data: data, displayName: "[\(kChoicePicture)]")
            
            
            // 扩展信息
            let dic = ["ID" : self.huanXinID,
                "UserType" : "1",
                "UserID" : self.doctorID,
                "Icon" : self.doctorIcon,
                "Name" : self.doctorName,
                "ConsultOrFollowUp" : self.ConsultOrFollowUp,
                "FollowUpType" : self.FollowUpType,
                "ConsultType" : self.ConsultType,
                "ConsultID" : self.ConsultID,
                "ConsultTime" : self.ConsultTime,
            ]

            let message = EMMessage(conversationID: conversationID, from: self.huanXinID, to: conversationID, body: body, ext: dic)
            message?.chatType = EMChatTypeChat; // 设置为单聊消息
            
            
            EMClient.shared().chatManager.send(message, progress: { (progress) in
                LLog(progress)
                }, completion: { (msg, error) in
                    VoiceTipView4.dismissVoiceTipView()
                    DispatchQueue.main.async(execute: {
                        if error == nil {
                            if self.consultListCtl != nil {
                                self.consultListCtl!.isRefresh = true
                            }
                            
                            self.addToFrameModels([msg!], isScrollToEnd: true, isInsert: false)
                            
                        } else {
                            LLog(error)
                            CustomMBProgressHUD.showFailed(kSendPictureFailed, view: self.view)
                        }
                    })
            })
        }
    }
    
    // MARK:- 添加模型到会话列表 图片
    func addChatCellThroughSendImage(_ msg: EMMessage, doctorPhone: String, pictureString: String) {
        let model = ConslationModel()
        model.UserType = "1"
        model.icon = doctorIcon

        
        model.ConsultOrFollowUp = ConsultOrFollowUp
        model.FollowUpType = FollowUpType
        model.ConsultType = ConsultType
        model.ConsultID = ConsultID
        model.ConsultTime = ConsultTime

        
        model.time = "\(msg.timestamp)"
        model.pictureString = pictureString
        pictures.append(pictureString)

        
        let frameMdl = ConslationFrame()
        frameMdl.model = model
        
        //3.把发送消息添加到数据源
        self.frameModels.append(frameMdl)
        self.tableView.reloadData()
        self.scrollToTheEnd(true)
    }
    
    // MARK:- 滚动到最后一行（unknownDeviation：未知偏差）
    fileprivate func scrollToTheEnd(_ animated: Bool) {
        
        self.view.layoutIfNeeded()
        
        // 方法一（有点瑕疵，待调整）
        if frameModels.count == 0 || !(tableView.contentSize.height > tableView.bounds.height) {
            return
        }
        let path = IndexPath(row: frameModels.count - 1, section: 0)
        tableView.scrollToRow(at: path, at: UITableViewScrollPosition.bottom, animated: animated)
    }
}

// MARK:- ConsultationCellDelegate 浏览大图片
extension ConsultationController: ConsultationCellDelegate {
    
    func backTextImageViewClicked(_ pictureStr: String) {
        let index = pictures.index(of: pictureStr) ?? 0
        let vc = PicturesBrowseController(pictures: pictures, index: index)
        vc.transitioningDelegate = animator
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        present(vc, animated: true, completion: nil)
    }
    
    func openShareArticle(_ url: String) {
        if url.hasPrefix("http") {
            let vc = CusTomWebViewController()
            vc.title = ""
            vc.urlString = url
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - ConsulationViewDelegate 键盘切换 语音、文字切换
extension ConsultationController: ConsulationViewDelegate {
    
    // MARK: - 键盘切换 语音、文字切换
    func oneButtonOfConsulationViewClicked(_ btn: UIButton) {
        LLog(btn.tag)
        
        if btn.tag == 0 {
            switchVoiceOrWord(btn)
        } else {
            toAddSomeThings()
        }
    }
    
    func switchVoiceOrWord(_ btn: UIButton) {
        if btn.isSelected { // ->语音
            textfield.resignFirstResponder()
        } else { // ->文字
            textfield.becomeFirstResponder()
        }
    }
    
    func toAddSomeThings() {        
        // 如果是系统自带的键盘那么inputView = nil
        // 如果不是系统自带键盘那么inpuView != nil
        LLog(textfield.inputView)

        if textfield.isFirstResponder {
            // 关闭键盘
            textfield.resignFirstResponder()
            // 设置键盘
            textfield.inputView = (textfield.inputView != nil) ? nil :  emoticonVC.view
            // 确定键盘类型
            isPictureKeybord = textfield.inputView == nil ? false : true
        } else {
            // 确定键盘类型
            isPictureKeybord = true
        }
        // 重新召唤出键盘
        textfield.becomeFirstResponder()
    }
    
    // MARK: - 开始录音
    func beginRecordAction(_ btn: UIButton) {
        
        let x = arc4random()%100000
        let time = Date().timeIntervalSince1970
        let fileName = "\(time)\(x)"

        MBProgressHUD.showAdded(to: tableView, animated: true)
        EMCDDeviceManager.sharedInstance().asyncStartRecording(withFileName: fileName) { (error) in
            if error == nil {
                MBProgressHUD.hide(for: self.tableView, animated: true)

                LLog("成功开始录音")
                VoiceTipView.showVoiceTipView()
//                VoiceTipView().state = 0
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ConsultationController.recordVoiceTime), userInfo: nil, repeats: true)
                self.records = 0
            } else {
                LLog(error)
            }
        }
    }
    
    func recordVoiceTime() {
        records += 1
    }
    
    fileprivate func stopTimers() {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - 结束录音 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~发送语音
    func endRecordAction(_ btn: UIButton) {
        stopTimers()
        VoiceTipView.dismissVoiceTipView()
        if records < 1 {
            VoiceTipView3.showVoiceTipView()
           
            // 清空之前的录音（待处理）
            
            
        } else {
            VoiceTipView2.showVoiceTipView()
            
            EMCDDeviceManager.sharedInstance().asyncStopRecording { (recordPath, aDuration, error) in
                
                if error == nil { // 成功结束录音
                    LLog(recordPath)
                    LLog(aDuration)
                    
                    let conversationID = self.listModel!.conversationID!
                    // 音频消息体
                    let body = EMVoiceMessageBody(localPath: recordPath, displayName: "[\(kConsultationVoice)]")
                    body?.duration = Int32(aDuration)

                    
                    // 扩展信息
                    let dic = ["ID" : self.huanXinID,
                        "UserType" : "1",
                        "UserID" : self.doctorID,
                        "Icon" : self.doctorIcon,
                        "Name" : self.doctorName,
                        "ConsultOrFollowUp" : self.ConsultOrFollowUp,
                        "FollowUpType" : self.FollowUpType,
                        "ConsultType" : self.ConsultType,
                        "ConsultID" : self.ConsultID,
                        "ConsultTime" : self.ConsultTime,
                    ]

                    let message = EMMessage(conversationID: conversationID, from: self.huanXinID, to: conversationID, body: body, ext: dic)
                    message?.chatType = EMChatTypeChat
                    
                    // 发送录音
                    EMClient.shared().chatManager.send(message, progress: { (progress) in
                        LLog(progress)
                        }, completion: { (msg, error) in
                            if error == nil {
                                LLog("发送录音完成")
                                
                                if self.consultListCtl != nil {
                                    self.consultListCtl!.isRefresh = true
                                }
                                
                                VoiceTipView2.dismissVoiceTipView()
                                
                                
                                
                                self.addToFrameModels([msg!], isScrollToEnd: true, isInsert: false)
                                
                            } else {
                                LLog(error)
                                VoiceTipView2.dismissVoiceTipView()
                                CustomMBProgressHUD.showFailed(kSendFailed, view: nil)
                            }
                    })
                    
//                    EMClient.shared().chatManager.asyncSend(message, progress: { (progress) in
//                        LLog(progress)
//                    }) { (msg, error) in
//                    }
                } else {
                    LLog(error)
                    VoiceTipView2.dismissVoiceTipView()
                    CustomMBProgressHUD.showFailed(kSendFailed, view: nil)
                }
            }
        }
    }
    
    // MARK:- 添加模型到会话列表 语音
    func addChatCellThroughSendVoice(_ msg: EMMessage, recordPath: String, duration: Int32) {
        let model = ConslationModel()
        model.UserType = "1"
        model.icon = doctorIcon

        
        
        model.ConsultOrFollowUp = ConsultOrFollowUp
        model.FollowUpType = FollowUpType
        model.ConsultType = ConsultType
        model.ConsultID = ConsultID
        model.ConsultTime = ConsultTime

        
        model.time = "\(msg.timestamp)"
        model.message = msg
        model.voicePath = recordPath
        model.voiceDuration = duration
        
        let frameMdl = ConslationFrame()
        frameMdl.model = model
        
        // 3.把发送消息添加到数据源
        frameModels.append(frameMdl)
        tableView.reloadData()
        scrollToTheEnd(true)
    }
    
    // MARK: - 取消录音
    func cancelRecordAction(_ btn: UIButton) {
        stopTimers()
        VoiceTipView.dismissVoiceTipView()
        if records < 1 {
            VoiceTipView3.showVoiceTipView()
        } else {
            EMCDDeviceManager.sharedInstance().cancelCurrentRecording()
        }
    }
}

// MARK:- EMChatManagerDelegate 收到消息
extension ConsultationController: EMChatManagerDelegate {
    
    
    private func didUpdateConversationList(_ aConversationList: [AnyObject]!) {
        LLog(aConversationList)
    }
    
    /*!
     *  收到消息
     *
     *  @param aMessages  消息列表<EMMessage>
     */
    private func didReceiveMessages(_ aMessages: [AnyObject]!) {
        LLog(aMessages)
        
        let allMsges = aMessages as? [EMMessage]
        
        if allMsges != nil && allMsges!.count > 0 {
            let msg = allMsges![0]
            if msg.from == listModel!.conversationID {
                
                addToFrameModels(allMsges, isScrollToEnd: true, isInsert: false)
                
            }
        }
    }
    
    
    private func didReceiveCmdMessages(_ aCmdMessages: [AnyObject]!) {
        LLog(aCmdMessages)
    }

    private func didReceiveHasDeliveredAcks(_ aMessages: [AnyObject]!) {
        LLog(aMessages)
    }
    
    
    func didMessageStatusChanged(_ aMessage: EMMessage!, error aError: EMError!) {
        LLog(aMessage)
        LLog(aError)
    }
    
    
}


// MARK:- EMCallManagerDelegate 在线电话
extension ConsultationController: EMCallManagerDelegate {

    /*!
     *  \~chinese
     *  用户A拨打用户B，用户B会收到这个回调
     *
     *  @param aSession  会话实例
     *
     *  \~english
     *  User B will receive this callback after user A dial user B
     *
     *  @param aSession  Session instance
     */
    
    func didReceiveCallIncoming(_ aSession: EMCallSession!) {
//        if callSession != nil && callSession?.status != EMCallSessionStatusDisconnected {
//            EMClient.sharedClient().callManager.endCall!(aSession.sessionId, reason: EMCallEndReasonBusy)
//        }
//        if UIApplication.sharedApplication().applicationState != UIApplicationState.Active {
//            EMClient.sharedClient().callManager.endCall!(aSession.sessionId, reason: EMCallEndReasonFailed)
//        }
//        
//        callSession = aSession
//        if callSession != nil{
//            
//            startCallTimer()
//            
//            callController = CallViewController.init(session: callSession, isCaller: false, status: "已连接")
//            callController?.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
//            self.presentViewController(callController!, animated: true, completion: nil)
//        }
//
    }
    
    /*!
     *  \~chinese
     *  通话通道建立完成，用户A和用户B都会收到这个回调
     *
     *  @param aSession  会话实例
     *
     *  \~english
     *  Both user A and B will receive this callback after connection is established
     *
     *  @param aSession  Session instance
     */
    func didReceiveCallConnected(_ aSession: EMCallSession!) {
        
    }

    
    /*!
     *  \~chinese
     *  用户B同意用户A拨打的通话后，用户A会收到这个回调
     *
     *  @param aSession  会话实例
     *
     *  \~english
     *  User A will receive this callback after user B accept A's call
     *
     *  @param aSession
     */
    func didReceiveCallAccepted(_ aSession: EMCallSession!) {
        
    }

    
    /*!
     *  \~chinese
     *  1. 用户A或用户B结束通话后，对方会收到该回调
     *  2. 通话出现错误，双方都会收到该回调
     *
     *  @param aSession  会话实例
     *  @param aReason   结束原因
     *  @param aError    错误
     *
     *  \~english
     *  1.The another peer will receive this callback after user A or user B terminate the call.
     *  2.Both user A and B will receive this callback after error occur.
     *
     *  @param aSession  Session instance
     *  @param aReason   Terminate reason
     *  @param aError    Error
     */
    func didReceiveCallTerminated(_ aSession: EMCallSession!, reason aReason: EMCallEndReason, error aError: EMError!) {
        
    }

    
    /*!
     *  \~chinese
     *  用户A和用户B正在通话中，用户A中断或者继续数据流传输时，用户B会收到该回调
     *
     *  @param aSession  会话实例
     *  @param aType     改变类型
     *
     *  \~english
     *  User A and B is on the call, A pause or resume the data stream, B will receive the callback
     *
     *  @param aSession  Session instance
     *  @param aType     Type
     */
    private func didReceiveCallUpdated(_ aSession: EMCallSession!, type aType: EMCallStreamingStatus) {
        
    }

    
    /*!
     *  \~chinese
     *  用户A和用户B正在通话中，用户A的网络状态出现不稳定，用户A会收到该回调
     *
     *  @param aSession  会话实例
     *  @param aStatus   当前状态
     *
     *  \~english
     *  User A and B is on the call, A network status is not stable, A will receive the callback
     *
     *  @param aSession  Session instance
     *  @param aStatus   Current status
     */
    func didReceiveCallNetworkChanged(_ aSession: EMCallSession!, status aStatus: EMCallNetworkStatus) {
        
    }
}


// MARK:- EMCallManagerDelegate 在线电话
extension ConsultationController: VoiceCallViewDelegate {

}
