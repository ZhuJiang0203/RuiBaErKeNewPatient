//
//  AppSkinColor.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/8/18.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

enum AppSkinType {
    case solemn // 庄重
    case fresh // 清新
}


// app的主色调(睿宝)
let appColor = rgbColor(253, g: 119, b: 142)
// app的主色调(连康)
var appMainColor = rgbColor(55, g: 62, b: 78)

var tabBarItemIcon0 = "tabBar0"
var tabBarItemIcon1 = "tabBar1"
var tabBarItemIcon2 = "tabBar2"
var tabBarItemIcon3 = "tabBar3"
var tabBarItemIcon4 = "tabBar4"
var tabBarItemIcons = ["tabBar0", "tabBar1", "tabBar2", "tabBar2", "tabBar3"]


var profileCellIcons = ["profileCell5Icon", "profileCell0Icon", "profileCell1Icon", "profileCell2Icon", "profileCell3Icon", "profileCell4Icon"]


var kSchedulingPaiBanInfoTip = "SchedulingPaiBanInfoTip"
var kSchedulingPaiBanInfoTipBlak = "SchedulingPaiBanInfoTipBlak"

var kScheduleButtonTodayBackgroundColor = rgbColor(36, g: 199, b: 137)
var kScheduleButtonOtherBackgroundColor = appMainColor
var kSchedulingButtonPlus = "SchedulingButtonPlus"
var kPatientDetailViewFollowUp = "PatientDetailViewFollowUp"
var kSchedulingCtlNextOrLastMonthViewBackgroundColor = rgbColor(157, g: 165, b: 182)
var kScheduleDetailsDeleteBack = "ScheduleDetailsDeleteBack"

var kEventCell0BackgroundColor = rgbColor(104, g: 116, b: 144)
var kEventCell1BackgroundColor = rgbColor(131, g: 141, b: 165)
var kEventCell2BackgroundColor = rgbColor(153, g: 164, b: 190)


var kUnReadLabelBackgroundColor = rgbColor(252, g: 61, b: 57)
var kProgressBarBackgroundColor = rgbColor(36, g: 199, b: 137)
var kConfirmReceptBtnBack = "confirmReceptBtnBack"
var kGroup = "Group"
var kClinicBackSelected = "ClinicBackSelected"



var kNoConsulationIcon = "NoConsulationIcon"
var kNoEvaluateIcon = "NoEvaluateIcon"
var kNoPatientIcon = "NoPatientIcon"
var kNoSchedulingIcon = "NoSchedulingIcon"



class AppSkinColor: NSObject {
   
    class func shareAppSkinColor() -> AppSkinColor{
        return tools
    }
    
    fileprivate static let tools: AppSkinColor = {
        let manager = AppSkinColor()
        return manager
    }()
    
    // MARK:- 是否为英文环境
    func getAppSkinType() -> AppSkinType {
        let skinNumber = defaults.object(forKey: kAppSkinNumberKey) as? String ?? ""
       
        switch skinNumber {
        case "1": // 清新
            return AppSkinType.fresh
        default: // 默认：庄重（“0”）
            return AppSkinType.solemn
        }
    }
    
    // MARK:- 切换中英文环境
    func toChangeAppSkin() {
        let skinNumber = defaults.object(forKey: kAppSkinNumberKey) as? String ?? ""

        switch skinNumber {
        case "1": // 清新
            
            appMainColor = rgbColor(249, g: 117, b: 140)
           
            tabBarItemIcon0 = "tabBar0QX"
            tabBarItemIcon1 = "tabBar1QX"
            tabBarItemIcon2 = "tabBar2QX"
            tabBarItemIcon3 = "tabBar3QX"
            tabBarItemIcons = ["tabBar0QX", "tabBar1QX", "tabBar2QX", "tabBar3QX", "tabBar4QX"]

            
            profileCellIcons = ["profileCell5IconQX", "profileCell0IconQX", "profileCell1IconQX", "profileCell2IconQX", "profileCell3IconQX", "profileCell4IconQX"]

            
            kSchedulingPaiBanInfoTip = "SchedulingPaiBanInfoTipMMD"
            kSchedulingPaiBanInfoTipBlak = "SchedulingPaiBanInfoTipBlakMMD"
            
            kScheduleButtonTodayBackgroundColor = rgbColor(142, g: 205, b: 248)
            kScheduleButtonOtherBackgroundColor = rgbColor(255, g: 163, b: 179)
            kSchedulingButtonPlus = "SchedulingButtonPlusMMD"
            kPatientDetailViewFollowUp = "PatientDetailViewFollowUpMMD"
            kSchedulingCtlNextOrLastMonthViewBackgroundColor = rgbColor(255, g: 205, b: 97)
            kScheduleDetailsDeleteBack = "ScheduleDetailsDeleteBackMMD"

            kEventCell0BackgroundColor = rgbColor(255, g: 205, b: 97)
            kEventCell1BackgroundColor = rgbColor(62, g: 225, b: 166)
            kEventCell2BackgroundColor = rgbColor(120, g: 192, b: 241)
            

            kUnReadLabelBackgroundColor = rgbColor(120, g: 192, b: 241)
            kProgressBarBackgroundColor = rgbColor(75, g: 76, b: 90)
            kConfirmReceptBtnBack = "confirmReceptBtnBackMMD"
            kGroup = "GroupMMD"

            
            kClinicBackSelected = "ClinicBackSelectedMMD"

            kNoConsulationIcon = "NoSomeDataMMD"
            kNoEvaluateIcon = "NoSomeDataMMD"
            kNoPatientIcon = "NoSomeDataMMD"
            kNoSchedulingIcon = "NoSchedlingMMD"

            
        default: // 默认：庄重（“0”）
            LLog("默认")
        }
    }
    
}
