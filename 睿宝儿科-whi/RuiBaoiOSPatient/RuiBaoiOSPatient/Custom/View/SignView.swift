//
//  SignView.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/5.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  签到

import UIKit

@objc
protocol SignViewDelegate: NSObjectProtocol {
    @objc optional func gotoSignWithSignButton(_ signView: SignView, signButton: UIButton)
}

class SignView: UIView {
    
    weak var delegate: SignViewDelegate?
    fileprivate var lines = [UIView]()
    fileprivate var circles = [UILabel]()
    fileprivate var coins = ["1", "2", "3", "4", "5", "5", "5"]
    // 此次签到赠送的彩虹币个数
    var rainbowCoinValue = 0

    // 连续签到的天数
    var dayNumber: Int = 0 {
        didSet{
            
            if dayNumber >= 0 {
                
                if dayNumber < 8 {
                    coins = ["1", "2", "3", "4", "5", "5", "5"]
                } else if dayNumber > 10 {
                    coins = ["5", "5", "5", "5", "5", "5", "5"]
                } else {
                    switch dayNumber {
                    case 8:
                        coins = ["2", "3", "4", "5", "5", "5", "5"]
                    case 9:
                        coins = ["3", "4", "5", "5", "5", "5", "5"]
                    case 10:
                        coins = ["4", "5", "5", "5", "5", "5", "5"]
                    default:
                        coins = ["5", "5", "5", "5", "5", "5", "5"]
                    }
                }
                
                if dayNumber <= 0 { // 清空签到天数
                    for i in 0..<lines.count {
                        let line = lines[i]
                        let circle = circles[i]
                        
                        line.backgroundColor = rgbSameColor(226)
                        line.frame.size.height = 1
                        
                        circle.layer.borderWidth = 1
                        circle.layer.borderColor = rgbSameColor(226).cgColor
                        circle.backgroundColor = UIColor.white
                        circle.textColor = rgbSameColor(153)
                        circle.text = "+\(coins[i])"
                    }
                    
                } else {
                    for i in 0..<lines.count {
                        let line = lines[i]
                        let circle = circles[i]
                        if i < dayNumber { // 已签到
                            line.backgroundColor = rgbColor(255, g: 211, b: 80)
                            line.frame.size.height = 2
                            
                            circle.layer.borderWidth = 2
                            circle.layer.borderColor = rgbColor(255, g: 211, b: 80).cgColor
                            circle.backgroundColor = rgbColor(255, g: 250, b: 193)
                            circle.textColor = rgbColor(255, g: 200, b: 49)
                            
                            circle.text = "+\(coins[i])"
                            
                        } else { // 未签到
                            line.backgroundColor = rgbSameColor(226)
                            line.frame.size.height = 1
                            
                            circle.layer.borderWidth = 1
                            circle.layer.borderColor = rgbSameColor(226).cgColor
                            circle.backgroundColor = UIColor.white
                            circle.textColor = rgbSameColor(153)
                            
                            circle.text = "+\(coins[i])"
                        }
                    }
                }
                
                // 已连续签到的天数
                signDays.text = hasBeenInARowForNDays(days: dayNumber)
                
                // 此次签到赠送的彩虹币个数
                rainbowCoinValue = min(dayNumber, 5)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 子控件
        let signTipIcon = UIImageView(frame: CGRect(x: 10, y: 6, width: 82, height: 43))
        var signTipIconStr = "MeiTianQianDaoTipIcon"
        if ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental() {
            signTipIconStr = signTipIconStr + "En"
        }
        signTipIcon.image = UIImage(named: signTipIconStr)
        addSubview(signTipIcon)
        
        // 签到按钮
        addSubview(sign)
        let signW: CGFloat = 49
        let signH: CGFloat = 22
        let signX: CGFloat = kScreenWidth - 10 - signW
        let signY: CGFloat = 17
        sign.frame = CGRect(x: signX, y: signY, width: signW, height: signH)
        
        
        // 彩虹币
        let coinW: CGFloat = 93
        let coinH: CGFloat = 21
        let coinX: CGFloat = sign.frame.minX - coinW
        let coinY: CGFloat = 18
        let rainbowCoinView = UIView(frame: CGRect(x: coinX, y: coinY, width: coinW, height: coinH))
        addSubview(rainbowCoinView)

        let coin = UIImageView(frame: CGRect(x: 0, y: 5, width: 14, height: 13))
        coin.image = UIImage(named: "CaiHongBiIcon")
        rainbowCoinView.addSubview(coin)
        
        let coinLabel = UILabel(frame: CGRect(x: coin.frame.maxX + 2, y: 4, width: 34, height: 14))
        coinLabel.text = kRainbowCoin
        coinLabel.textColor = rgbColor(253, g: 119, b: 142)
        coinLabel.font = font10
        rainbowCoinView.addSubview(coinLabel)
        
        // 彩虹币数值
        rainbowCoinView.addSubview(coinNumber)
        coinNumber.frame = CGRect(x: coinLabel.frame.maxX, y: 0, width: 42, height: 21)

        let dayViewX: CGFloat = 20
        let dayViewW: CGFloat = kScreenWidth - 2*dayViewX
        let dayView = UIView(frame: CGRect(x: dayViewX, y: signTipIcon.frame.maxY + 12, width: dayViewW, height: 35))
        addSubview(dayView)
        
        let dayNumber = 7
        let lineW: CGFloat = dayViewW/CGFloat(dayNumber - 1)
        let circleWH: CGFloat = 20
        let circleLineW = (dayViewW - circleWH)/CGFloat(dayNumber - 1)
        for i in 0..<dayNumber {
            
            let line = UIView()
            line.frame = CGRect(x: CGFloat(i)*lineW, y: 9, width: lineW, height: 1)
            line.backgroundColor = rgbSameColor(226)
            lines.append(line)
            dayView.addSubview(line)
            if i == dayNumber - 1 {
                line.isHidden = true
            }
            
            let circle = UILabel(frame: CGRect(x: CGFloat(i)*circleLineW, y: 0, width: circleWH, height: circleWH))
            circle.backgroundColor = UIColor.white
            circle.text = "+\(i + 1)"
            if i < 5 {
                circle.text = "+\(i + 1)"
            } else {
                circle.text = "+5"
            }
            circle.textColor = rgbSameColor(153)
            circle.font = font10
            circle.textAlignment = .center
            circle.layer.borderColor = rgbSameColor(226).cgColor
            circle.layer.borderWidth = 1
            circle.layer.cornerRadius = circleWH/2
            circle.clipsToBounds = true
            circles.append(circle)
            dayView.addSubview(circle)
        }
        
        dayView.addSubview(signDays)
        signDays.frame = CGRect(x: 0, y: 24, width: dayViewW, height: 11)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 签到按钮
    lazy var sign: UIButton = {
        let sign = UIButton()
        
        var signNormal = "QianDaoButtonNormal"
        var signDisable = "QianDaoButtonDisable"
        if ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental() {
            signNormal = signNormal + "En"
            signDisable = signDisable + "En"
        }
        sign.setImage(UIImage(named: signNormal), for: .normal)
        sign.setImage(UIImage(named: signDisable), for: .disabled)
        sign.addTarget(self, action: #selector(SignView.signButtonClicked(_:)), for: .touchUpInside)
        return sign
    }()

    @objc fileprivate func signButtonClicked(_ signButton: UIButton) {
        delegate?.gotoSignWithSignButton?(self, signButton: signButton)
    }

    // 彩虹币数值
    lazy var coinNumber: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.textColor = rgbColor(253, g: 119, b: 142)
        lbl.font = font15
        return lbl
    }()

    // 已连续签到的天数
    fileprivate lazy var signDays: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgbColor(255, g: 200, b: 49)
        lbl.font = font8
        lbl.textAlignment = .center
        return lbl
    }()
}
