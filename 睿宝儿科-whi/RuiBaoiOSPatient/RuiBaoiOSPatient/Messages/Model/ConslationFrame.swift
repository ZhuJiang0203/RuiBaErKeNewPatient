//
//  ConslationFrame.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/16.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class ConslationFrame: NSObject {

    var iconFrame: CGRect?
    var textFrame: CGRect?
    var pictureFrame: CGRect?
    var yuyinFrame: CGRect?
    var textBackFrame: CGRect?
    var cellH: CGFloat = 0
    
    var shareTtlFrame: CGRect?
    var shareContentFrame: CGRect?
    var shareIconFrame: CGRect?
    
    var model: ConslationModel? {
        didSet{
            
            if model != nil {
                
                if (model!.UserType == "2" && (model!.AssistantTip == "1" || model!.AssistantTip == "3" || model!.AssistantTip == "5" || model!.AssistantTip == "7")) { // 咨询结束、随访结束
                  
                    cellH = 90
                    
                } else { // 待接诊、已接诊，待付款、咨询中、随访中
                    let iconWH: CGFloat = 45
                    let iconMarX: CGFloat = 15
                    let minRowH: CGFloat = 36
                    
                    let textBackY: CGFloat = kMargin + 4.5
                    
                    // 文字 X
                    let textX: CGFloat = 15
                    // 文字 W
                    let text = model!.text ?? ""
                    let textMaxW = kScreenWidth/2
                    let textW: CGFloat = text.calculateTheSizeOfTheString(font15, maxWidth: textMaxW).width
                    // 文字 H
                    let textH: CGFloat = text.calculateTheHeightOfTheString(font15, width: textW, margin: kRowMargin, maxRow: 0)
                    // 文字 Y
                    let textOneRowH: CGFloat = "啊".calculateTheHeightOfTheString(font15, width: textW, margin: kRowMargin, maxRow: 0)
                    let textY: CGFloat = (minRowH - textOneRowH)/2
                    
                    
                    if model!.UserType == "1" || model!.UserType == "2" { // 我 或 医生助手
                        
                        // 头像位置
                        let iconX: CGFloat = kScreenWidth - iconMarX - iconWH
                        iconFrame = CGRect(x: iconX, y: kMargin, width: iconWH, height: iconWH)
                        
                        LLog(model!.text)
                        LLog(model!.pictureString)
                        LLog(model!.voicePath)
                        if model!.text != nil { // 文字（包括：分享）
                            
                            let txt = model!.text ?? ""
                            if txt.hasPrefix("#^!#") {
                                let arrstr = (txt as NSString).substring(from: 4)
                                let arr = arrstr.components(separatedBy: "#^!#")
                                if arr.count == 4 { // 分享成功
                                    let textX: CGFloat = 15
                                    let textY: CGFloat = kMargin
                                    let text = arr[0] 
                                    let textMaxW = kScreenWidth/2
                                    let textW: CGFloat = text.calculateTheSizeOfTheString(font15, maxWidth: textMaxW).width
                                    let textH: CGFloat = text.calculateTheHeightOfTheString(font15, width: textW, margin: kRowMargin, maxRow: 2)
                                    shareTtlFrame = CGRect(x: textX, y: textY, width: textMaxW, height: textH)
                                    
                                    let marg: CGFloat = 5
                                    
                                    let iconW: CGFloat = 60.0*kScreenWidth/414.0
                                    let iconH: CGFloat = 60
                                    let iconY = shareTtlFrame!.maxY + marg
                                    shareIconFrame = CGRect(x: textX, y: iconY, width: iconW, height: iconH)
                                    
                                    let contentX: CGFloat = shareIconFrame!.maxX + marg
                                    let contentW = textMaxW - iconW - marg
                                    shareContentFrame = CGRect(x: contentX, y: iconY, width: contentW, height: iconH)
                                    
                                    let textBackW: CGFloat = textMaxW + textX + 20
                                    let textBackH: CGFloat = shareContentFrame!.maxY + 15
                                    let textBackX: CGFloat = iconFrame!.minX - kMargin - textBackW
                                    textBackFrame = CGRect(x: textBackX, y: textBackY, width: textBackW, height: textBackH)
                                } else { // 分享出错处理
                                    textFrame = CGRect.zero
                                    let textBackW: CGFloat = 60
                                    let textBackH: CGFloat = 36
                                    let textBackX: CGFloat = iconFrame!.minX - kMargin - textBackW
                                    textBackFrame = CGRect(x: textBackX, y: textBackY, width: textBackW, height: textBackH)
                                }
                            } else { // 文字
                                
                                textFrame = CGRect(x: textX, y: textY, width: textW, height: textH)
                                
                                let textBackW: CGFloat = textW + textX*2 > 60 ? textW + textX*2 : 60
                                let textBackH: CGFloat = textH + 2*textY
                                let textBackX: CGFloat = iconFrame!.minX - kMargin - textBackW
                                textBackFrame = CGRect(x: textBackX, y: textBackY, width: textBackW, height: textBackH)
                            }
                        } else if model!.pictureString != nil { // 图片
                            
                            let textBackW: CGFloat = 168
                            let textBackH: CGFloat = 140
                            let textBackX: CGFloat = iconFrame!.minX - kMargin - textBackW
                            pictureFrame = CGRect(x: 0, y: 0, width: textBackW, height: textBackH)
                            textBackFrame = CGRect(x: textBackX, y: textBackY, width: textBackW, height: textBackH)
                        } else if model!.voicePath != nil { // 语音
                            let textBackW: CGFloat = 114
                            let textBackH: CGFloat = 36
                            let textBackX: CGFloat = iconFrame!.minX - kMargin - textBackW
                            textBackFrame = CGRect(x: textBackX, y: textBackY, width: textBackW, height: textBackH)
                            
                            yuyinFrame = CGRect(x: 22, y: 0, width: textBackW - 44, height: 36)
                        }
                        
                        LLog(textBackFrame)
                        //                let maxW: CGFloat = CGRectGetMinX(textBackFrame!) - kMargin*2
                        //                let time = model!.handerTime ?? ""
                        //                let timeW: CGFloat = time.calculateTheSizeOfTheString(font8, maxWidth: maxW).width + 8 + kMargin/2
                        //                let timeX: CGFloat = CGRectGetMinX(textBackFrame!) - kMargin - timeW
                        //                timeFrame = CGRectMake(timeX, CGRectGetMinY(textBackFrame!) + 9, timeW, 11)
                        
                        cellH = textBackFrame!.maxY + 28
                    } else { // 别人
                        iconFrame = CGRect(x: iconMarX, y: kMargin, width: iconWH, height: iconWH)
                        
                        LLog(model!.text)
                        LLog(model!.pictureString)
                        LLog(model!.voicePath)
                        let textBackX: CGFloat = iconFrame!.maxX + kMargin
                        if model!.text != nil { // 文字
                            //                    let textX: CGFloat = 15
                            //                    let textY: CGFloat = kMargin
                            //                    let text = model!.text ?? ""
                            //                    let textMaxW = kScreenWidth/2
                            //                    let textW: CGFloat = text.calculateTheSizeOfTheString(font15, maxWidth: textMaxW).width
                            //                    let textH: CGFloat = text.calculateTheHeightOfTheString(font15, width: textW, margin: kRowMargin, maxRow: 0)
                            textFrame = CGRect(x: textX, y: textY, width: textW, height: textH)
                            
                            let textBackW: CGFloat = textW + textX*2
                            //                    let textBackH: CGFloat = textH + 2*kMargin
                            let textBackH: CGFloat = textH + 2*textY
                            textBackFrame = CGRect(x: textBackX, y: textBackY, width: textBackW, height: textBackH)
                        } else { // 图片
                            
                            let textBackW: CGFloat = 168
                            let textBackH: CGFloat = 140
                            pictureFrame = CGRect(x: 0, y: 0, width: textBackW, height: textBackH)
                            textBackFrame = CGRect(x: textBackX, y: textBackY, width: textBackW, height: textBackH)
                        }
                        
                        LLog(textBackFrame)
                        cellH = textBackFrame!.maxY + 28
                    }
                }
                
            }
        }
    }
}
