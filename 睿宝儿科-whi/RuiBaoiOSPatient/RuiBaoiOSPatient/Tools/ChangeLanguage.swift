////
////  ChangeLanguage.swift
////  RuiBaoiOSDoctor
////
////  Created by whj on 16/5/12.
////  Copyright © 2016年 ConneHealth. All rights reserved.
////
//
//import UIKit
//
//// 提示内容
////var kEnterUserName = "" // 请输入用户名
////var kUserNameOrPasswordError = "" // 用户名或密码错误
////var kLogining = "" // 登录中ing
////var kSignOutSuccess = "" // 退出成功
////var kSiging = "" // 退出中
//var kNetworkTip = "" // 网络异常，请检查网络设置
//var kPleaseEnterContent = "" // 请输入内容
//var kShareSuccessTip = "" // 分享成功
//var kShareFaileTip = "" // 分享失败
//var kLoggedOnOtherDevicesTip = "" // 此账号在其它设备上登录了
//var kAnAccountCanOnlyLoggedOnOneDeviceTip = "" // 为了保障您能顺利接受患者会话，一个账号只能同时在一个设备上登录。
//var kISeeTip = "" // 知道了
//var kPlaceText = "" // 暂无
//var kSavePictureFiled = "" // 保存图片出错
//var kSavePictureSuccess = "" // 保存图片成功
//var kCircleOfFriends = "" // 朋友圈
//var kWeChat = "" // 微信
//var kMicroBlog = "" // 微博
//var kQQZone = "" // QQ空间
////var kFriendshipTips = "" // 友情提示
////var kSaveFailTip = "" // 保存失败
//var kCancleSend = "" // 手指向上滑，取消发送
//var kLoosenFingerCancleSend = "" // 松开手指，取消发送
//var kSendVoice = "" // 发送语音...
//var kTalkTimeTooShort = "" // 说话时间太短
//var kSendPictureSlower = "" // 发送图片较慢，耐心等待
////var kCollecting = "" // 收藏中
////var kCancleCollecting = "" // 取消收藏中
////var kCollectSuccess = "" // 已收藏
////var kCollectFaile = "" // 收藏失败
////var kCancleCollectSuccess = "" // 已取消收藏
////var kCancleCollectFaile = "" // 取消收藏失败
////var kFailedDetectCollectionStatus = "" // 检测收藏状态失败
//var kBeingConnected = "" // 正在连接...
//var kNetworkIsNotStable = "" // 当前网络不稳定
//var kThereIsNoCallData = "" // 当前没有通话数据
//var kNoResponse = "" // 暂时没有响应
//var kTheOtherPartyRefused = "" // 对方已拒绝
//var kTheOtherIsCalling = "" // 对方正在通话
//var kCallFailed = "" // 呼叫失败
//var kNotConnected = "" // 未连接
//var kCurrentNetworkConnectionFailed = "" // 当前网络连接失败
//var kSendFailed = "" // 发送失败
//var kSendPictureFailed = "" // 发送图片失败
//var kSubmission = "" // 提交
////var kInSubmission = "" // 提交中
////var kSubmissionSuccess = "" // 提交成功
////var kSubmissionFailed = "" // 提交失败
////var kDeleteSuccess = "" // 删除成功
//
//
//
//
//// 登录界面
//var kLoginLogin = "" // 立即登录
////var kOrganizationCode = "" // 机构代码
//var kLogin = "" // 登录
////var kPleaseSelectAClinic = "" // 请选择诊所
////var kPleaseChooseYourClinic = "" // 请选择您所在的诊所
//
//
//
//
//
//
//
//
//
//// main
//var kHomeTabBar = "" // 首页
//var kMessageTabBar = "" // 消息
//var kMedicalRecordTabBar = "" // 病历
//var kShoppingTabBar = "" // 商城
//var kMainProfileTabBar = "" // 我
//var kMainTabBarTitles = [String]()
//
//
//
//
//
//// home（首页）
//
//
//
//
//
//
//// 消息
//var kTitle = "" // 标题
//var kLoosenTheEnd = "" // 松开 结束
//var kMute = "" // 静音
//var kSpeaker = "" // 扬声器
//var kRefuse = "" // 拒绝
//var kAnswer = "" // 接听
//var kDoctorFollowUpText = "" // 医生向患者发起随访
//var kDoctorCloseFollowUpText = "" // 医生向患者关闭随访
//var kConsulationEndText = "" // 时间到了，咨询结束
//
//
//
//
//// 病历
//
//
//
//
//// 商城
//
//
//
//
//
//
//
//
//// 患者
////var kInitiateConversation = "" // 发起会话
////var kMedicalRecord = "" // 病历
////var kMedicalRecordDetails = "" // 病历详情
////var kCatalog = "" // 目录
////var kPatientsPlaechoder = "" // 输入患者姓名
////var kPatientHomePage = "" // 患者主页
//
//
//
//
//
//
//
//// 日程
////var kEventDetails = "" // 事件详情
////var kEdit = "" // 编辑
////var kEditEvent = "" // 编辑事件
////var kRemind = "" // 提醒
////var kDeleteEvent = "" // 删除事件
////
////var kSunday = "" // 日
////var kMonday = "" // 一
////var kTuesday = "" // 二
////var kWednesday = "" // 三
////var kThursday = ""  // 四
////var kFriday = ""  // 五
////var kSaturday = ""  // 六
////var kAddNewEvent = ""  // 新建事件
////var kAddNew = ""  // 新建
////var kAdd = ""  // 添加
////var kRemarks = ""  // 备注
////var kStart = ""  // 开始
////var kEnd = ""  // 结束
//////var kSaturday = ""  // 六
//////var kSaturday = ""  // 六
//////var kSaturday = ""  // 六
////var kMonths = ["", "", "", "", "", "", "", "", "", "", "", "", ""]
//
//
//
//
//// 患教
////var kHistoryRecord = "" // 历史记录
////var kClearHistoryRecord = "" // 清空历史
//
//
//
//
//
//
//// 我
//var kProfileMySetup = "" // 设置
//var kProfileInfoIcon = "" // 头像
//var kProfileInfoProfessional = "" // 职称
//var kPracticePoint = "" // 执业点
//var kConsultationScheduling = "" // 咨询排班
//var kIncome = "" // 收入
//var kProfileTitles = [String]()
//
//var kAddSchedule = "" // 添加排班
//var kModifyTheSchedule = "" // 修改排班
//var kNoScheduling = "" // 暂无排班
//var kTodaySchedule = "" // 今日排班
//var kCopyTheScheduleToDate = "" // 复制排班到其他日期
//var kTime = "" // 时间
//var kOnlineConsulting = "" // 在线咨询
//
//
//var kOriginalPassword = "" // 原密码
//var kNewPassword = "" // 新密码
//var kPleaseEnterOriginalPassword = "" // 请输入原密码
//var kPleaseEnterNewPassword = "" // 请输入新密码
//var kkPleaseEnterNewPasswordAgain = "" // 请再次输入新密码
//
//var kPleaseEnterYourComments = "" // 请输入您的意见
//var kContactInformation = "" // 联系方式：
//
//var kOnlineTelephone = "" // 在线电话
//var kAppointment = "" // 预约
//
//var kGraphicConsultationOneTime = "" // 图文咨询/次
//var kOnlineTelephoneOneTime = "" // 在线电话/次
//var kTotal = "" // 合计
//var kAccumulatedIncome = "" // 累计收入
//var kPleaseEnterPriceAMoment = "" // 请输入价格 元/15分钟
//var kStartTime = "" // 开始时间
//var kEndTime = "" // 结束时间
//
//var kPleaseSelectStartTime = "" // 请选择开始时间
//var kPleaseChooseEndTime = "" // 请选择结束时间
//var kEndTimeShouldBeGreaterThanStartTime = "" // 结束时间需大于开始时间
//var kPleaseSelectPictureOrOnlineTelephone = "" // 请选中图文咨询或在线电话
//var kPleaseEnterThePrice15Minutes = "" // 请输入图文咨询价格/15分钟
//var kPleaseEnterTheOnlinePhonePrice15Minutes = "" // 请输入在线电话价格/15分钟
//
//
//var kProfileIncomeStatistics = ""  // 收入统计
//var kProfileEvaluationAnalysis = ""  // 评价分析
//var kProfileGeneral = ""  // 通用
//var kProfileFeedback = "" // 意见反馈
//var kProfileShareApp = "" // 分享
//var kProfileSignOut = "" // 退出登录
//
//var kProfileLanguage = "" // 语言
//var kModifyPassword = "" // 修改密码
//
//var kProfileFeedbackTip = "" // 您的意见，对我们非常重要
//var kProfileFeedbackPlacehoder = "" // 请输入...
//var kProfileFeedbackAnonymous = "" // 匿名
//var kProfileViewComments = "" // 查看评论
//var kFailedToGetData = "" // 获取数据失败
//var kMonthlyBill = "" // 当月账单
//var kTotalBill = "" // 总账单
//var kBill = "" // 账单
//var kPictureConsulting = "" // 图文咨询
//var kVoiceConsulting = "" // 在线电话
//var kYear = "" // 年
//
//
//var kCommentAndAnalysis = "" // 评价分析
//var kCommentOfTheMonth = "" // 当月评论
//var kComment = "" // 评论
//
//var kCumulativePraise = "" // 累计好评
//var kCumulativeAssessment = "" // 累计中评
//var kCumulativeDifference = "" // 累计差评
//var kAraise = "" // 好评
//var kAssessment = "" // 中评
//var kDifference = "" // 差评
//var kCommonly = "" // 一般
//var kOutpatientDepartment = "" // 门诊
//var kOutpatientAppointment = "" // 门诊预约
//var kConsultationAppointment = "" // 咨询预约
//
//
//
//// 其他
//var kCancle = "" // 取消
//var kOver = "OK" // 完成
//var kAttchment = "" // 附件
//var kDetailsDescription = "" // 详情描述
//var kMonth = "" // 月
//var kGood = "" // 好
//var kEnsure = "OK" // 确定
//var kSearchResult = "" // 搜索结果
//var kSavePicture = "" // 保存图片
//var kShareTo = "" // 分享至
//var kChoicePicture = "" // 图片
//var kChoiceMakePhone = "" // 拍照
//var kTelePhone = "" // 电话
//var kAge = "" // 岁
//var kMinutesAgo = "" // 分钟前
//var kHoursAgo = "" // 小时前
//var kYesterday = "" // 昨天
//var kJust = "" // 刚刚
//var kPleaseInput = "" // 请输入
//var kSave = "" // 保存
//var kSaving = "" // 保存中
//var kSaveSuccess = "" // 保存成功
//var weeks = ["", "", "", "", "", "", ""]
//var kY = "" // 年
//var kM = "" // 月
//var kD = "" // 日
//var kMale = "" // 男
//var kFemale = "" // 女
//
//
//
//
//
//
//
//
///**************************************************************************/
//
//var kWordTooMuch = "" // 亲，文字太多了
//var kChooseDate = "" // 选择日期
//var kPlaseChooseDate = "" // 请选择复制日期
//var kPleaseConfirm = "" // 请确认
//var kNewWillCoveTheOriginal = "" // 请确认
////After the confirmation, the new row will cover the original row
//var kEventDescriptionCannotBeEmpty = "" // 事件描述不能为空
//var kFollowedUpTip = "" // 随访
//
//var kNoAdmissionsTip = "" // 医生未接诊，该咨询结束
//var kAdmissionsTip = "" // 医生已接诊，待患者付款
//var kNoPaymentTip = "" // 患者未付款，该咨询结束
//var kHasPaymentTip = "" // 患者已付款，开始咨询
//var kTimeToTheEndTip = "" // 时间到了，该咨询结束
//var kDoctorOpenFollowUpTip = "" // 医生向患者开启随访
//var kTheEndOfTheFollowUpTip = "" // 该随访结束
//var kPullDownRefresh = "" // 下拉刷新
//var kLetRefresh = "" // 松开刷新
//var kRefreshing = "" // 正在刷新
//var kRefreshSuccess = "" // 刷新成功
//var kRefreshFailed = "" // 刷新失败
//var kNewPasswordNotUnified = "" // 新密码不一致
//
//var SMTZ = "" // 生命体征
//var GMLB = "" // 过敏列表
//var JWS = "" // 既往史
//var JZS = "" // 家族史
//var JBLB = "" // 疾病列表
//var YYLB = "" // 用药列表
//var YMLB = "" // 疫苗列表
//var SYSJC = "" // 实验室检查
//var JZJL = "" // 就诊记录
//
//var kPleaseAllowReceiveNotifications = "" // 关掉通知将影响我们对您的事件提醒功能，请允许接收通知
//var kNextClickOK = "" // 接下来，请点击“好”
//var kGoToSetup = "" // 去设置
//var kNotGoToSetup = "" // 暂不设置
//var kWhetherOpenNotification = "" // "您的通知功能已关闭，这将影响事件通知功能，是否去打开通知？"
//
//var kConflictWithExistingSchedulingTime = "" // 与已有排班时间冲突
//var kDeleteSchedule = "" // 删除排班
//
//
//
//class ChangeLanguage: NSObject {
//    
//    class func shareChangeLanguage() -> ChangeLanguage{
//        return tools
//    }
//
//    fileprivate static let tools: ChangeLanguage = {
//        let manager = ChangeLanguage()
//        return manager
//    }()
//    
//    // MARK:- 是否为英文环境
//    func isEnglishEnvironmental() -> Bool {
//        return defaults.object(forKey: kIsEnglishKey) as? Bool ?? false
//    }
//    
//    // MARK:- 切换中英文环境
//    func toChangeLanguage() {
//        let isEnglish = defaults.object(forKey: kIsEnglishKey) as? Bool ?? false
//        LLog(isEnglish)
//
//        // 提示内容
////        kEnterUserName = isEnglish ? "Please enter your user name" : "请输入用户名"
////        kUserNameOrPasswordError = isEnglish ? "Incorrect username or password" : "用户名或密码错误"
////        kLogining = isEnglish ? "Logging" : "登录中"
////        kSiging = isEnglish ? "Logging off" : "退出中"
////        kSignOutSuccess = isEnglish ? "Logged off" : "退出成功"
//        kNetworkTip = isEnglish ? "Unable to connect" : "网络异常，请检查网络设置"
//        kPleaseEnterContent = isEnglish ? "Enter Content Here" : "请输入内容"
//        kShareSuccessTip = isEnglish ? "Sharing successful" : "分享成功"
//        kShareFaileTip = isEnglish ? "Sharing failed" : "分享失败"
//        kLoggedOnOtherDevicesTip = isEnglish ? "This account is logged on to other devices" : "此账号在其它设备上登录了"
//        kAnAccountCanOnlyLoggedOnOneDeviceTip = isEnglish ? "In order to ensure that you can successfully communicate with your patients, Only one account can be logged in on one device at the same time." : "为了保障您能顺利接受患者会话，一个账号只能同时在一个设备上登录。"
//        kISeeTip = isEnglish ? "Already know" : "知道了"
//        kPlaceText = isEnglish ? "Nothing" : "暂无"
//        kSavePictureFiled = isEnglish ? "Error when saving picture" : "保存图片出错"
//        kSavePictureSuccess = isEnglish ? "The picture saved successfully" : "保存图片成功"
//        kCircleOfFriends = isEnglish ? "Moments" : "朋友圈"
//        kWeChat = isEnglish ? "WeChat" : "微信"
//        kMicroBlog = isEnglish ? "WeiBo" : "微博"
//        kQQZone = isEnglish ? "Qzone" : "QQ空间"
////        kFriendshipTips = isEnglish ? "Reminder" : "友情提示"
////        kSaveFailTip = isEnglish ? "Saving failed" : "保存失败"
////        kCancleSend = isEnglish ? "The Finger slips up and cancel sending" : "手指向上滑，取消发送"
//        kCancleSend = isEnglish ? "Finger slips up to cancel" : "手指向上滑，取消发送"
////        kLoosenFingerCancleSend = isEnglish ? "Release the finger and cancel sending" : "松开手指，取消发送"
//        kLoosenFingerCancleSend = isEnglish ? "Release finger to cancel" : "松开手指，取消发送"
//        kSendVoice = isEnglish ? "Sending voice" : "发送语音..."
//        kTalkTimeTooShort = isEnglish ? "Talk time is too short" : "说话时间太短"
//        kSendPictureSlower = isEnglish ? "Please wait patiently" : "发送图片较慢，耐心等待"
////        kCollecting = isEnglish ? "Collecting" : "收藏中"
////        kCancleCollecting = isEnglish ? "Cancel the collecting" : "取消收藏中"
////        kCollectSuccess = isEnglish ? "Already collected" : "已收藏"
////        kCollectFaile = isEnglish ? "Collecting failed" : "收藏失败"
////        kCancleCollectSuccess = isEnglish ? "Collecting already cancelled" : "已取消收藏"
////        kCancleCollectFaile = isEnglish ? "Cancell Collecting Failed" : "取消收藏失败"
////        kFailedDetectCollectionStatus = isEnglish ? "Failed to detect collection status" : "检测收藏状态失败"
////        kFailedDetectCollectionStatus = isEnglish ? "Error" : "检测收藏状态失败"
//        kBeingConnected = isEnglish ? "Connecting" : "正在连接"
//        kNetworkIsNotStable = isEnglish ? "Network unstable" : "当前网络不稳定"
//        kThereIsNoCallData = isEnglish ? "No call logs" : "当前没有通话数据"
//        kNoResponse = isEnglish ? "No response so far" : "暂时没有响应"
//        kTheOtherPartyRefused = isEnglish ? "The other party rejected" : "对方已拒绝"
//        kTheOtherIsCalling = isEnglish ? "The other is busy" : "对方正在通话"
//        kCallFailed = isEnglish ? "Call failed" : "呼叫失败"
//        kNotConnected = isEnglish ? "Not connected" : "未连接"
//        kCurrentNetworkConnectionFailed = isEnglish ? "Network connecting failed" : "当前网络连接失败"
//        kSendFailed = isEnglish ? "Sending failed" : "发送失败"
//        kSubmission = isEnglish ? "Submit" : "提交"
////        kInSubmission = isEnglish ? "Submitting" : "提交中"
////        kSubmissionSuccess = isEnglish ? "Submitted successfully" : "提交成功"
////        kSubmissionFailed = isEnglish ? "Submitting failed" : "提交失败"
////        kDeleteSuccess = isEnglish ? "Deleted successfully" : "删除成功"
//
//        
//
//
//        
//        
//        
//        
//        // 登录界面
//        kLoginLogin = isEnglish ? "Log in" : "立即登录"
////        kOrganizationCode = isEnglish ? "Organization code" : "机构代码"
//        kLogin = isEnglish ? "Login" : "登录"
////        kPleaseSelectAClinic = isEnglish ? "Please select a clinic" : "请选择诊所"
////        kPleaseChooseYourClinic = isEnglish ? "Please choose your clinic" : "请选择您所在的诊所"
//
//        
//        
//        
//        
//        
//        // main
//        kMessageTabBar = isEnglish ? "Message" : "咨询"
//        kMedicalRecordTabBar = isEnglish ? "Medical Record" : "日程"
//        kShoppingTabBar = isEnglish ? "Shopping" : "患者"
//        kMainProfileTabBar = isEnglish ? "Me" : "我"
//        kMainTabBarTitles = [kHomeTabBar, kMessageTabBar, kMedicalRecordTabBar, kShoppingTabBar, kMainProfileTabBar]
//        
//        
//        
//        
//        
//        
//        // home（首页）
//        
//        
//        
//        
//        
//        
//        
//        
//
//        // 咨询
//        kSendPictureFailed = isEnglish ? "Picture-sending failed" : "发送图片失败"
//
//        kTitle = isEnglish ? "Title" : "标题"
//        kHoldDownToTalk = isEnglish ? "Press and to talk" : "按住 说话"
//        kLoosenTheEnd = isEnglish ? "Release for ending the talk" : "松开 结束"
//
//        kMute = isEnglish ? "Mute" : "静音"
//        kSpeaker = isEnglish ? "Loudspeaker" : "扬声器"
//        kRefuse = isEnglish ? "Reject" : "拒绝"
//        kAnswer = isEnglish ? "Answer" : "接听"
//
//        kDoctorFollowUpText = isEnglish ? "Doctors initiated follow-up" : "医生向患者发起随访"
//        kDoctorCloseFollowUpText = isEnglish ? "Doctors close up" : "医生向患者关闭随访"
////        kConsulationEndText = isEnglish ? "It's time to end the consultation" : "时间到了，咨询结束"
//        kConsulationEndText = isEnglish ? "It's time to end" : "时间到了，咨询结束"
//
//        kInitiateFollowUp = isEnglish ? "Initiate a follow up" : "发起随访"
//        kEndFollowUp = isEnglish ? "End the follow up" : "结束随访"
//
//        
//        
//        
//        
//        // 患者
////        kHistoryRecord = isEnglish ? "History records" : "历史记录"
////        kClearHistoryRecord = isEnglish ? "Empty history record" : "清空历史"
////        kInitiateConversation = isEnglish ? "Start talk" : "发起会话"
////        kMedicalRecord = isEnglish ? "Medical record" : "病历"
////        kMedicalRecordDetails = isEnglish ? "Detailed medical records" : "病历详情"
////        kCatalog = isEnglish ? "Catalog" : "目录"
////        kPatientsPlaechoder = isEnglish ? "Enter patient name" : "输入患者姓名"
////        kPatientHomePage = isEnglish ? "Patient home page" : "患者主页"
//
//        
//        
//
//        
//        
//        
//        // 日程
//        kEventDetails = isEnglish ? "Event details" : "事件详情"
//        kEdit = isEnglish ? "Editing" : "编辑"
//        kEditEvent = isEnglish ? "Editing the event" : "编辑事件"
//        kRemind = isEnglish ? "Remind" : "提醒"
//        kDeleteEvent = isEnglish ? "Delete the event" : "删除事件"
//        kSunday = isEnglish ? "S" : "日"
//        kMonday = isEnglish ? "M" : "一"
//        kTuesday = isEnglish ? "T" : "二"
//        kWednesday = isEnglish ? "W" : "三"
//        kThursday = isEnglish ? "T" : "四"
//        kFriday = isEnglish ? "F" : "五"
//        kSaturday = isEnglish ? "S" : "六"
//        kAddNewEvent = isEnglish ? "Creating event" : "新建事件"
//        kAddNew = isEnglish ? "Creating" : "新建事件"
//        kAdd = isEnglish ? "Add" : "添加"
//        kRemarks = isEnglish ? "Remarks" : "备注"
//        kStart = isEnglish ? "Start" : "开始"
//        kEnd = isEnglish ? "End" : "结束"
//        kMonths = isEnglish ? ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", " Oct", "Nov", "Dec", ""] : ["01月", "02月", "03月", "04月", "05月", "06月", "07月", "08月", "09月", "10月", "11月", "12月", ""]
//
//
//        
//        // 我
//        kProfileMySetup = isEnglish ? "Set up" : "设置"
//        kProfileInfoName = isEnglish ? "Full Name" : "姓名"
//        kProfileInfoProfessional = isEnglish ? "Job title" : "职称"
//        kPracticePoint = isEnglish ? "Practice setting" : "执业点"
//        kConsultationScheduling = isEnglish ? "Enquire scheduling" : "咨询排班"
//        kIncome = isEnglish ? "Income" : "收入"
//
//        kProfileTitles = isEnglish ? ["会员特权", "我的咨询", "我的预约", "我的关注", "家庭成员", "设置"] : ["会员特权", "我的咨询", "我的预约", "我的关注", "家庭成员", "设置"]
//
//
//        kAddSchedule = isEnglish ? "Add schedule" : "添加排班"
//        kModifyTheSchedule = isEnglish ? "Change the schedule" : "修改排班"
//        kNoScheduling = isEnglish ? "No scheduling" : "暂无排班"
//        kTodaySchedule = isEnglish ? "Today's schedule" : "今日排班"
//        kCopyTheScheduleToDate = isEnglish ? "Copy the schedule to other date" : "复制排班到其他日期"
//        kTime = isEnglish ? "Time" : "时间"
//        kOnlineConsulting = isEnglish ? "Telephone" : "在线咨询"
//
////        kOriginalPassword = isEnglish ? "Old password" : "原密码"
////        kNewPassword = isEnglish ? "New Password" : "新密码"
//        kOriginalPassword = isEnglish ? "Old" : "原密码"
//        kNewPassword = isEnglish ? "New" : "新密码"
//        kPleaseEnterOriginalPassword = isEnglish ? "Please enter the old password" : "请输入原密码"
//        kPleaseEnterNewPassword = isEnglish ? "Please enter a new password" : "请输入新密码"
//        kkPleaseEnterNewPasswordAgain = isEnglish ? "Please enter a new password again" : "请再次输入新密码"
//        kPleaseEnterYourComments = isEnglish ? "Please enter your comments" : "请输入您的意见"
////        kContactInformation = isEnglish ? "Contact information:" : "联系方式："
//        kContactInformation = isEnglish ? "Contact info:" : "联系方式："
////        kPleaseEnterMobilePhoneNumber = isEnglish ? "Please enter your phone numb(Optional)" : "请输入手机号（非必填）"
//        kPleaseEnterMobilePhoneNumber = isEnglish ? "Phone number(Optional)" : "请输入手机号（非必填）"
//        
//        
//        
//        
//        kOnlineTelephone = isEnglish ? "Telephone" : "在线电话"
//        kAppointment = isEnglish ? "Appointment" : "预约"
////        kGraphicConsultationOneTime = isEnglish ? "Per message Consultation" : "图文咨询/次"
////        kOnlineTelephoneOneTime = isEnglish ? "Per Telephone Consultation" : "在线电话/次"
//        kGraphicConsultationOneTime = isEnglish ? "Per message" : "图文咨询/次"
//        kOnlineTelephoneOneTime = isEnglish ? "Per Telephone" : "在线电话/次"
//        kTotal = isEnglish ? "Total" : "合计"
//        kAccumulatedIncome = isEnglish ? "Accumulated income" : "累计收入"
//        kPleaseEnterPriceAMoment = isEnglish ? "Price /15 minutes" : "请输入价格 元/15分钟"
//        kStartTime = isEnglish ? "The start time" : "开始时间"
//        kEndTime = isEnglish ? "The end time" : "结束时间"
//
//        
//        kPleaseSelectStartTime = isEnglish ? "Please choose start time" : "请选择开始时间"
//        kPleaseChooseEndTime = isEnglish ? "Please choose the end time" : "请选择结束时间"
////        kEndTimeShouldBeGreaterThanStartTime = isEnglish ? "The end time should be greater than the start time" : "结束时间需大于开始时间"
//        kEndTimeShouldBeGreaterThanStartTime = isEnglish ? "The end time is too short" : "结束时间需大于开始时间"
////        kPleaseSelectPictureOrOnlineTelephone = isEnglish ? "Please choose  Message Consultation or Telephone Consultation" : "请选中图文咨询或在线电话"
//        kPleaseSelectPictureOrOnlineTelephone = isEnglish ? "Please Choose something" : "请选中图文咨询或在线电话"
////        kPleaseEnterThePrice15Minutes = isEnglish ? "Please enter the Message Consultation price per 15 minutes" : "请输入图文咨询价格/15分钟"
//        kPleaseEnterThePrice15Minutes = isEnglish ? "Please enter the price" : "请输入图文咨询价格/15分钟"
////        kPleaseEnterTheOnlinePhonePrice15Minutes = isEnglish ? "Please enter the  Telephone Consultation price per 15 minutes" : "请输入在线电话价格/15分钟元"
//        kPleaseEnterTheOnlinePhonePrice15Minutes = isEnglish ? "Please enter the price" : "请输入在线电话价格/15分钟元"
//
//        
//
//        
//        
//        
//        kProfileIncomeStatistics = isEnglish ? "Income statistics" : "收入统计"
//        kProfileEvaluationAnalysis = isEnglish ? "Evaluation and analysis" : "评价分析"
//        kProfileGeneral = isEnglish ? "General" : "通用"
//        kProfileFeedback = isEnglish ? "Feedback" : "意见反馈"
//        kProfileShareApp = isEnglish ? "Sharing" : "分享"
//        kProfileSignOut = isEnglish ? "Log-off" : "退出登录"
//       
//        kProfileLanguage = isEnglish ? "Language" : "语言"
//        kModifyPassword = isEnglish ? " Change password " : "修改密码"
//        
//        kProfileFeedbackTip = isEnglish ? "Your opinion is very important to us." : "您的意见，对我们非常重要"
//        kProfileFeedbackPlacehoder = isEnglish ? "Please enter..." : "请输入..."
//        kProfileFeedbackAnonymous = isEnglish ? "Anonymous" : "匿名"
//        kProfileViewComments = isEnglish ? "View comments" : "查看评论"
//        kFailedToGetData = isEnglish ? "Failed to get data" : "获取数据失败"
//        kMonthlyBill = isEnglish ? "The current month  bill" : "当月账单"
//        kTotalBill = isEnglish ? "The total bill" : "总账单"
//        kBill = isEnglish ? "Bill" : "账单"
//        kPictureConsulting = isEnglish ? "Message Consultation" : "图文咨询"
//        kVoiceConsulting = isEnglish ? "Telephone" : "在线电话"
//        kYear = isEnglish ? "Year" : "年"
//        
////        kCommentAndAnalysis = isEnglish ? "Evaluation and analysis" : "评价分析"
//        kCommentAndAnalysis = isEnglish ? "Comments" : "评价分析"
//        kCommentOfTheMonth = isEnglish ? "Comments of this month" : "当月评论"
//        kComment = isEnglish ? "Comments" : "评论"
//
//        kCumulativePraise = isEnglish ? "Total Excellent" : "累计好评"
//        kCumulativeAssessment = isEnglish ? "Total  Good" : "累计中评"
//        kCumulativeDifference = isEnglish ? "Total Poor" : "累计差评"
//
//        kAraise = isEnglish ? "Excellent" : "好评"
//        kAssessment = isEnglish ? "Good" : "中评"
//        kDifference = isEnglish ? "Poor" : "差评"
//        kCommonly = isEnglish ? "Average" : "一般"
//        kOutpatientDepartment = isEnglish ? "Outpatient Clinic" : "门诊"
//        kOutpatientAppointment = isEnglish ? "Outpatient appointment" : "门诊预约"
//        kConsultationAppointment = isEnglish ? "Consultation appointment" : "咨询预约"
//
//
//
//        
//        
//        
//        // 其他
//        kCancle = isEnglish ? "Cancel" : "取消"
//        kOver = isEnglish ? "Complete" : "完成"
//        kAttchment = isEnglish ? "Enclosure:" : "附件："
//        kDetailsDescription = isEnglish ? "Details description" : "详情描述"
//        kMonth = isEnglish ? "Month" : "月"
//        kGood = isEnglish ? "Good" : "好"
//        kEnsure = isEnglish ? "OK" : "确定"
//        kSearchResult = isEnglish ? "Search result" : "搜索结果"
//        kSavePicture = isEnglish ? "Save picture" : "保存图片"
//        kShareTo = isEnglish ? "Share to" : "分享至"
//        kChoicePicture = isEnglish ? "Picture" : "图片"
//        kChoiceMakePhone = isEnglish ? "Take photos" : "拍照"
//        kTelePhone = isEnglish ? "Phone" : "电话"
//        kAge = isEnglish ? "Age" : "岁"
//        kMinutesAgo = isEnglish ? "Minutes ago" : "分钟前"
//        kHoursAgo = isEnglish ? "Hours ago" : "小时前"
//        kYesterday = isEnglish ? "Yesterday" : "昨天"
//        kJust = isEnglish ? "Just now" : "刚刚"
//        kPleaseInput = isEnglish ? "Please enter" : "请输入"
//        kSaving = isEnglish ? "Saving" : "保存中"
//        kSaveSuccess = isEnglish ? "Saved successfully" : "保存成功"
//        weeks = isEnglish ? ["S", "M", "T", "W", "T", "F", "S"] : [kSunday, kMonday, kTuesday, kWednesday, kThursday, kFriday, kSaturday]
//        kY = isEnglish ? "Y" : "年"
//        kM = isEnglish ? "M" : "月"
//        kD = isEnglish ? "D" : "日"
//        kMale = isEnglish ? "male" : "男"
//        kFemale = isEnglish ? "female" : "女"
//
//        
//        
//        
//        
//        
//        /**************************************************************************/
//        
//        kWordTooMuch = isEnglish ? "Words too much" : "亲，文字太多了"
//        kChooseDate = isEnglish ? "Choose date" : "选择日期"
//        kPlaseChooseDate = isEnglish ? "Please choose date" : "请选择复制日期"
//        kPleaseConfirm = isEnglish ? "Please confirm" : "请确认"
//        kNewWillCoveTheOriginal = isEnglish ? "After the confirmation, the new row will cover the original row" : "确定后，新的排期将覆盖原有排期"
//        kEventDescriptionCannotBeEmpty = isEnglish ? "Description cannot be nil" : "事件描述不能为空"
//        kFollowedUpTip = isEnglish ? "Follow-up" : "随访"
//        
//        kNoAdmissionsTip = isEnglish ? "No admissions, the consultation ended" : "医生未接诊，该咨询结束"
//        kAdmissionsTip = isEnglish ? "The doctor has to be patient admissions, payment" : "医生已接诊，待患者付款"
//        kNoPaymentTip = isEnglish ? "No payment, the consultation concluded" : "患者未付款，该咨询结束"
//        kHasPaymentTip = isEnglish ? "Patients have been paid, began consulting" : "患者已付款，开始咨询"
//        kTimeToTheEndTip = isEnglish ? "Time to the end of the consultation" : "时间到了，该咨询结束"
//        kDoctorOpenFollowUpTip = isEnglish ? "The doctor open follow-up" : "医生向患者开启随访"
//        kTheEndOfTheFollowUpTip = isEnglish ? "The end of the follow-up" : "该随访结束"
//        kPullDownRefresh = isEnglish ? "Pull down refresh" : "下拉刷新"
//        kLetRefresh = isEnglish ? "Let refresh" : "松开刷新"
//        kRefreshing = isEnglish ? "Refreshing" : "正在刷新"
//        kRefreshSuccess = isEnglish ? "Success" : "刷新成功"
//        kRefreshFailed = isEnglish ? "Failed" : "刷新失败"
//        kNewPasswordNotUnified = isEnglish ? "New password not unified" : "新密码不一致"
//
//        SMTZ = isEnglish ? "生命体征" : "生命体征"
//        GMLB = isEnglish ? "过敏列表" : "过敏列表"
//        JWS = isEnglish ? "既往史" : "既往史"
//        JZS = isEnglish ? "家族史" : "家族史"
//        JBLB = isEnglish ? "疾病列表" : "疾病列表"
//        YYLB = isEnglish ? "用药列表" : "用药列表"
//        YMLB = isEnglish ? "疫苗列表" : "疫苗列表"
//        SYSJC = isEnglish ? "实验室检查" : "实验室检查"
//        JZJL = isEnglish ? "就诊记录" : "就诊记录"
//        
//        kPleaseAllowReceiveNotifications = isEnglish ? "Turn off the notification will affect our event reminder function to you, please allow the receiving notification" : "关掉通知将影响我们对您的事件提醒功能，请允许接收通知"
//        kNextClickOK = isEnglish ? "Next, click \"OK\"" : "接下来，请点击“好”"
//        kGoToSetup = isEnglish ? "OK" : "好"
//        kNotGoToSetup = isEnglish ? "NO" : "不设置"
//        kWhetherOpenNotification = isEnglish ? "Your notification function has been closed, which will affect the event notification function, whether to open the notification?" : "您的通知功能已关闭，这将影响事件通知功能，是否去打开通知？"
//
//        kConflictWithExistingSchedulingTime = isEnglish ? "Conflict with existing scheduling time" : "与已有排班时间冲突"
//        kDeleteSchedule = isEnglish ? "Delete schedule" : "删除排班"
//        kCcountSecurity = isEnglish ? "Account and security" : "账号与安全"
//
//    }
//
//}





















/**
 * 提示
 */

var kNetworkTip = "" // 网络异常，请检查网络设置
var kPleaseEnterContent = "" // 请输入内容
var kLoading = "" // 加载中
var kLoadFaileTip = "" // 加载失败
var kLoadSuccessTip = "" // 加载成功
var kShareSuccessTip = "" // 分享成功
var kShareFaileTip = "" // 分享失败
var kCancleShareTip = "" // 取消分享
var kLoginSuccess = "" // 登录成功
var kLoginFail = "" // 登录失败
var kCancleLogin = "" // 取消登录
var kLoggedOnOtherDevicesTip = "" // 此账号在其它设备上登录了
var kAnAccountCanOnlyLoggedOnOneDeviceTip = "" // 为了保障您能顺利接受患者会话，一个账号只能同时在一个设备上登录。
var kISeeTip = "" // 知道了
var kPlaceText = "" // 暂无
var kSavePictureFiled = "" // 保存图片出错
var kSavePictureSuccess = "" // 保存图片成功
var kCopyLink = "" // 拷贝链接
var kCircleOfFriends = "" // 朋友圈
var kWeChat = "" // 微信
var kMicroBlog = "" // 微博
var kQQZone = "" // QQ空间
var kCancleSend = "" // 手指向上滑，取消发送
var kLoosenFingerCancleSend = "" // 松开手指，取消发送
var kSendVoice = "" // 发送语音...
var kTalkTimeTooShort = "" // 说话时间太短
var kSendPictureSlower = "" // 发送图片较慢，耐心等待
var kBeingConnected = "" // 正在连接...
var kNetworkIsNotStable = "" // 当前网络不稳定
var kThereIsNoCallData = "" // 当前没有通话数据
var kNoResponse = "" // 暂时没有响应
var kTheOtherPartyRefused = "" // 对方已拒绝
var kTheOtherIsCalling = "" // 对方正在通话
var kCallFailed = "" // 呼叫失败
var kNotConnected = "" // 未连接
var kCurrentNetworkConnectionFailed = "" // 当前网络连接失败
var kSendFailed = "" // 发送失败
var kSendPictureFailed = "" // 发送图片失败
var kSubmission = "" // 提交
var kPullDownRefresh = "" // 下拉刷新
var kLetRefresh = "" // 松开刷新
var kRefreshing = "" // 正在刷新
var kRefreshSuccess = "" // 刷新成功
var kRefreshFailed = "" // 刷新失败
var kNewPasswordNotUnified = "" // 新密码不一致
var kLinkHasBeenCopied = "" // 已经复制链接
var kDeleteSuccess = "" // 已删除
var kSendNetworkRequest = "" // 发送网络请求
var kPleaseEnterValidPassword = "" // 请输入有效密码











/**
 * 登录、注册等
 */
var kLoginLogin = "" // 立即登录
var kLogin = "" // 登录
var kCellPhoneNumberMedicalRecordNumber = "" // 手机号 / 病历号
var kLoginPasswordPlacehoder = "" // 密码
var kForgetPassword = "" // 忘记密码
var kWeChatLogin = "" // 微信登录
var kMicroBlogLogin = "" // 微博登录
var kQQLogin = "" // QQ登录
var kRegister = "" // 注册
var kOtherWaysToLogin = "" // 其他方式登录
var kPhoneNumberRegister = "" // 手机号注册
var kResetPassword = "" // 重置密码
var kPhoneNumberBinding = "" // 手机号绑定
var kPleaseEnterVerificationCode = "" // 请输入验证码
var kVerify = "" // 验证
var kPleaseEnterCellPhoneNumber = "" // 请输入您的手机号
var kReSend = "" // 重新发送
var kSetPasswordDigitLetter = "" // 设置密码，6-16位数字或字母
var kReadAgree = "" // 已阅读并同意
var kRuiBaoPrivacyAgreement = "" // 《睿宝隐私协议》
var kMedicalRecordBinding = "" // 病历绑定
var kNewPatient = "" // 新增就诊人
var kRelatedFamilyMembers = "" // 关联家庭成员病历
var kAccountNumber = "" // 账号
var kAfterInitialTreatmentTip = "" // 初次就诊后，诊所为患者生成账号密码并发送到手机
var kEnterAccount = "" // 请输入账号
var kEnterPassword = "" // 请输入密码
var kID = "" // 身份证
var kPassport = "" // 护照
var kPleaseSelect = "" // 请选择
var kNameOfPatient = "" // 就诊人姓名
var kPinyin = "" // 拼音
var kYES = "" // 有
var kNO = "" // 无
var kSex = "" // 性别
var kDateOfBirth = "" // 出生日期
var kTypeOfIDCard = "" // 身份证类型
var kPleaseEnterIDNumber = "" // 请输入证件号
var kAddress = "" // 住址
var kProvinceCityDistrict = "" // 请选择 省/市/区
var kDetailedAddress = "" // 请填写详细地址
var WhetherThereInsuranceCard = "" // 是否保卡
var kInsuranceType = "" // 保险类型
var kInsuranceCardNumber = "" // 保险卡号
var kFather = "" // 父亲
var kMother = "" // 母亲
var kName = "" // 姓名
var kgoToTheClinicToChangeTip = "" // 确认后就诊人信息只能去诊所进行更改
var kSelectTypeInsurance = "" // 选择保险类型
var kBindingMedicalRecords = ["已建病历，进行绑定", "初诊，完善信息", "只是看看"] // 选择保险类型
var kNextStep = "" // 下一步











/**
 * main
 */
var kHomeTabBar = "" // 首页
var kMessageTabBar = "" // 消息
var kMedicalRecordTabBar = "" // 病历
var kShoppingTabBar = "" // 商城
var kMainProfileTabBar = "" // 我
var kMainTabBarTitles = [String]()













/**
 * 首页
 */
var kDoctorsPlaechoder = "" // 输入医生姓名
var kHistoryRecord = "" // 历史记录
var kClearHistoryRecord = "" // 清空历史
var kClearAllQueryHistoryTip = "" // 清除全部查询历史记录？
var kMakeAnAppointment = "" // 预约挂号
var kOnlineConsultation = "" // 在线咨询
var kMostPopular = "" // 热门资讯
var kArticleDetail = "" // 文章详情
var kEventDetails = "" // 活动详情
var kClinic = "" // 诊所
var kDepartment = "" // 科室
var kTotal = "" // 全部
var kThereIsNo = "" // 有号
var kThis = "" // 约满
var kInterrogation = "" // 问诊量
var kScheduling = "" // 排班
var kMorning = "" // 上午
var kAfternoon = "" // 下午
var kSearch = "" // 搜索
var kConsultation = "" // 咨询
var kTextConsulting = "" // 图文咨询
var kTextPictureConsulting = "" // 通过文字图片咨询
var kOnlineTelephone = "" // 在线电话
var kTelephoneConsultationThroughTextPictures = "" // 通过文字图片电话咨询
var kElement = "" // 元
var kMinute = "" // 分钟
var kQuitTheEditor = "" // 退出此次编辑
var kQuit = "" // 退出
var kPutQuestionsTo = "" // 提问
var kPleaseEnterTheNameOfTheDisease = "" // 请输入疾病名称
var kPleaseSpecifyYourCondition = "" // 请详述您的病情
var kPatient = "" // 患者
var kDiseaseName = "" // 疾病名称
var kPleaseEnterDiseaseName = "" // 请输入疾病名称
var kDetailsOfYourIllnessEtc = "" // 详述您的病情、症状、治疗经过、想要获得的帮助等
var kSelectPhotos = "" // 选择照片
var kSelectFromTheAlbum = "" // 从相册选择
var kToSet = "" // 去设置
var kCamera = "" // 相机
var kAlbum = "" // 相册
var kDeleteThisPicture = "" // 要删除这张照片吗？
var kSelectPatient = "" // 选择患者
var kOnLine = "" // 在线
var kOffLine = "" // 离线
var kPleaseInputKeyWord = "" // 输入关键字



















/**
 * 消息
 */
var kChoicePicture = "" // 图片
var kChoiceMakePhone = "" // 拍照
var kTelePhone = "" // 电话
var kFollowedUpTip = "" // 随访
var kNoAdmissionsTip = "" // 医生未接诊，该咨询结束
var kAdmissionsTip = "" // 医生已接诊，待患者付款
var kNoPaymentTip = "" // 患者未付款，该咨询结束
var kHasPaymentTip = "" // 患者已付款，开始咨询
var kTimeToTheEndTip = "" // 时间到了，该咨询结束
var kDoctorOpenFollowUpTip = "" // 医生向患者开启随访
var kTheEndOfTheFollowUpTip = "" // 该随访结束
var kHoldDownToTalk = "" // 按住 说话
var kLoosenTheEnd = "" // 松开 结束
var kMute = "" // 静音
var kSpeaker = "" // 扬声器
var kRefuse = "" // 拒绝
var kAnswer = "" // 接听
var kConsultationIsOver = "" // 咨询结束
var kClose = "" // 关闭
var kThePatientHasBeenWaiting = "" // 待接诊
var kHasBeenWaitingForPatientsToPay = "" // 等待患者付款
var kConsulting = "" // 咨询中
var kConfirmationOfReception = "" // 确认接诊
var kInformationError = "" // 信息出错
var kHasTimedOut = "" // 已超时
var k15MinuteCountdown = "" // 15分钟倒计时
var k20MinuteCountdown = "" // 20分钟倒计时
var kTheInterrogationIsOver = "" // 本次问诊已结束
var kTheFollowUpIsOver = "" // 本次随访已结束
var kInitiateFollowUp = "" // 发起随访
var kEndFollowUp = "" // 结束随访
var kBeingFollowedUp = "" // 随访中
var kFollowUpIsOver = "" // 随访已结束
var kNewMessageTip = "" // 留言
var kSureToSendTo = "" // 确定发送给：
var kSending = "" // 正在发送
var kPatientName = "" // 患者名称
var kRuiBaoPhone = "" // 睿宝电话
var kRecentChat = "" // 最近聊天
var kConsultationVoice = "" // 语音
var kAlbumLicenseNotOpen = "" // 相册授权未开启
var kCameraLicenseNotTurnedOn = "" // 相机授权未开启
var kPleaseOpenTheAlbumAuthorizationInTheSystemSettings = "" // 请在系统设置中开启相册授权
var kPleaseOpenTheCameraAuthorizationInTheSystemSettings = "" // 请在系统设置中开启相机授权
var kDoctorHomePage = "" // 医生主页
var kFollow = "" // 关注
var kPracticePoint = "" // 执业点：
var kSpecialty = "" // 擅长
var kBriefIntroduction = "" // 简介
var kPatientEvaluation = "" // 患者评价
var kPeople = "" // 人
var kDoctorEvaluation = "" // 医生评价
var kDoctorEvaluationTip = "" // 注：4-5颗星为好评，3颗星为中评，1-2颗星为差评






















/**
 * 病历
 */
var SMTZ = "" // 生命体征
var GMLB = "" // 过敏列表
var JWS = "" // 既往史
var JZS = "" // 家族史
var JBLB = "" // 疾病列表
var YYLB = "" // 用药列表
var YMLB = "" // 疫苗列表
var SYSJC = "" // 实验室检查
var JZJL = "" // 就诊记录
var kMedicalRecordDetails = "" // 病历详情
var kCatalog = "" // 目录
var kTheAllergy = "" // 过敏源
var kType = "" // 类型
var kDegree = "" // 程度
var kReaction = "" // 反应
var kStart = "" // 开始
var kEnd = "" // 停止
var kNoteTaker = "" // 记录人
var kAllergyDetails = "" // 过敏详情
var kDisease = "" // 疾病
var kDescribe = "" // 描述
var kDiseaseDetails = "" // 疾病详情
var kListOfDiseases = "" // 疾病列表
var kRecordNumber = "" // 记录号
var kVisitingTime = "" // 看诊时间
var kOutpatientType = "" // 门诊类型
var kChiefComplaint = "" // 主诉
var kDiagnosis = "" // 诊断
var kJiuZhenJiLuDetails = "" // 就诊记录详情
var kListOfMedicalRecords = "" // 就诊记录列表
var kAllergy = "" // 过敏：
var kFrequencyMinute = "" // 次/分
var kRecordTime = "" // 记录时间
var kTemperature = "" // 体温
var kPulseBreathing = "" // 脉搏/呼吸
var kWeightHeight = "" // 体重/身高
var kBloodOxygenSaturation = "" // 血氧饱和度
var kSystolicPressureDiastolicPressure = "" // 收缩压/舒张压
var kVaccineName = "" // 疫苗名
var kMethod = "" // 方法
var kPosition = "" // 位置
var kDose = "" // 剂量
var kFrequency = "" // 次数
var kTime = "" // 时间
var kDrugName = "" // 药品名
var kUsage = "" // 用法

var kYongYaoDetails = "" // 用药详情
var kVaccineDetails = "" // 疫苗详情
var kListOfLaboratoryTests = "" // 实验室检查列表
var kLaboratoryExaminationDetails = "" // 实验室检查详情
var kResult = "" // 结果
var kMore = "" // 更多






/**
 * 商城
 */
//兑换记录
//商品详情
//立即兑换
//商品简介
//使用范围
//使用有效期
//兑换流程
//注意事项
//客服电话
//商家简介
//确认订单
//"自取" : "快递"
//请选择配送方式
//商品
//购买数量
//配送方式
//请选择配送方式
//获取规则
//积分商城
//兑换详情
//配送方式：
//收货人：
//地址：
//商品总价：
//联系客服
//选择配送方式
//新增地址
//新增收货地址
//保存地址










/**
 * 我
 */
var kProfileMySetup = "" // 设置
var kOriginalPassword = "" // 原密码
var kNewPassword = "" // 新密码
var kPleaseEnterOriginalPassword = "" // 请输入原密码
var kPleaseEnterNewPassword = "" // 请输入新密码
var kkPleaseEnterNewPasswordAgain = "" // 请再次输入新密码
var kPleaseEnterYourComments = "" // 请输入您的意见
var kContactInformation = "" // 联系方式：
var kPleaseEnterMobilePhoneNumber = "" // 请输入手机号（非必填）
var kProfileLanguage = "" // 语言
var kCcountSecurity = "" // 账号与安全
var kModifyPassword = "" // 修改密码
var kProfileFeedback = "" // 意见反馈
var kProfileSignOut = "" // 退出登录
var kProfileShareApp = "" // 分享
var kWordTooMuch = "" // 亲，文字太多了
var kMembershipPrivileges = "" // 会员特权
var kMyConsultation = "" // 我的咨询
var kMyAppointment = "" // 我的预约
var kMyCollection = "" // 我的关注
var kMemberOfFamily = "" // 家庭成员
var kSetup = "" // 设置
var kProfileTitles = [String]()
var kNotBound = "" // 未绑定
var kEssentialInformation = "" // 基本信息
var kProfileInfoIcon = "" // 头像
var kCommonlyUsedMedicalTreatment = "" // 常用就诊人
var kAddNewlyDiagnosedPatient = "" // 添加初诊患者
var kAddTheReferralOfPatients = "" // 添加复诊患者
var kRelationship = "" // 关系
var kPhoneNumber = "" // 手机号
var kAddAContact = "" // 添加联系人
var kProfileInfo = "" // 个人信息
var kPhoneNumber2 = "" // 手机号
var kHomePhone = "" // 家庭电话
var kMailbox = "" // 邮箱
var kWechatNumber = "" // 微信号
var kRequired = "" // 必填
var kNonMandatory = "" // 非必填
var kMemberRecharge = "" // 会员充值
var kMemberRechargeTip = "" // 提示：一次充值2万元，可升级黄金会员
var kRoseGoldMember = "" // 玫瑰金会员
var kGoldMember = "" // 黄金会员
var kPlatinumMember = "" // 铂金会员
var kRecharge = "" // 充值
var kAmountOfMoney = "" // 金额
var kEnterAmountRecharge = "" // 请输入充值金额
var kPaymentMethod = "" // 支付方式
var kWeChatPayment = "" // 微信支付
var kAlipayToPay = "" // 支付宝支付
var kRechargeConfirmation = "" // 确认充值
var kBookingInformation = "" // 预约信息
var kBookingDetails = "" // 预约详情
var kConsultationDetails = "" // 咨询详情
var kMedicalHospital = "" // 就诊医院
var kMedicalDepartment = "" // 就诊科室
var kClinicHours = "" // 门诊时间
var kRegistrationFee = "" // 挂号费用
var kRealNameSystemAppointmentTip = "" // 实名制预约，就诊人信息不符将无法取号。停诊将短信通知，请保持手机通畅。
var kPatientVisits = "" // 就诊人
var kDiseaseInformation = "" // 疾病信息
var kReservationType = "" // 预约类型
var kPendingPayment = "" // 待付款
var kCanceled = "" // 已取消
var kToBeEvaluated = "" // 待评价
var kConsultingAgain = "" // 再次咨询
var kConcernedDoctor = "" // 关注的医生
var kConcernedArticle = "" // 关注的文章
var kBindAccount = "" // 账号绑定
var kCurrentAccount = "" // 当前账号
var kMicroBlogSina = "" // 新浪微博
var kTencentQQ = "" // 腾讯QQ
var kPhone = "" // 手机
var kCurrentBindingPhoneNumber = "" // 当前绑定手机号
var kCurrentBindMedicalRecordNumber = "" // 当前绑定病历号













/**
 * 其它
 */
var kMale = "" // 男
var kFemale = "" // 女
var kOver = "OK" // 完成
var kEnsure = "OK" // 确定
var kAge = "" // 岁
var kShareTo = "" // 分享至
var kCancle = "" // 取消
var kMinutesAgo = "" // 分钟前
var kHoursAgo = "" // 小时前
var kYesterday = "" // 昨天
var kJust = "" // 刚刚
var kPleaseInput = "" // 请输入
var kSavePicture = "" // 保存图片
var kNothing = "" // 无
var kWhenTheEventOccurs = "" // 事件发生时
var k5MinutesAgo = "" // 5 分钟前
var k15MinutesAgo = "" // 15 分钟前
var k30MinutesAgo = "" // 30 分钟前
var k1HoursAgo = "" // 1 小时前
var k2HoursAgo = ""  // 2 小时前
var k1DaysAgo = ""  // 1 天前
var k2DaysAgo = "" // 2 天前
var k1WeeksAgo = "" // 1 周前
var kNoConsultationRecordsTip = "" // 暂无咨询记录
var kNoArrangementsTip = "" // 今天还没安排喔
var kNoPatientsTip = "" // 暂无患者
var kNoEvaluationTip = "" // 暂无评价
var kDelete = "" // 删除
var kRainbowChildrenClinic = "" // 睿宝儿科
var kRainbowCoin = "" // 彩虹币
var kMyRainbowCoin = "" // 我的彩虹币
var kTotalRainbowCoin = "" // 合计彩虹币：
var kConvenient = "" // 便捷
var kZeroDistanceDoctorsPatients = "" // 医患交流零距离
var kEfficient = "" // 高效
var kDoctorPersonalAssistant = "" // 医生的贴身助手
var kOpenRuiBao = "" // 开启睿宝
var kTurnOffNotificationTip = "" // 关掉通知将影响我们对您的事件提醒功能，请允许接收通知
var kNextClickOK = "" // 接下来，请点击“好”
var kCreateMedicalRecordsTip = "" // 创建自己的病历，方便病情管理诊所病历获取
var kBindMedicalRecord = "" // 请绑定病历号
var kNotBoundMedicalRecords = "" // 未绑定病历
var kSave = "" // 保存








import UIKit



// 已经连续签到 n 天
func hasBeenInARowForNDays(days: Int) -> String {
    
    let isEnglish = defaults.object(forKey: kIsEnglishKey) as? Bool ?? false
    if isEnglish == true {
        return "Has been in a row for \(days) days"
    }
    return "已连续签到 \(days) 天"
}






class ChangeLanguage: NSObject {
    

    
    
    
    /**
     * 单例
     */
    class func shareChangeLanguage() -> ChangeLanguage{
        return tools
    }
    private static let tools: ChangeLanguage = {
        let manager = ChangeLanguage()
        return manager
    }()
    

    
    // MARK:- 是否为英文环境
    func isEnglishEnvironmental() -> Bool {
        return defaults.object(forKey: kIsEnglishKey) as? Bool ?? false
    }
    
    
    
    // MARK:- 切换中英文环境
    private var isEnglish = defaults.object(forKey: kIsEnglishKey) as? Bool ?? false

    func toChangeLanguage() {
       
        isEnglish = defaults.object(forKey: kIsEnglishKey) as? Bool ?? false

        /**
         * 提示
         */
        setupTip()
        
        
        /**
         * 登录、注册等
         */
        setupLoginResister()

        
        /**
         * main
         */
        setupMain()
        
        
        /**
         * 首页
         */
        setupHomePage()
        

        /**
         * 消息
         */
        setupMessage()

        
        /**
         * 病历
         */
        setupMedicalRecord()
        

        /**
         * 商城
         */
        setupShopping()
        
        
        /**
         * 我
         */
        setupProfile()

        
        /**
         * 其它
         */
        setupOther()
    }
    
    
    
    
    
    
    // MARK:- 提示
    private func setupTip() {
        
        kNetworkTip = isEnglish ? "Unable to connect" : "网络异常，请检查网络设置"
        kPleaseEnterContent = isEnglish ? "Enter Content Here" : "请输入内容"
        kLoading = isEnglish ? "Loading" : "加载中"
        kLoadFaileTip = isEnglish ? "Load failed" : "加载失败"
        kLoadSuccessTip = isEnglish ? "Loaded successfully" : "加载成功"
        kShareSuccessTip = isEnglish ? "Sharing successful" : "分享成功"
        kShareFaileTip = isEnglish ? "Sharing failed" : "分享失败"
        kCancleShareTip = isEnglish ? "Stop sharing" : "取消分享"
        kLoginSuccess = isEnglish ? "Login successful" : "登录成功"
        kLoginFail = isEnglish ? "Login failed" : "登录失败"
        kCancleLogin = isEnglish ? "Cancle login in" : "取消登录"
        kLoggedOnOtherDevicesTip = isEnglish ? "This account is logged on to other devices" : "此账号在其它设备上登录了"
        kAnAccountCanOnlyLoggedOnOneDeviceTip = isEnglish ? "In order to ensure that you can successfully communicate with your patients, Only one account can be logged in on one device at the same time." : "为了保障您能顺利接受患者会话，一个账号只能同时在一个设备上登录。"
        kISeeTip = isEnglish ? "Already know" : "知道了"
        kPlaceText = isEnglish ? "Nothing" : "暂无"
        kSavePictureFiled = isEnglish ? "Error when saving picture" : "保存图片出错"
        kSavePictureSuccess = isEnglish ? "The picture saved successfully" : "保存图片成功"
        kCopyLink = isEnglish ? "Copy link" : "拷贝链接"
        kCircleOfFriends = isEnglish ? "Moments" : "朋友圈"
        kWeChat = isEnglish ? "WeChat" : "微信"
        kMicroBlog = isEnglish ? "WeiBo" : "微博"
        kQQZone = isEnglish ? "Qzone" : "QQ空间"
        kCancleSend = isEnglish ? "Finger slips up to cancel" : "手指向上滑，取消发送"
        kLoosenFingerCancleSend = isEnglish ? "Release finger to cancel" : "松开手指，取消发送"
        kSendVoice = isEnglish ? "Sending voice" : "发送语音..."
        kTalkTimeTooShort = isEnglish ? "Talk time is too short" : "说话时间太短"
        kSendPictureSlower = isEnglish ? "Please wait patiently" : "发送图片较慢，耐心等待"
        kBeingConnected = isEnglish ? "Connecting" : "正在连接"
        kNetworkIsNotStable = isEnglish ? "Network unstable" : "当前网络不稳定"
        kThereIsNoCallData = isEnglish ? "No call logs" : "当前没有通话数据"
        kNoResponse = isEnglish ? "No response so far" : "暂时没有响应"
        kTheOtherPartyRefused = isEnglish ? "The other party rejected" : "对方已拒绝"
        kTheOtherIsCalling = isEnglish ? "The other is busy" : "对方正在通话"
        kCallFailed = isEnglish ? "Call failed" : "呼叫失败"
        kNotConnected = isEnglish ? "Not connected" : "未连接"
        kCurrentNetworkConnectionFailed = isEnglish ? "Network connecting failed" : "当前网络连接失败"
        kSendFailed = isEnglish ? "Sending failed" : "发送失败"
        kSubmission = isEnglish ? "Submit" : "提交"
        kPullDownRefresh = isEnglish ? "Pull down refresh" : "下拉刷新"
        kLetRefresh = isEnglish ? "Let refresh" : "松开刷新"
        kRefreshing = isEnglish ? "Refreshing" : "正在刷新"
        kRefreshSuccess = isEnglish ? "Success" : "刷新成功"
        kRefreshFailed = isEnglish ? "Failed" : "刷新失败"
        kNewPasswordNotUnified = isEnglish ? "New password not unified" : "新密码不一致"
        kLinkHasBeenCopied = isEnglish ? "Link has been copied" : "已经复制链接"
        kDeleteSuccess = isEnglish ? "Delete success" : "已删除"
        kSendNetworkRequest = isEnglish ? "Send a network request" : "发送网络请求"
        kPleaseEnterValidPassword = isEnglish ? "Please enter a valid password" : "请输入有效密码"

        
    }
    
    
    
    
    
    
    
    // MARK:- 登录、注册等
    private func setupLoginResister() {
        
        kLoginLogin = isEnglish ? "Log in" : "立即登录"
        kLogin = isEnglish ? "Login" : "登录"
        kCellPhoneNumberMedicalRecordNumber = isEnglish ? "Phone number / Medical record number" : "手机号 / 病历号"
        kLoginPasswordPlacehoder = isEnglish ? "Password" : "密码"
        kForgetPassword = isEnglish ? "Forget password?" : "忘记密码？"
        kWeChatLogin = isEnglish ? "WeChat login" : "微信登录"
        kMicroBlogLogin = isEnglish ? "Micro-blog login" : "微博登录"
        kQQLogin = isEnglish ? "QQ Login" : "QQ登录"
        kRegister = isEnglish ? "Register" : "注册"
        kOtherWaysToLogin = isEnglish ? "Other ways to log in" : "其他方式登录"
        kPhoneNumberRegister = isEnglish ? "Phone number register" : "手机号注册"
        kResetPassword = isEnglish ? "Reset password" : "重置密码"
        kPhoneNumberBinding = isEnglish ? "Phone number binding" : "手机号绑定"
        kPleaseEnterVerificationCode = isEnglish ? "Please enter the verification code" : "请输入验证码"
        kVerify = isEnglish ? "Verify" : "验证"
        kPleaseEnterCellPhoneNumber = isEnglish ? "Please enter your phone number" : "请输入您的手机号"
        kReSend = isEnglish ? "Re send" : "重新发送"
        kSetPasswordDigitLetter = isEnglish ? "Set password, 6-16 digit or letter" : "设置密码，6-16位数字或字母"
        kReadAgree = isEnglish ? "Read and agree" : "已阅读并同意"
        kRuiBaoPrivacyAgreement = isEnglish ? "<Rui Bao privacy agreement>" : "《睿宝隐私协议》"
        kMedicalRecordBinding = isEnglish ? "Medical record binding" : "病历绑定"
        kNewPatient = isEnglish ? "New patient" : "新增就诊人"
        kRelatedFamilyMembers = isEnglish ? "Related family members" : "关联家庭成员病历"
        kAccountNumber = isEnglish ? "Account" : "账号"
        kAfterInitialTreatmentTip = isEnglish ? " After the initial treatment, the clinic for patients to generate account password and send to the phone." : "初次就诊后，诊所为患者生成账号密码并发送到手机"
        kEnterAccount = isEnglish ? "Please enter your account" : "请输入账号"
        kEnterPassword = isEnglish ? "Please enter your password" : "请输入密码"
        kID = isEnglish ? "ID" : "身份证"
        kPassport = isEnglish ? "Passport" : "护照"
        kPleaseSelect = isEnglish ? "Please select" : "请选择"
        kNameOfPatient = isEnglish ? "Name of patient" : "就诊人姓名"
        kPinyin = isEnglish ? "Pinyin" : "拼音"
        kYES = isEnglish ? "YES" : "有"
        kNO = isEnglish ? "NO" : "无"
        kSex = isEnglish ? "Sex" : "性别"
        kDateOfBirth = isEnglish ? "Date of birth" : "出生日期"
        kTypeOfIDCard = isEnglish ? "Type of ID card" : "身份证类型"
        kPleaseEnterIDNumber = isEnglish ? "Please enter the ID number" : "请输入证件号"
        kAddress = isEnglish ? "Address" : "住址"
        kProvinceCityDistrict = isEnglish ? "Province / city / district" : "请选择 省/市/区"
        kDetailedAddress = isEnglish ? "Detailed address" : "请填写详细地址"
        WhetherThereInsuranceCard = isEnglish ? "Whether there insurance card" : "是否保卡"
        kInsuranceType = isEnglish ? "Insurance type" : "保险类型"
        kInsuranceCardNumber = isEnglish ? "Insurance card number" : "保险卡号"
        kFather = isEnglish ? "father" : "父亲"
        kMother = isEnglish ? "Account" : "母亲"
        kName = isEnglish ? "name" : "姓名"
        kgoToTheClinicToChangeTip = isEnglish ? "After confirmation of the patient information can only go to the clinic to change." : "确认后就诊人信息只能去诊所进行更改"
        kSelectTypeInsurance = isEnglish ? "Select the type of insurance" : "选择保险类型"
        kBindingMedicalRecords = isEnglish ? ["Medical records have been built to bind", "First visit, improve information", "Just look"] : ["已建病历，进行绑定", "初诊，完善信息", "只是看看"]
        kNextStep = isEnglish ? "Next step" : "下一步"

    }
    
    

    
    
    
    
    
    
    
    // MARK:- main
    private func setupMain() {
        
        kHomeTabBar = isEnglish ? "Home" : "首页"
        kMessageTabBar = isEnglish ? "Message" : "消息"
        kMedicalRecordTabBar = isEnglish ? "Medical Record" : "病历"
        kShoppingTabBar = isEnglish ? "Shopping" : "商城"
        kMainProfileTabBar = isEnglish ? "Me" : "我"
        kMainTabBarTitles = [kHomeTabBar, kMessageTabBar, kMedicalRecordTabBar, kShoppingTabBar, kMainProfileTabBar]
    }
    

    
    
    
    
    
    
    
    
    // MARK:- 首页
    private func setupHomePage() {
        
        kDoctorsPlaechoder = isEnglish ? "Enter doctor name" : "输入医生姓名"
        kHistoryRecord = isEnglish ? "History records" : "历史记录"
        kClearHistoryRecord = isEnglish ? "Empty history record" : "清空历史"
        kClearAllQueryHistoryTip = isEnglish ? "Clear all query history?" : "清除全部查询历史记录？"
        kMakeAnAppointment = isEnglish ? "Make an appointment" : "预约挂号"
        kOnlineConsultation = isEnglish ? "Online consultation" : "在线咨询"
        kMostPopular = isEnglish ? "Most popular" : "热门资讯"
        kArticleDetail = isEnglish ? "Article details" : "文章详情"
        kEventDetails = isEnglish ? "Event details" : "活动详情"
        kClinic = isEnglish ? "Clinic" : "诊所"
        kDepartment = isEnglish ? "Department" : "科室"
        kTotal = isEnglish ? "Total" : "全部"
        kThereIsNo = isEnglish ? "There is No" : "有号"
        kThis = isEnglish ? "This" : "约满"
        kInterrogation = isEnglish ? "Interrogation" : "问诊量"
        kScheduling = isEnglish ? "Interrogation" : "排班"
        kMorning = isEnglish ? "Interrogation" : "上午"
        kAfternoon = isEnglish ? "Interrogation" : "下午"
        kSearch = isEnglish ? "Search" : "搜索"
        kConsultation = isEnglish ? "Consultations" : "咨询"
        kTextConsulting = isEnglish ? "Text consulting" : "图文咨询"
        kTextPictureConsulting = isEnglish ? "Text picture consulting" : "通过文字图片咨询"
        kOnlineTelephone = isEnglish ? "Online telephone" : "在线电话"
        kTelephoneConsultationThroughTextPictures = isEnglish ? "Telephone consult through text pictures" : "通过文字图片电话咨询"
        kElement = isEnglish ? "yuan" : "元"
        kMinute = isEnglish ? "Minute" : "分钟"
        kQuitTheEditor = isEnglish ? "Quit the editor?" : "退出此次编辑？"
        kQuit = isEnglish ? "Quit" : "退出"
        kPutQuestionsTo = isEnglish ? "Put question to" : "提问"
        kPleaseEnterTheNameOfTheDisease = isEnglish ? "Please enter ehe name of the disease" : "请输入疾病名称"
        kPleaseSpecifyYourCondition = isEnglish ? "Please specify your condition" : "请详述您的病情"
        kPatient = isEnglish ? "Patient" : "患者"
        kDiseaseName = isEnglish ? "Disease name" : "疾病名称"
        kPleaseEnterDiseaseName = isEnglish ? "Please enter disease name" : "请输入疾病名称"
        kDetailsOfYourIllnessEtc = isEnglish ? "Details of your illness, symptoms, treatment, want to get help, etc." : "详述您的病情、症状、治疗经过、想要获得的帮助等"
        kSelectPhotos = isEnglish ? "Select photos" : "选择照片"
        kSelectFromTheAlbum = isEnglish ? "Select from the album" : "从相册选择"
        kToSet = isEnglish ? "To set" : "去设置"
        kCamera = isEnglish ? "Camera" : "相机"
        kAlbum = isEnglish ? "Album" : "相册"
        kDeleteThisPicture = isEnglish ? "Do you want to delete this picture?" : "要删除这张照片吗？"
        kSelectPatient = isEnglish ? "Select patient" : "选择患者"
        kOnLine = isEnglish ? "On-line" : "在线"
        kOffLine = isEnglish ? "Off-line" : "离线"
        kPleaseInputKeyWord = isEnglish ? "Please enter key words" : "输入关键字"

    }
    
    

    
    
    
    
    
    
    
    // MARK:- 消息
    private func setupMessage() {
        
        kChoicePicture = isEnglish ? "Picture" : "图片"
        kChoiceMakePhone = isEnglish ? "Take photos" : "拍照"
        kTelePhone = isEnglish ? "Phone" : "电话"
        kFollowedUpTip = isEnglish ? "Follow-up" : "随访"
        kNoAdmissionsTip = isEnglish ? "No admissions, the consultation ended" : "医生未接诊，该咨询结束"
        kAdmissionsTip = isEnglish ? "The doctor has to be patient admissions, payment" : "医生已接诊，待患者付款"
        kNoPaymentTip = isEnglish ? "No payment, the consultation concluded" : "患者未付款，该咨询结束"
        kHasPaymentTip = isEnglish ? "Patients have been paid, began consulting" : "患者已付款，开始咨询"
        kTimeToTheEndTip = isEnglish ? "Time to the end of the consultation" : "时间到了，该咨询结束"
        kDoctorOpenFollowUpTip = isEnglish ? "The doctor open follow-up" : "医生向患者开启随访"
        kTheEndOfTheFollowUpTip = isEnglish ? "The end of the follow-up" : "该随访结束"
        kHoldDownToTalk = isEnglish ? "Press and to talk" : "按住 说话"
        kLoosenTheEnd = isEnglish ? "Release for ending the talk" : "松开 结束"
        kMute = isEnglish ? "Mute" : "静音"
        kSpeaker = isEnglish ? "Loudspeaker" : "扬声器"
        kRefuse = isEnglish ? "Reject" : "拒绝"
        kAnswer = isEnglish ? "Answer" : "接听"
        kConsultationIsOver = isEnglish ? "Consultation completed" : "咨询结束"
        kClose = isEnglish ? "Close" : "关闭"
//        kThePatientHasBeenWaiting = isEnglish ? "The patient is waiting for" : "患者已等待"
        kThePatientHasBeenWaiting = isEnglish ? "Waiting for reception" : "待接诊"
//        kHasBeenWaitingForPatientsToPay = isEnglish ? "Waiting for patients to pay" : "已等待患者付款"
        kHasBeenWaitingForPatientsToPay = isEnglish ? "Waiting for the patient to pay" : "等待患者付款"
        kConsulting = isEnglish ? "Consulting" : "咨询中"
        kConfirmationOfReception = isEnglish ? "Confirm office visit" : "确认接诊"
        kInformationError = isEnglish ? "Wrong messages" : "信息出错"
        kHasTimedOut = isEnglish ? "Timed out" : "已超时"
        k15MinuteCountdown = isEnglish ? "15 minute countdown" : "15分钟倒计时"
        k20MinuteCountdown = isEnglish ? "20 minute countdown" : "20分钟倒计时"
        kTheInterrogationIsOver = isEnglish ? "The visit finished" : "本次问诊已结束"
        kTheFollowUpIsOver = isEnglish ? "The follow-up finished" : "本次随访已结束"
        kNewMessageTip = isEnglish ? "New message" : "留言"
        kSureToSendTo = isEnglish ? "Sure to send to " : "确定发送给："
        kSending = isEnglish ? "Sending" : "正在发送"
        kPatientName = isEnglish ? "Patient name" : "患者名称"
        kRuiBaoPhone = isEnglish ? "RuiBao phone" : "睿宝电话"
        kRecentChat = isEnglish ? "Recent chats" : "最近聊天"
        kConsultationVoice = isEnglish ? "Speech" : "语音"
        kAlbumLicenseNotOpen = isEnglish ? "Album  access permission  not open" : "相册授权未开启"
        kCameraLicenseNotTurnedOn = isEnglish ? "Camera authorization switched off" : "相机授权未开启"
        kPleaseOpenTheCameraAuthorizationInTheSystemSettings = isEnglish ? "Please switch on the camera authorization in the system settings" : "请在系统设置中开启相机授权"
        kPleaseOpenTheAlbumAuthorizationInTheSystemSettings = isEnglish ? "Please open the album authorization in the system settings" : "请在系统设置中开启相册授权"
        kDoctorHomePage = isEnglish ? "Doctor home page" : "医生主页"
        kFollow = isEnglish ? "follow" : "关注"
        kPracticePoint = isEnglish ? "Practice point:" : "执业点："
        kSpecialty = isEnglish ? "Specialty:" : "擅长："
        kBriefIntroduction = isEnglish ? "Brief introduction:" : "简介："
        kPatientEvaluation = isEnglish ? "Patient evaluation(" : "患者评价（"
        kPeople = isEnglish ? "people)" : "人）"
        kDoctorEvaluation = isEnglish ? "Doctor evaluation" : "医生评价"
        kDoctorEvaluationTip = isEnglish ? "Note: 4-5 star for praise, 3 stars for the middle, 1-2 stars as the difference." : "注：4-5颗星为好评，3颗星为中评，1-2颗星为差评"
        kBeingFollowedUp = isEnglish ? "In the course of follow-up" : "随访中"
        kFollowUpIsOver = isEnglish ? "Follow-up already finished " : "随访已结束"

    }
    
    
    
    
    
    
    
    
    // MARK:- 病历
    private func setupMedicalRecord() {
        
        SMTZ = isEnglish ? "Vital signs" : "生命体征"
        GMLB = isEnglish ? "Allergy list" : "过敏列表"
        JWS = isEnglish ? "Past history" : "既往史"
        JZS = isEnglish ? "Family history" : "家族史"
        JBLB = isEnglish ? "List of diseases" : "疾病列表"
        YYLB = isEnglish ? "Medication list" : "用药列表"
        YMLB = isEnglish ? "List of vaccines" : "疫苗列表"
        SYSJC = isEnglish ? "Laboratory examination" : "实验室检查"
        JZJL = isEnglish ? "Medical records" : "就诊记录"
        kMedicalRecordDetails = isEnglish ? "Detailed medical records" : "病历详情"
        kCatalog = isEnglish ? "Catalog" : "目录"
        kTheAllergy = isEnglish ? "The allergy" : "过敏源"
        kType = isEnglish ? "Type" : "类型"
        kDegree = isEnglish ? "Degree" : "程度"
        kReaction = isEnglish ? "Reaction" : "反应"
        kStart = isEnglish ? "Start" : "开始"
        kEnd = isEnglish ? "End" : "停止"
        kNoteTaker = isEnglish ? "Note-taker" : "记录人"
        kAllergyDetails = isEnglish ? "Allergy details" : "过敏详情"
        kDisease = isEnglish ? "Disease" : "疾病"
        kDescribe = isEnglish ? "Describe" : "描述"
        kDiseaseDetails = isEnglish ? "Disease details" : "疾病详情"
        kListOfDiseases = isEnglish ? "List of diseases" : "疾病列表"
        kRecordNumber = isEnglish ? "Record number" : "记录号"
        kVisitingTime = isEnglish ? "Visiting time" : "看诊时间"
        kOutpatientType = isEnglish ? "Outpatient type" : "门诊类型"
        kChiefComplaint = isEnglish ? "Chief complaint" : "主诉"
        kDiagnosis = isEnglish ? "Diagnosis" : "诊断"
        kJiuZhenJiLuDetails = isEnglish ? "Medical record details" : "就诊记录详情"
        kListOfMedicalRecords = isEnglish ? "List of medical records" : "就诊记录列表"
        kAllergy = isEnglish ? "Allergy" : "过敏："
        kFrequencyMinute = isEnglish ? "Frequency/minute" : "次/分"
        kRecordTime = isEnglish ? "Record time" : "记录时间"
        kTemperature = isEnglish ? "Temperature" : "体温"
        kPulseBreathing = isEnglish ? "Pulse/breathing" : "脉搏/呼吸"
        kWeightHeight = isEnglish ? "Weight/height" : "体重/身高"
        kBloodOxygenSaturation = isEnglish ? "Blood oxygen saturation" : "血氧饱和度"
        kSystolicPressureDiastolicPressure = isEnglish ? "Systolic/diastolic pressure" : "收缩压/舒张压"
        kVaccineName = isEnglish ? "Vaccine name" : "疫苗名"
        kMethod = isEnglish ? "Method" : "方法"
        kPosition = isEnglish ? "Position" : "位置"
        kDose = isEnglish ? "Dose" : "剂量"
        kFrequency = isEnglish ? "Frequency" : "次数"
        kTime = isEnglish ? "Time" : "时间"
        kDrugName = isEnglish ? "Drug name" : "药品名"
        kUsage = isEnglish ? "Usage" : "用法"

        kYongYaoDetails = isEnglish ? "Medication details" : "用药详情"
        kVaccineDetails = isEnglish ? "Vaccine details" : "疫苗详情"
        kListOfLaboratoryTests = isEnglish ? "List of laboratory tests" : "实验室检查列表"
        kLaboratoryExaminationDetails = isEnglish ? "Laboratory examination details" : "实验室检查详情"
        kResult = isEnglish ? "Result" : "结果"
        kMore = isEnglish ? "More" : "更多"


        
        

    }
    
    
    
    
    

    
    
    
    
    
    
    
    // MARK:- 商城
    private func setupShopping() {
        
    }
    

    
    
    
    
    
    
    
    
    
    // MARK:- 我
    private func setupProfile() {
        
        kProfileMySetup = isEnglish ? "Set up" : "设置"
        //        kOriginalPassword = isEnglish ? "Old password" : "原密码"
        kOriginalPassword = isEnglish ? "Old" : "原密码"
        //        kNewPassword = isEnglish ? "New Password" : "新密码"
        kNewPassword = isEnglish ? "New" : "新密码"
        kPleaseEnterOriginalPassword = isEnglish ? "Please enter the old password" : "请输入原密码"
        kPleaseEnterNewPassword = isEnglish ? "Please enter a new password" : "请输入新密码"
        kkPleaseEnterNewPasswordAgain = isEnglish ? "Please enter a new password again" : "请再次输入新密码"
        kPleaseEnterYourComments = isEnglish ? "Please enter your comments" : "请输入您的意见"
        //        kContactInformation = isEnglish ? "Contact information:" : "联系方式："
        kContactInformation = isEnglish ? "Contact info:" : "联系方式："
        //        kPleaseEnterMobilePhoneNumber = isEnglish ? "Please enter your phone numb(Optional)" : "请输入手机号（非必填）"
        kPleaseEnterMobilePhoneNumber = isEnglish ? "Phone number(Optional)" : "请输入手机号（非必填）"
        kProfileLanguage = isEnglish ? "Language" : "语言"
        // ???
        kCcountSecurity = isEnglish ? "Account and security" : "账号与安全"
        kModifyPassword = isEnglish ? " Change password " : "修改密码"
        kProfileFeedback = isEnglish ? "Feedback" : "意见反馈"
        //        kProfileSignOut = isEnglish ? "Log-off" : "退出登录"
        kProfileSignOut = isEnglish ? "Sign out" : "退出登录"
        kProfileShareApp = isEnglish ? "Sharing" : "分享"
        kWordTooMuch = isEnglish ? "Words too much" : "亲，文字太多了"
        kMembershipPrivileges = isEnglish ? "Membership privileges" : "会员特权"
        kMyConsultation = isEnglish ? "My advice" : "我的咨询"
        kMyAppointment = isEnglish ? "My reservation" : "我的预约"
        kMyCollection = isEnglish ? "My concern" : "我的关注"
        kMemberOfFamily = isEnglish ? "Member of family" : "家庭成员"
        kSetup = isEnglish ? "Set up" : "设置"
        kProfileTitles = [kMembershipPrivileges, kMyConsultation, kMyAppointment, kMyCollection, kMemberOfFamily, kSetup]
        kNotBound = isEnglish ? "Not bound" : "未绑定"
        kEssentialInformation = isEnglish ? "Essential information" : "基本信息"
        kProfileInfoIcon = isEnglish ? "Head portrait" : "头像"
        kCommonlyUsedMedicalTreatment = isEnglish ? "Commonly used medical treatment" : "常用就诊人"
        kAddNewlyDiagnosedPatient = isEnglish ? "Add a newly diagnosed patient" : "添加初诊患者"
        kAddTheReferralOfPatients = isEnglish ? "Add the referral of patients" : "添加复诊患者"
        kRelationship = isEnglish ? "Relationship:" : "关系："
        kPhoneNumber = isEnglish ? "Phone number:" : "手机号："
        kAddAContact = isEnglish ? "Add a contact" : "添加联系人"
        kProfileInfo = isEnglish ? "Personal information" : "个人信息"
        kPhoneNumber2 = isEnglish ? "Phone number" : "手机号"
        kHomePhone = isEnglish ? "Home phone" : "家庭电话"
        kMailbox = isEnglish ? "Mailbox" : "邮箱"
        kWechatNumber = isEnglish ? "Wechat number" : "微信号"
        kRequired = isEnglish ? "Required" : "必填"
        kNonMandatory = isEnglish ? "Non mandatory" : "非必填"
        kMemberRecharge = isEnglish ? "Member recharge" : "会员充值"
        kMemberRechargeTip = isEnglish ? "Tip: a top 20 thousand yuan, can be upgraded to gold members" : "提示：一次充值2万元，可升级黄金会员"
        kRoseGoldMember = isEnglish ? "Rose Gold Member" : "玫瑰金会员"
        kGoldMember = isEnglish ? "Gold member" : "黄金会员"
        kPlatinumMember = isEnglish ? "Platinum member" : "铂金会员"
        kRecharge = isEnglish ? "Recharge" : "充值"
        kAmountOfMoney = isEnglish ? "Amount of money" : "金额"
        kEnterAmountRecharge = isEnglish ? "Please enter the amount of recharge" : "请输入充值金额"
        kPaymentMethod = isEnglish ? "Payment method" : "支付方式"
        kWeChatPayment = isEnglish ? "WeChat payment" : "微信支付"
        kAlipayToPay = isEnglish ? "Alipay to pay" : "支付宝支付"
        kRechargeConfirmation = isEnglish ? "Recharge confirmation" : "确认充值"
        kBookingInformation = isEnglish ? "Booking information" : "预约信息"
        kBookingDetails = isEnglish ? "Booking details" : "预约详情"
        kConsultationDetails = isEnglish ? "Consultation details" : "咨询详情"
        kMedicalHospital = isEnglish ? "Hospital for medical treatment" : "就诊医院"
        kMedicalDepartment = isEnglish ? "Medical department" : "就诊科室"
        kClinicHours = isEnglish ? "Clinic hours" : "门诊时间"
        kRegistrationFee = isEnglish ? "Registration fee" : "挂号费用"
        kRealNameSystemAppointmentTip = isEnglish ? " Real name system appointment, medical information will not be able to take the number. Stopped short message notification, please keep the phone open. " : "实名制预约，就诊人信息不符将无法取号。停诊将短信通知，请保持手机通畅。"
        kPatientVisits = isEnglish ? "Patient visits" : "就诊人"
        kDiseaseInformation = isEnglish ? "Disease information" : "疾病信息"
        kReservationType = isEnglish ? "Reservation type" : "预约类型"
        kPendingPayment = isEnglish ? "Pending payment" : "待付款"
        kCanceled = isEnglish ? "Canceled" : "已取消"
        kToBeEvaluated = isEnglish ? "To be evaluated" : "待评价"
        kConsultingAgain = isEnglish ? "Consulting again" : "再次咨询"
        kConcernedDoctor = isEnglish ? "Concerned doctor" : "关注的医生"
        kConcernedArticle = isEnglish ? "Concerned article" : "关注的文章"
        kBindAccount = isEnglish ? "Bind account" : "账号绑定"
        kCurrentAccount = isEnglish ? "Current account" : "当前账号"
        kMicroBlogSina = isEnglish ? "kMicro-blog Sina" : "新浪微博"
        kTencentQQ = isEnglish ? "kTencent QQ" : "腾讯QQ"
        kPhone = isEnglish ? "kPhone" : "手机"
        kCurrentBindingPhoneNumber = isEnglish ? "Current binding phone number" : "当前绑定手机号"
        kCurrentBindMedicalRecordNumber = isEnglish ? "Current bind medical record number" : "当前绑定病历号"

    }
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    // MARK:- 其它
    private func setupOther() {
        
        kMale = isEnglish ? "male" : "男"
        kFemale = isEnglish ? "female" : "女"
        kOver = isEnglish ? "OK" : "完成"
        kEnsure = isEnglish ? "OK" : "确定"
        kAge = isEnglish ? "Age" : "岁"
        kShareTo = isEnglish ? "Share to" : "分享至"
        kCancle = isEnglish ? "Cancel" : "取消"
        kMinutesAgo = isEnglish ? "Minutes ago" : "分钟前"
        kHoursAgo = isEnglish ? "Hours ago" : "小时前"
        kYesterday = isEnglish ? "Yesterday" : "昨天"
        kJust = isEnglish ? "Just now" : "刚刚"
        kPleaseInput = isEnglish ? "Please enter" : "请输入"
        kSavePicture = isEnglish ? "Save picture" : "保存图片"
        kNothing = isEnglish ? "NO" : "无"
        kWhenTheEventOccurs = isEnglish ? "When the event occurs" : "事件发生时"
        k5MinutesAgo = isEnglish ? "Before 5 minutes" : "5 分钟前"
        k15MinutesAgo = isEnglish ? "Before 15 minutes" : "15 分钟前"
        k30MinutesAgo = isEnglish ? "Before 30 minutes" : "30 分钟前"
        k1HoursAgo = isEnglish ? "Before an hour" : "1 小时前"
        k2HoursAgo = isEnglish ? "Before 2 hours" : "2 小时前"
        k1DaysAgo = isEnglish ? "Before one day" : "1 天前"
        k2DaysAgo = isEnglish ? "Before two days" : "2 天前"
        k1WeeksAgo = isEnglish ? "Before one week" : "1 周前"
        kNoConsultationRecordsTip = isEnglish ? "No consultation records" : "暂无咨询记录"
        kNoArrangementsTip = isEnglish ? "you have not done your scheduling" : "今天还没安排喔"
        kNoPatientsTip = isEnglish ? "No patient" : "暂无患者"
        kNoEvaluationTip = isEnglish ? "No Comments" : "暂无评价"
        kDelete = isEnglish ? "Delete" : "删除"
        kRainbowChildrenClinic = isEnglish ? "Rainbow Children's Clinic" : "睿宝儿科"
        kRainbowCoin = isEnglish ? "Rainbow coin" : "彩虹币"
        kMyRainbowCoin = isEnglish ? "My rainbow coin" : "我的彩虹币"
        kTotalRainbowCoin = isEnglish ? "Total rainbow coin:" : "合计彩虹币："
        kConvenient = isEnglish ? "Convenient" : "便捷"
        kZeroDistanceDoctorsPatients = isEnglish ? "Zero distance between doctors and patients" : "医患交流零距离"
        kEfficient = isEnglish ? "Zero distance between doctors and patients" : "高效"
        kDoctorPersonalAssistant = isEnglish ? "Doctor's personal assistant" : "医生的贴身助手"
        kOpenRuiBao = isEnglish ? "Open Rui Bao" : "开启睿宝"
        kTurnOffNotificationTip = isEnglish ? "Turn off the notification will affect our event reminder function to you, please allow the receiving notification." : "关掉通知将影响我们对您的事件提醒功能，请允许接收通知"
        kNextClickOK = isEnglish ? "Next, click 'OK'" : "接下来，请点击“好”"
        kCreateMedicalRecordsTip = isEnglish ? "Create their own medical records, medical records to facilitate the management of medical records" : "创建自己的病历，方便病情管理诊所病历获取"
        kBindMedicalRecord = isEnglish ? "Bind your medical record number, please" : "请绑定病历号"
        kNotBoundMedicalRecords = isEnglish ? "Not bound medical records" : "未绑定病历"
        kSave = isEnglish ? "Save" : "保存"

        
        
    }
}










