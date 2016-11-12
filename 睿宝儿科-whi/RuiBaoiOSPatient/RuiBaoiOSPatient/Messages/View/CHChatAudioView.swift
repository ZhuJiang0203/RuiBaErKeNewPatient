//
//  CHChatAudioView.swift
//  RuiBaoiOSPatient
//
//  Created by LianKang-guoyicen on 16/5/26.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  语音通话界面

import UIKit
import AVFoundation


extension CHChatAudioView {
    class func loadFromNib(_ session:EMCallSession, caller isCaller:Bool,status statusString:String) -> CHChatAudioView? {
        
        let view = UINib(nibName: "CHChatAudioView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CHChatAudioView
        view?.callSession = session
        view?.isCaller = isCaller
        view?.statusString = statusString
        view?.loadView()
        
        view?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        
        return view
    }
}

protocol ChatAudioViewDelegate:NSObjectProtocol {
    func chatAudioViewDidClose(_ view:CHChatAudioView) // 挂断电话
    func chatAudioViewAnswer(_ view:CHChatAudioView) // 接听电话

}

class CHChatAudioView: UIView {
    
    weak var delegate:ChatAudioViewDelegate?
    
    fileprivate weak var callSession: EMCallSession?
    fileprivate var isCaller: Bool?
    fileprivate var statusString: String?
    fileprivate var timeTimer: Timer?

    @IBOutlet fileprivate weak var backgroundImageView: UIImageView!
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!{
        didSet{
            avatarImageView.layer.cornerRadius = 70
        }
    }
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var tishiLabel: UILabel!
    @IBOutlet fileprivate weak var timeLabel: UILabel!
    @IBOutlet fileprivate weak var yinliangImageView: UIImageView!
    @IBOutlet fileprivate weak var networkLabel: UILabel!
    
    @IBOutlet fileprivate weak var jujueButton: UIButton!
    @IBOutlet fileprivate weak var jujueLabel: UILabel!
    @IBOutlet fileprivate weak var guaduanButton: UIButton!
    @IBOutlet fileprivate weak var jietingButton: UIButton!
    @IBOutlet fileprivate weak var jietingLabel: UILabel!
    @IBOutlet fileprivate weak var jingyinButton: UIButton!
    @IBOutlet fileprivate weak var jingyinLabel: UILabel!
    @IBOutlet fileprivate weak var yangshengqiButton: UIButton!
    @IBOutlet fileprivate weak var yangshengqiLabel: UILabel!

    fileprivate var ringPlayer: AVAudioPlayer?
    fileprivate var audioCategory:String?
    fileprivate var voiceImageArray = [
        UIImage.init(named: "CHChatAudio_soundIcon_0"),
        UIImage.init(named: "CHChatAudio_soundIcon_1"),
        UIImage.init(named: "CHChatAudio_soundIcon_2"),
        UIImage.init(named: "CHChatAudio_soundIcon_3")
    ]
    fileprivate var voiceTimer:Timer?

    
    fileprivate var timeLength = 0
    func startTimer() {
        timeLength = 0
        timeTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CHChatAudioView.timeTimerAction), userInfo: nil, repeats: true)
    }
    
    func timeTimerAction(){
        timeLength += 1
        let hour = timeLength/3600
        let min = (timeLength - hour*3600)/60
        let sec = timeLength - hour*3600 - min*60;
        
        if hour > 0 {
            timeLabel.text = String.init(format: "%i:%i:%i", hour,min,sec)
        } else if min > 0 {
            timeLabel.text = String.init(format: "%i:%i", min,sec)
        } else {
            timeLabel.text = String.init(format: "00:%i",sec)
        }
    }
    
    fileprivate func loadView(){
        
        jujueButton.setImage(UIImage.init(named: "CHChatAudio_guaduanIcon"), for: .normal)
        guaduanButton.setImage(UIImage.init(named: "CHChatAudio_guaduanIcon"), for: .normal)
        
        jietingButton.setImage(UIImage.init(named: "CHChatAudio_jietingIcon"), for: .normal)
        
        jingyinButton.setImage(UIImage.init(named: "CHChatAudio_jingyinIcon"), for: .normal)
        jingyinButton.setImage(UIImage.init(named: "CHChatAudio_SjingyinIcon"), for: .selected)
        yangshengqiButton.setImage(UIImage.init(named: "CHChatAudio_yangshengqiIcon"), for: .normal)
        yangshengqiButton.setImage(UIImage.init(named: "CHChatAudio_SyangshengqiIcon"), for: .selected)
        
        yinliangImageView.isHidden = true
        timeLabel.isHidden = true
        tishiLabel.text = "患者电话"
        jingyinLabel.isHidden = true
        jingyinButton.isHidden = true
        yangshengqiLabel.isHidden = true
        yangshengqiButton.isHidden = true
        guaduanButton.isHidden = true
    }
    
    // 拒绝
    @IBAction fileprivate func jujueButtonClick(_ sender: AnyObject) {
        hangupAction()
        if delegate != nil {
            delegate?.chatAudioViewDidClose(self)
        }
    }
    // 挂断
    @IBAction fileprivate func guaduanButtonClick(_ sender: AnyObject) {
        hangupAction()
        if delegate != nil {
            delegate?.chatAudioViewDidClose(self)
        }
    }
    
    // 停止通话
    func hangupAction() {
        timeTimer?.invalidate()
        stopVoiceTimer()
        stopRing()
        
        let audioSession = AVAudioSession.sharedInstance()
      
        do {
            if audioCategory != nil {
                try audioSession.setCategory(audioCategory!)
            }
            try audioSession.setActive(true)
        } catch {
            
        }
    }
    
    
    // 打开扬声器
    func beginRing() {
        
        ringPlayer?.stop()
        let musicPath = Bundle.main.path(forResource: "callRing", ofType: "mp3")
        let url = URL.init(fileURLWithPath: musicPath!)
        do {
            try ringPlayer = AVAudioPlayer.init(contentsOf: url)
            ringPlayer?.volume = 1
            ringPlayer?.numberOfLoops = -1
            if ringPlayer?.prepareToPlay() == true{
                ringPlayer?.play()
            }
        } catch {
        
        }
    }
    // 关闭扬声器
    func stopRing(){
        ringPlayer?.stop()
    }
 
    // 接听来电
    @IBAction fileprivate func jietingButtonClick(_ sender: AnyObject) {
        let audioSession = AVAudioSession.sharedInstance()
        audioCategory = audioSession.category
        if audioCategory != AVAudioSessionCategoryPlayAndRecord{
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                try audioSession.setActive(true)
            } catch {
            
            }
        }
        if delegate != nil {
            delegate?.chatAudioViewAnswer(self)
        }
        answerViewSet()
    }
    
    func answerViewSet(){
        tishiLabel.text = "正在连接..."
        jujueLabel.isHidden = true
        jujueButton.isHidden = true
        jietingLabel.isHidden = true
        jietingButton.isHidden = true
        
        jingyinLabel.isHidden = false
        jingyinButton.isHidden = false
        yangshengqiLabel.isHidden = false
        yangshengqiButton.isHidden = false
        guaduanButton.isHidden = false
    }
    
    func chatAudioViewReceiveCallConnected(){
        startVoiceTimer()
        tishiLabel.text = ""
        tishiLabel.isHidden = true
        yinliangImageView.isHidden = false
        timeLabel.isHidden = false
    }
    
    func startVoiceTimer(){
        voiceTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(CHChatAudioView.sessionVoiceVolume), userInfo: nil, repeats: true)
    }
    
    func stopVoiceTimer(){
        if voiceTimer != nil{
            voiceTimer?.invalidate()
            voiceTimer = nil
        }
    }

    func sessionVoiceVolume(){
        
        let volume =  callSession?.getVoiceVolume() ?? 0
       
        if volume == 0 {
            yinliangImageView.image = voiceImageArray[0]
        } else if volume > 0 && volume < 3 {
            yinliangImageView.image = voiceImageArray[1]
        } else if volume >= 3 && volume < 6 {
            yinliangImageView.image = voiceImageArray[2]
        } else {
            yinliangImageView.image = voiceImageArray[3]
        }
    }
    
    // 静音设置
    @IBAction fileprivate func jingyinClickButton(_ sender: AnyObject) {
        jingyinButton.isSelected = !jingyinButton.isSelected
        _ = EMClient.shared().callManager.markCallSession!(callSession?.sessionId, isSilence: jingyinButton.isSelected)
    }
    
    // 扬声器设置
    @IBAction fileprivate func yangshengqiButtonClick(_ sender: AnyObject) {
        let audioSession = AVAudioSession.sharedInstance()
        if yangshengqiButton.isSelected == true {
            do {
        try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.none)
            } catch {
            
            }
        } else {
            do {
                try  audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            } catch {
                
            }
        }
        
        do {
            try audioSession.setActive(true)
        } catch {
            
        }
        
        yangshengqiButton.isSelected = !yangshengqiButton.isSelected
    }
    
    // 关闭通话
    func closeChatAudioView(){
        callSession = nil
        if timeTimer != nil {
            timeTimer?.invalidate()
            timeTimer = nil
        }
        stopVoiceTimer()
       
        weak var selfWeak = self
        DispatchQueue.main.async(execute: {
            do {
                try  AVAudioSession.sharedInstance().setActive(false)
            } catch {
            
            }
            
            if selfWeak?.delegate != nil {
                selfWeak?.delegate?.chatAudioViewDidClose(self)
            }
        })
    }
    
    
    
    // 网络状态
    func networkStatus(_ status:EMCallNetworkStatus){
        switch (status) {
        case EMCallNetworkStatusNormal:
            networkLabel.text = ""
            networkLabel.isHidden = true
            break
        case EMCallNetworkStatusUnstable:
            networkLabel.text = "当前网络不稳定"
            networkLabel.isHidden = false
            break
        case EMCallNetworkStatusNoData:
            networkLabel.text = "当前没有通话数据"
            networkLabel.isHidden = false
            break
        default:
            break
        }
    }
    

}
