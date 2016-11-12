//
//  VoicePlayTool.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/26.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

var animatiogImageView: UIImageView? // 正在执行动画的ImageView
var proviousVoiceButton: VoiceButton? 

class VoicePlayTool: NSObject {

    
    class func playerWithMessage(_ message: EMMessage, superView: VoiceButton) {
        
        // 还原图片
        proviousVoiceButton?.setImage(UIImage(named: "PlayingYUYIN3"), for: .normal)

        proviousVoiceButton = superView

        if animatiogImageView?.superview == superView {
            // 停止播放
            EMCDDeviceManager.sharedInstance().stopPlaying()
            
            // 把以前的动画移除
            animatiogImageView?.removeFromSuperview()
        } else {
            // 把以前的动画移除
            animatiogImageView?.removeFromSuperview()
            
            let voiceBody = message.body as! EMVoiceMessageBody
            
            // 播放路径（如果本地音频文件存在，播放本地，不存在，播放远程）
            var playerPath = ""
            if FileManager.default.fileExists(atPath: voiceBody.localPath) {
                playerPath = voiceBody.localPath
            } else {
                playerPath = voiceBody.remotePath
            }
            
            // 播放音频
            EMCDDeviceManager.sharedInstance().asyncPlaying(withPath: playerPath) { (error) in
                if error == nil {
                    LLog("语音播放完成")
                }
                
                // 移除动画
                animatiogImageView?.removeFromSuperview()
                
                // 还原图片
                superView.setImage(UIImage(named: "PlayingYUYIN3"), for: .normal)
            }
            
            // 隐藏原有图片
            superView.setImage(UIImage(named: ""), for: .normal)
            
            // 添加动画
            // 1.创建一个动画的UIImageView
            animatiogImageView = UIImageView(frame: CGRect(x: 60, y: 11, width: 10, height: 14))
            let img1 = UIImage(named: "PlayingYUYIN")!
            let img2 = UIImage(named: "PlayingYUYIN2")!
            let img3 = UIImage(named: "PlayingYUYIN3")!
            let animationImages = [img1, img2, img3]
            animatiogImageView!.animationImages = animationImages
            animatiogImageView!.animationDuration = 1;
            
            // 2.把UIImageView　添加到superView
            superView.addSubview(animatiogImageView!)
            
            // 3.执行动画
            animatiogImageView!.startAnimating()
        }
    }
    
    class func stopPlay() {
        // 还原图片
        proviousVoiceButton?.setImage(UIImage(named: "PlayingYUYIN3"), for: .normal)

        // 把以前的动画移除
        animatiogImageView?.removeFromSuperview()
        // 停止播放
        EMCDDeviceManager.sharedInstance().stopPlaying()
    }
}
