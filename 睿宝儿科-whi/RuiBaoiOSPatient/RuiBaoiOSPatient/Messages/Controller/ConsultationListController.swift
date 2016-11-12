//
//  ConsultationList.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/4.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  咨询

import UIKit
import MJRefresh
import AVFoundation


private let loadDataNumber = 10

class ConsultationListController: BaseViewController {

    fileprivate var consultations: [ConsultationListModel] = Array()
    fileprivate var tableView: UITableView!

    fileprivate var maskingNoData: MaskingView?
    fileprivate var badgeValue = 0
//    var consulatingID: String?
    
    // viewWillAppear时，是否刷新
    var isRefresh = false
    
    
    
    
    
    // 语音通话界面
    var voiceCall: VoiceCallView?
    // 是否主动打过去的？
    var isActive = false
    // 语音通话
    fileprivate var callSession :EMCallSession?
    // 音频？
    fileprivate var audioCategory:String?
    // 扬声器
    fileprivate var ringPlayer: AVAudioPlayer?
    // 计时器
    var timeTimer: Timer?
    var timeLength = 0
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
        
        // 设置tableView
        setupTableView()
        
        // 设置代理
        EMClient.shared().add(self, delegateQueue: nil)
        EMClient.shared().chatManager.add(self, delegateQueue: nil)
        EMClient.shared().callManager.add!(self, delegateQueue: nil)

        // 加载好友请求
        headerRefresh()
        
        
    }
    
//    IntentFilter callFilter = new IntentFilter(EMClient.getInstance().callManager().getIncomingCallBroadcastAction());
//    registerReceiver(new CallReceiver(), callFilter);
//    
//    private class CallReceiver extends BroadcastReceiver {
//    
//    @Override
//    public void onReceive(Context context, Intent intent) {
//    // 拨打方username
//    String from = intent.getStringExtra("from");
//    // call type
//    String type = intent.getStringExtra("type");
//    //跳转到通话页面
//    
//    }
//    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if isRefresh == true {
//            isRefresh = false
            headerRefresh()
//        }
//        consulatingID = nil
    }
    
    deinit {
        EMClient.shared().chatManager.remove(self)
        EMClient.shared().callManager.remove!(self)
        EMClient.shared().removeDelegate(self)
    }
        
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64 - 49), style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = 91
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    // MARK:- 加载好友列表
    func headerRefresh() {
        
        /*!
         *  获取所有会话，如果内存中不存在会从DB中加载
         *
         *  @result 会话列表<EMConversation>
         */
//        let cs = EMClient.sharedClient().chatManager.getAllConversations() //getAllConversations() as? [EMConversation]
        
        
        /*!
         *  从数据库中获取所有的会话，执行后会更新内存中的会话列表
         *
         *  同步方法，会阻塞当前线程
         *
         *  @result 会话列表<EMConversation>
         */
        //        - (NSArray *)loadAllConversationsFromDB;

        
        /*
         * 好友获取原理
         * vgios11.db 数据库-存储数据，存储了用户相关信息(好友信息，聊天记录)
         * 1.用户登录成功后，会自动从服务器获取好友列表，把好友列表保存数据库的buddy表
         * 2.如果本地数据库没有好友列表，可以从服务器获取
         [EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion
         */
        
//        title = kLoadIn
        DispatchQueue.global(qos: .default).async {
            
            // 先从缓存中取，缓存中没有，再去数据库中取
//            var conversations = EMClient.sharedClient().chatManager.getAllConversations()
//            LLog(conversations)
//            if conversations == nil || conversations.count == 0 {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                    conversations = EMClient.sharedClient().chatManager.loadAllConversationsFromDB()
//                    dispatch_async(dispatch_get_main_queue(), {
//                        self.handerData(conversations)
//                    })
//                })
//            } else {
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.handerData(conversations)
//                })
//            }

            // 从数据库获取所有会话列表
            let conversations = EMClient.shared().chatManager.getAllConversations()
            DispatchQueue.main.async(execute: {
                self.navigationItem.title = kMessageTabBar
                self.handerData(conversations as [AnyObject]!)
            })
        }
    }
    
    func handerData(_ userlist: [AnyObject]!) {
        // 移除原数组数据
        self.consultations.removeAll()
        
        badgeValue = 0
        for item in userlist {
            LLog(item)
            
            let conversation = item as? EMConversation
            if conversation != nil {
                
                let cs = conversation!
                LLog(cs)
                let model = ConsultationListModel.setupConsultationListModel(cs)
                if model != nil {
//                    if model!.conversationID == consulatingID {
//                        model!.unReadNumber = 0
//                    } else {
                        // 累计为读书
                        badgeValue += Int((conversation!.unreadMessagesCount))
//                    }
                    
                    self.consultations.append(model!)
                }
            }
        }
        
        self.tableView.reloadData()

        LLog((tabBarController as! MainTabBarController).myTabBar.subviews)
        LLog(badgeValue)
        let btn = (tabBarController as! MainTabBarController).myTabBar.subviews[2] as! MJTabBarButton
        if badgeValue > 0 {
            btn.unread = "\(badgeValue)"
        } else {
            btn.unread = nil
        }
        
        // 根据返回数据结果，显示/隐藏 占位图片
        if self.consultations.count == 0 {
            loadNoData()
        } else {
            loadHaveData()
        }
    }
    
    // 加载数据为nil----数据处理
    fileprivate func loadNoData() {
        
        if maskingNoData == nil {
            maskingNoData = MaskingView.setUpMaskingView(tableView.bounds, iconString: kNoConsulationIcon, tipTxt: kNoConsultationRecordsTip)
        }
        tableView.addSubview(maskingNoData!)
    }
    
    // 加载有数据
    fileprivate func loadHaveData() {
        maskingNoData?.removeFromSuperview()
    }
    
    
    /******************************* 主动给患者打电话 **************************/
    // MARK:- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^主动给患者打电话
    func callPhone(_ aUsername: String, icon: String, name: String) {
        
        LLog(aUsername)
        
        EMClient.shared().callManager.startVideoCall!(aUsername) { (callSn, error) in
            
            self.callSession = callSn
            
            self.voiceCall = VoiceCallView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            self.isActive = true
            self.voiceCall?.delegate = self
            let window = UIApplication.shared.keyWindow
            window?.addSubview(self.voiceCall!)
            
            self.voiceCall!.ruibaophone.text = kBeingConnected
            
            // 患者头像、名称
            self.voiceCall?.icon.sd_setImage(with: URL.init(string: icon), placeholderImage: UIImage.init(named: "IconPlacehoderGray60"))
            self.voiceCall?.patientName.text = name
            
            self.voiceCall!.muteBtn.isHidden = false
            self.voiceCall!.speakerBtn.isHidden = false
            
            self.voiceCall!.rejectBtn.center.x = kScreenWidth/2
            self.voiceCall!.rejectBtn.setTitle("", for: .normal)
            self.voiceCall!.answerBtn.isHidden = true
        }
//        callSession = EMClient.shared().callManager.makeVoiceCall!(aUsername as String, error: nil)
    }
    
    // 开始计时，50s后自动挂断
    var callTimer: Timer?
    func startCallTimer() {
        callTimer = Timer.scheduledTimer(timeInterval: 50, target: self, selector: #selector(ConsultationListController.cancelCall), userInfo: nil, repeats: false)
    }
    
    func cancelCall() {
        hangupCallWithReason(EMCallEndReasonNoResponse)
        print("No response and Hang up")
    }
    
    func hangupCallWithReason(_ aReason:EMCallEndReason) {
        
        stopCallTimer()
        
        if callSession != nil {
            EMClient.shared().callManager.endCall!(callSession?.sessionId, reason: EMCallEndReasonHangup)
        }
        
        callSession = nil;
        
        // 移除语音通话界面
        self.voiceCall?.removeFromSuperview()
        self.voiceCall = nil
        isActive = false
    }
    
    func stopCallTimer() {
        if callTimer != nil {
            callTimer?.invalidate()
            callTimer = nil
        }
    }

    
    
    
    /******************** 语音通话 *******************/
    
    // 关闭通话
    func closeChatAudioView(_ reson: EMCallEndReason) {
        
        // 语音通话界面
        self.voiceCall?.removeFromSuperview()

        DispatchQueue.global(qos: .default).async {
            
            if self.callSession != nil {
                EMClient.shared().callManager.endCall!(self.callSession?.sessionId, reason: reson)
            }
            
            // 语音通话
            self.callSession = nil
            
            // 停止计时器
            if self.timeTimer != nil {
                self.timeTimer?.invalidate()
                self.timeTimer = nil
            }
            if self.voiceTimer != nil {
                self.voiceTimer?.invalidate()
                self.voiceTimer = nil
            }
            
            // 停止扬声器
            self.ringPlayer?.stop()
            self.ringPlayer = nil
            
            // 音频？
            self.audioCategory = nil
            
            DispatchQueue.main.async(execute: {
                do {
                    try  AVAudioSession.sharedInstance().setActive(false)
                } catch {
                    LLog("待处理。。。")
                }
            })
            
            self.voiceCall = nil
            self.isActive = false
        }
    }
    
    // 开始计时
    func startTiming() {
        timeLength += 1
        let hour = timeLength/3600
        let min = (timeLength - hour*3600)/60
        let sec = timeLength - hour*3600 - min*60;
        
        if hour > 0 {
            voiceCall!.time.text = String.init(format: "%i:%i:%i", hour, min, sec)
        } else if min > 0 {
            if min < 10 {
                if sec < 10 {
                    voiceCall!.time.text = String.init(format: "0%i:0%i", min, sec)
                } else {
                    voiceCall!.time.text = String.init(format: "0%i:%i", min, sec)
                }
            } else {
                if sec < 10 {
                    voiceCall!.time.text = String.init(format: "%i:0%i", min, sec)
                } else {
                    voiceCall!.time.text = String.init(format: "%i:%i", min, sec)
                }
            }
        } else {
            if sec < 10 {
                voiceCall!.time.text = String.init(format: "00:0%i",sec)
            } else {
                voiceCall!.time.text = String.init(format: "00:%i",sec)
            }
        }
        
        if timeLength == 10*60 { // 时间到了，强制挂断
            // 关闭通话
            closeChatAudioView(EMCallEndReasonFailed)
        }
    }
    
    // 根据音量大小展示电话图标
    func sessionVoiceVolume() {
        let volume =  callSession?.getVoiceVolume() ?? 0
        if volume == 0 {
            voiceCall!.phonePicture.image = voiceImageArray[0]
        } else if volume > 0 && volume < 3 {
            voiceCall!.phonePicture.image = voiceImageArray[1]
        } else if volume >= 3 && volume < 6 {
            voiceCall!.phonePicture.image = voiceImageArray[2]
        } else {
            voiceCall!.phonePicture.image = voiceImageArray[3]
        }
    }
}

// MARK:- UITableViewDataSource, UITableViewDelegate
extension ConsultationListController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consultations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ConsultationListCell.setupConsultationCell(tableView, indexPath: indexPath)
        cell.model = consultations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 所有消息置为已读
        let model = consultations[indexPath.row]
//        consulatingID = model.conversationID
//        model.conversation?.markAllMessagesAsRead()
//        headerRefresh()
        
        let vc = ConsultationController()
        vc.listModel = model
//        vc.consultListCtl = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    
    /*************** ❤️❤️❤️ ***************/
    /**************** ❤️❤️ ***************/
    /***************** ❤️ ***************/
    // MARK: - UITableViewDelegate
    // MARK: - 切记：ios9之前必须实现此方法，不然没效果
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {}
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let action = UITableViewRowAction(style: .default, title: kDelete) { (action, indexpath) in
            
            // 从环信刷出该条数据
            let cs = self.consultations[indexPath.row]
            
            EMClient.shared().chatManager.deleteConversation(cs.conversationID!, isDeleteMessages: true, completion: { (str, error) in
                
                LLog(self.consultations)
                
                /**************** 动画效果（推荐） **************/
                //            self.consultations.removeAtIndex(indexPath.row)
                //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
                /**************** 非动画效果（不推荐） **************/
                self.consultations.remove(at: indexPath.row)
                tableView.reloadData()
            })
//            EMClient.shared().chatManager.deleteConversation(cs.conversationID!, deleteMessages: true)
        }
        
//        let action = UITableViewRowAction(style: .default), title: kDelete, handler: { (action, indexpath) -> Void in
//        })
        action.backgroundColor = UIColor.red
        
        return [action]
    }
}

// MARK:- EMClientDelegate
extension ConsultationListController : EMClientDelegate {
    /*!
     *  SDK连接服务器的状态变化时会接收到该回调
     *
     *  有以下几种情况, 会引起该方法的调用:
     *  1. 登录成功后, 手机无法上网时, 会调用该回调
     *  2. 登录成功后, 网络状态变化时, 会调用该回调
     *
     *  @param aConnectionState 当前状态
     */
    func didConnectionStateChanged(_ aConnectionState: EMConnectionState) {
        if aConnectionState == EMConnectionConnected {
            LLog("网络连接是通的")
            self.navigationItem.title = kMessageTabBar
        } else {
            self.navigationItem.title = kNotConnected
        }
    }
    
    /*!
     *  自动登录失败时的回调
     *
     *  @param aError 错误信息
     *
     */
    func didAutoLoginWithError(_ aError: EMError!) {
        if aError == nil {
            LLog("自动登录成功")
            
            // 刷新好友列表
            headerRefresh()
            
        } else {
            LLog("自动登录失败")
        }
    }
    
    /*!
     *  当前登录账号在其它设备登录时会接收到该回调
     */
    func didLoginFromOtherDevice() {
        LLog("当前登录账号在其它设备登录时会接收到该回调")
    }
    
    /*!
     *  当前登录账号已经被从服务器端删除时会收到该回调
     */
    func didRemovedFromServer() {
        LLog("当前登录账号已经被从服务器端删除时会收到该回调")
    }
}

// MARK:- EMChatManagerDelegate
extension ConsultationListController : EMChatManagerDelegate {
    /*!
     *  会话列表发生变化
     *
     *  @param aConversationList  会话列表<EMConversation>
     */
    private func didUpdateConversationList(_ aConversationList: [AnyObject]!) {
        LLog("会话列表发生变化")
        headerRefresh()
    }
    
    /*!
     *  收到消息
     *
     *  @param aMessages  消息列表<EMMessage>
     */
    private func didReceiveMessages(_ aMessages: [AnyObject]!) {
        LLog("收到消息")
        headerRefresh()
    }
    
    /*!
     *  收到Cmd消息
     *
     *  @param aCmdMessages  Cmd消息列表<EMMessage>
     */
//    func didReceiveCmdMessages(aCmdMessages: [AnyObject]!) {
//        LLog("收到Cmd消息")
//    }
    
    /*!
     *  收到已读回执
     *
     *  @param aMessages  已读消息列表<EMMessage>
     */
    private func didReceiveHasReadAcks(_ aMessages: [AnyObject]!) {
        LLog("收到已读回执")
    }
    
    /*!
     *  收到消息送达回执
     *
     *  @param aMessages  送达消息列表<EMMessage>
     */
    private func didReceiveHasDeliveredAcks(_ aMessages: [AnyObject]!) {
        LLog("收到消息送达回执")
    }
    
    /*!
     *  消息状态发生变化
     *
     *  @param aMessage  状态发生变化的消息
     *  @param aError    出错信息
     */
    func didMessageStatusChanged(_ aMessage: EMMessage!, error aError: EMError!) {
        LLog("消息状态发生变化")
    }
    
    /*!
     *  消息附件状态发生改变
     *
     *  @param aMessage  附件状态发生变化的消息
     *  @param aError    错误信息
     */
    func didMessageAttachmentsStatusChanged(_ aMessage: EMMessage!, error aError: EMError!) {
        LLog("消息附件状态发生改变")
    }
}




















// MARK:- EMCallManagerDelegate 睿宝电话
extension ConsultationListController: EMCallManagerDelegate {
    /*!
     *  用户A拨打用户B，用户B会收到这个回调
     *
     *  @param aSession  会话实例
     */
    func didReceiveCallIncoming(_ aSession: EMCallSession!) {
        
        if aSession != nil {
            LLog(aSession)
            LLog(aSession?.status)

//            if aSession?.status != EMCallSessionStatusDisconnected {
//                EMClient.sharedClient().callManager.endCall!(aSession.sessionId, reason: EMCallEndReasonBusy)
//            }
//            
            if UIApplication.shared.applicationState != UIApplicationState.active { // 医生端不在前台
                EMClient.shared().callManager.endCall?(aSession.sessionId, reason: EMCallEndReasonFailed)
                return
            }
            
            if callSession != nil { // 当前有通话
                EMClient.shared().callManager.endCall?(aSession.sessionId, reason: EMCallEndReasonBusy)
                return
            }
            
            // 放弃第一响应者
            NotificationCenter.default.post(name: Notification.Name(rawValue: kNotificatConsultationControllerResignFirst), object: nil)
            

            // 语音通话
            callSession = aSession

            voiceCall = VoiceCallView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            voiceCall?.delegate = self
            isActive = false
            let window = UIApplication.shared.keyWindow
            window?.addSubview(voiceCall!)
            
            // 患者头像、名称
            for cs in consultations {
                LLog(aSession.sessionId)
                LLog(aSession.username)
                LLog(aSession.remoteUsername)
                
                LLog(cs.conversationID)

                if aSession.remoteUsername == cs.conversationID {
                    let iconUrl = kBaseUrlString + cs.iconUrl!
                    LLog(iconUrl)
                    voiceCall?.icon.sd_setImage(with: URL.init(string: iconUrl), placeholderImage: UIImage.init(named: "Bitmap"))
                    voiceCall?.patientName.text = cs.name
                }
            }
        }
    }
    
    /*!
     *  通话通道建立完成，用户A和用户B都会收到这个回调
     *
     *  @param aSession  会话实例
     */
    func didReceiveCallConnected(_ aSession: EMCallSession!) {
//        LLog("~~~~~~~~~~~" + aSession.sessionId)
//        if aSession.sessionId == callSession?.sessionId {
//            do {
//                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
//                try  AVAudioSession.sharedInstance().setActive(true)
//            } catch {
//                LLog("待处理。。。")
//            }
//            
//            // 隐藏 睿宝电话，显示 通话时间
//            voiceCall!.phonePictureTimeView.hidden = false
//            voiceCall!.ruibaophone.hidden = true
//            
//            // 开始计时通话时长
//            timeLength = 0 // 必须清零
//            timeTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ConsultationListController.startTiming), userInfo: nil, repeats: true)
//            
//            // 根据音量大小展示电话图标
//            voiceTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(ConsultationListController.sessionVoiceVolume), userInfo: nil, repeats: true)
//        }
    }
    
    /*!
     *  用户B同意用户A拨打的通话后，用户A会收到这个回调
     *
     *  @param aSession  会话实例
     */
    func didReceiveCallAccepted(_ aSession: EMCallSession!) {
        LLog("~~~~~~~~~~~" + aSession.sessionId)
        if aSession.sessionId == callSession?.sessionId {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
                try  AVAudioSession.sharedInstance().setActive(true)
            } catch {
                LLog("待处理。。。")
            }
            
            // 隐藏 睿宝电话，显示 通话时间
            voiceCall?.phonePictureTimeView.isHidden = false
            voiceCall?.ruibaophone.isHidden = true
            
            // 开始计时通话时长
            timeLength = 0 // 必须清零
            timeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ConsultationListController.startTiming), userInfo: nil, repeats: true)
            
            // 根据音量大小展示电话图标
            voiceTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(ConsultationListController.sessionVoiceVolume), userInfo: nil, repeats: true)
        }
    }
    
    /*!
     *  1. 用户A或用户B结束通话后，对方会收到该回调
     *  2. 通话出现错误，双方都会收到该回调
     *
     *  @param aSession  会话实例
     *  @param aReason   结束原因
     *  @param aError    错误
     */
    func didReceiveCallTerminated(_ aSession: EMCallSession!, reason aReason: EMCallEndReason, error aError: EMError!) {
       
        // 关闭通话
//        closeChatAudioView(aReason)
        
        if aReason != EMCallEndReasonHangup { // 不是对方挂断
           
            var string = ""
          
            switch aReason {
            case EMCallEndReasonNoResponse:
                string = kNoResponse
                break
            case EMCallEndReasonDecline:
                string = kTheOtherPartyRefused
                break
            case EMCallEndReasonBusy:
                string = kTheOtherIsCalling
                break
            case EMCallEndReasonFailed:
                string = kCallFailed
                break
            default:
                break
            }
            
            if aError == nil {
                CustomMBProgressHUD.showTipAndHideImmediately(string, details: nil, view: view)
            } else {
                CustomMBProgressHUD.showFailed(aError.errorDescription, view: view)
            }
        }
    }
    
    /*!
     *  用户A和用户B正在通话中，用户A中断或者继续数据流传输时，用户B会收到该回调
     *
     *  @param aSession  会话实例
     *  @param aType     改变类型
     */
    private func didReceiveCallUpdated(_ aSession: EMCallSession!, type aType: EMCallStreamingStatus) {
        
    }
    
    /*!
     *  用户A和用户B正在通话中，用户A的网络状态出现不稳定，用户A会收到该回调
     *
     *  @param aSession  会话实例
     *  @param aStatus   当前状态
     */
    func didReceiveCallNetworkChanged(_ aSession: EMCallSession!, status aStatus: EMCallNetworkStatus) {
        if aSession.sessionId == callSession?.sessionId {
            switch (aStatus) {
            case EMCallNetworkStatusNormal:
                voiceCall?.networkLabel.text = ""
                voiceCall?.networkLabel.isHidden = true
                break
            case EMCallNetworkStatusUnstable:
                voiceCall?.networkLabel.text = kNetworkIsNotStable
                voiceCall?.networkLabel.isHidden = false
                break
            case EMCallNetworkStatusNoData:
                voiceCall?.networkLabel.text = kThereIsNoCallData
                voiceCall?.networkLabel.isHidden = false
                break
            default:
                break
            }
        }
    }
}




extension ConsultationListController: VoiceCallViewDelegate {
    // 静音
    func muteButtonClicked(_ btn: MuteSpeakerBtn) {
        LLog(btn)
//        EMClient.shared().callManager.pauseVoice(withSession: callSession?.sessionId, error: <#T##AutoreleasingUnsafeMutablePointer<EMError?>!#>)
        _ = EMClient.shared().callManager.markCallSession!(callSession?.sessionId, isSilence: btn.isSelected)
    }
    
    // 扬声器
    func speakerButtonClicked(_ btn: MuteSpeakerBtn) {
        LLog(btn)
        
        let audioSession = AVAudioSession.sharedInstance()

        if btn.isSelected == true {
            do {
                try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            } catch {
                LLog("待处理。。。")
            }
        } else {
            do {
                try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.none)
            } catch {
                LLog("待处理。。。")
            }
        }

        do {
            try audioSession.setActive(true)
        } catch {
            LLog("待处理。。。")
        }
    }
    
    // 拒绝
    func rejectACall(_ btn: RejectAnswerBtn) {
        // 关闭通话
        closeChatAudioView(EMCallEndReasonBusy)
    }
    
    // 挂断
    func hangUpACall(_ btn: RejectAnswerBtn) {
        // 关闭通话
        closeChatAudioView(EMCallEndReasonHangup)
    }
    
    // 接听
    func answerButtonClicked(_ btn: RejectAnswerBtn) {
        
        // 正在连接...
        voiceCall?.ruibaophone.text = kBeingConnected
        
        let audioSession = AVAudioSession.sharedInstance()
        audioCategory = audioSession.category
        
        if audioCategory != AVAudioSessionCategoryPlayAndRecord {
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                try audioSession.setActive(true)
            } catch {
                LLog("待处理。。。")
            }
        }

        
        if (callSession != nil) {
            DispatchQueue.global(qos: .default).async {
                
                let sessionId = self.callSession!.sessionId
                if sessionId != nil {
                    let error = EMClient.shared().callManager.answerIncomingCall!(sessionId!)
                    if (error != nil) {
                        DispatchQueue.main.async(execute: {
                            if (error?.code == EMErrorNetworkUnavailable) {
                                let alertController = UIAlertController(title: nil, message: kCurrentNetworkConnectionFailed, preferredStyle: UIAlertControllerStyle.alert)
                                let action = UIAlertAction(title: kISeeTip, style: UIAlertActionStyle.cancel, handler: { (action) in
                                    LLog("取消")
                                })
                                alertController.addAction(action)
                                self.present(alertController, animated: true, completion: nil)
                            } else {
                                // 关闭通话
                                self.closeChatAudioView(EMCallEndReasonFailed)
                            }
                        });
                    }
                }
            }
        }
    }
}





