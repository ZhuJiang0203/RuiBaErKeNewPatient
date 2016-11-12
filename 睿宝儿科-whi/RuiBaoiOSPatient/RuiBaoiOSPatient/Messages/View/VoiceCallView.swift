//
//  VoiceCallView.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/6/21.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

@objc
protocol VoiceCallViewDelegate: NSObjectProtocol {
    @objc optional func muteButtonClicked(_ btn: MuteSpeakerBtn)
    @objc optional func speakerButtonClicked(_ btn: MuteSpeakerBtn)
    @objc optional func rejectACall(_ btn: RejectAnswerBtn)
    @objc optional func hangUpACall(_ btn: RejectAnswerBtn)
    @objc optional func answerButtonClicked(_ btn: RejectAnswerBtn)
//    optional func callTimeHasArrived()
}


class VoiceCallView: UIView {

    weak var delegate: VoiceCallViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backImage)
        addSubview(networkLabel)
        addSubview(icon)
        addSubview(patientName)
        addSubview(ruibaophone)
        addSubview(phonePictureTimeView)
        phonePictureTimeView.addSubview(phonePicture)
        phonePictureTimeView.addSubview(time)
        addSubview(muteBtn)
        addSubview(speakerBtn)
        addSubview(rejectBtn)
        addSubview(answerBtn)
        
        backImage.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        networkLabel.frame = CGRect(x: 0, y: 28, width: kScreenWidth, height: 18)
        let iconWH: CGFloat = 140
        let iconX = (kScreenWidth - iconWH)/2
        let iconY: CGFloat = 78
        icon.frame = CGRect(x: iconX, y: iconY, width: iconWH, height: iconWH)
        let nameY = icon.frame.maxY + 33
        patientName.frame = CGRect(x: 0, y: nameY, width: kScreenWidth, height: 22)
        let ruibaoY = patientName.frame.maxY + 5
        let ruibaoH: CGFloat = 19
        ruibaophone.frame = CGRect(x: 0, y: ruibaoY, width: kScreenWidth, height: ruibaoH)
        
        let phoneW: CGFloat = 22
        let timeW: CGFloat = 44
        let phoneTimeMargin: CGFloat = 6
        let phonePictureTimeViewW = phoneW + timeW + phoneTimeMargin
        let phonePictureTimeViewX = (kScreenWidth - phonePictureTimeViewW)/2
        phonePictureTimeView.frame = CGRect(x: phonePictureTimeViewX, y: ruibaoY, width: phonePictureTimeViewW, height: ruibaoH)
        phonePicture.frame = CGRect(x: 0, y: 5, width: 22, height: 12)
        time.frame = CGRect(x: 28, y: 0, width: timeW, height: ruibaoH)
        
        let muteBtnY = kScreenHeight - 197
        muteBtn.frame = CGRect(x: 0, y: muteBtnY, width: kScreenWidth/2, height: 52)
        speakerBtn.frame = CGRect(x: kScreenWidth/2, y: muteBtnY, width: kScreenWidth/2, height: 52)
        let rejectBtnW: CGFloat = 50
        let rejectBtnH: CGFloat = 67
        let rejectBtnY = muteBtn.frame.maxY + 21
        let rejectBtnX = (kScreenWidth - 2*rejectBtnW)/4
        rejectBtn.frame = CGRect(x: rejectBtnX, y: rejectBtnY, width: rejectBtnW, height: rejectBtnH)
        answerBtn.frame = CGRect(x: rejectBtn.frame.maxX + 2*rejectBtnX, y: rejectBtnY, width: rejectBtnW, height: rejectBtnH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var backImage: UIImageView = {
        let backImage = UIImageView()
        backImage.image = UIImage(named: "CHChatAudioIcon_backgroundIcon")
        return backImage
    }()
    
    lazy var networkLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb50
        lbl.font = font15
        lbl.textAlignment = .center
        return lbl
    }()

    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 70
        icon.clipsToBounds = true
        icon.image = UIImage(named: "Bitmap")
        return icon
    }()

    lazy var patientName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbColor(86, g: 107, b: 124)
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textAlignment = .center
        lbl.text = kPatientName
        return lbl
    }()
    
    lazy var ruibaophone: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbColor(86, g: 107, b: 124)
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.text = kRuiBaoPhone
        return lbl
    }()
    
    lazy var phonePictureTimeView: UIView = {
        let vw = UIView()
        vw.isHidden = true
        return vw
    }()
    
    lazy var phonePicture: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(named: "CHChatAudio_soundIcon_3")
        
        // 1.添加动画
//        let img1 = UIImage(named: "CHChatAudio_soundIcon_0")!
//        let img2 = UIImage(named: "CHChatAudio_soundIcon_1")!
//        let img3 = UIImage(named: "CHChatAudio_soundIcon_2")!
//        let img4 = UIImage(named: "CHChatAudio_soundIcon_3")!
//        let animationImages = [img1, img2, img3, img4]
//        picture.animationImages = animationImages
//        picture.animationDuration = 1;
        
        return picture
    }()

    lazy var time: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbColor(86, g: 107, b: 124)
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.text = "00:00"
        return lbl
    }()

    lazy var muteBtn: MuteSpeakerBtn = {
        let btn = MuteSpeakerBtn()
        btn.isHidden = true
        btn.isSpeaker = false
        btn.setTitle(kMute, for: .normal)
        btn.setImage(UIImage(named: "CHChatAudio_jingyinIcon"), for: .normal)
        btn.setImage(UIImage(named: "CHChatAudio_SjingyinIcon"), for: .selected)
        btn.addTarget(self, action: #selector(VoiceCallView.muteBtnClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    // 静音
    func muteBtnClicked(_ btn: MuteSpeakerBtn) {
        btn.isSelected = !btn.isSelected
        delegate?.muteButtonClicked!(btn)
    }
    
    lazy var speakerBtn: MuteSpeakerBtn = {
        let btn = MuteSpeakerBtn()
        btn.isHidden = true
        btn.isSpeaker = true
        btn.setTitle(kSpeaker, for: .normal)
        btn.setImage(UIImage(named: "CHChatAudio_yangshengqiIcon"), for: .normal)
        btn.setImage(UIImage(named: "CHChatAudio_SyangshengqiIcon"), for: .selected)
        btn.addTarget(self, action: #selector(VoiceCallView.speakerBtnClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    // 扬声器
    func speakerBtnClicked(_ btn: MuteSpeakerBtn) {
        btn.isSelected = !btn.isSelected
        delegate?.speakerButtonClicked?(btn)
    }

    lazy var rejectBtn: RejectAnswerBtn = {
        let btn = RejectAnswerBtn()
        btn.setTitle(kRefuse, for: .normal)
        btn.setImage(UIImage(named: "CHChatAudio_guaduanIcon"), for: .normal)
        btn.addTarget(self, action: #selector(VoiceCallView.rejectBtnClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    // 拒绝 或 挂断
    func rejectBtnClicked(_ btn: RejectAnswerBtn) {
        
//        if timeTimer != nil {
//            timeTimer!.invalidate()
//            timeTimer = nil
//        }
        
        if answerBtn.isHidden == false { // 拒绝
            delegate?.rejectACall?(btn)
        } else { // 挂断
            delegate?.hangUpACall?(btn)
        }
    }
    
    lazy var answerBtn: RejectAnswerBtn = {
        let btn = RejectAnswerBtn()
        btn.setTitle(kAnswer, for: .normal)
        btn.setImage(UIImage(named: "CHChatAudio_jietingIcon"), for: .normal)
        btn.addTarget(self, action: #selector(VoiceCallView.answerBtnClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    // 接听
    func answerBtnClicked(_ btn: RejectAnswerBtn) {
        
        // 隐藏接听按钮，拒绝按钮移至中间
        btn.isHidden = true
        rejectBtn.setTitle("", for: .normal)
        UIView.animate(withDuration: 0.25, animations: { 
            self.rejectBtn.center.x = kScreenWidth/2
        }) 
        
//        // 隐藏 睿宝电话，显示 通话时间
//        phonePictureTimeView.hidden = false
//        ruibaophone.hidden = true
//        // 开始计时
//        timeTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(VoiceCallView.startTiming), userInfo: nil, repeats: true)
//        // 开始执行动画
//        phonePicture.startAnimating()

        // 显示 静音、扬声器
        muteBtn.isHidden = false
        speakerBtn.isHidden = false
        
        delegate?.answerButtonClicked?(btn)
    }
    
}
