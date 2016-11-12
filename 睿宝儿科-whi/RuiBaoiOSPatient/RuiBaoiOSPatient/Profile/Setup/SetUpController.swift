//
//  SetUpController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/4.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  设置

import UIKit
//import SVProgressHUD


class SetUpController: BaseViewController {
    
    var titles = [kProfileLanguage, kCcountSecurity, kProfileFeedback]
    var tableView: UITableView!
    
    
    var btnTitles = ["简体中文", "English", kCancle]
    var isEnglishEnvironmentalNumber = 100 // 随便取得值
    
    var customLoadTip: CustomLoadTip?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = kProfileMySetup

        // tableView
        setupTableView()
        
        // 退出
        setUpSignOutButton()
    }
    
    // MARK:- tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = kCellHeight
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        view.addSubview(tableView)
    }
    
    // MARK:- 退出
    fileprivate func setUpSignOutButton() {
        let btn = UIButton(frame: CGRect(x: 0, y: kScreenHeight - 48, width: kScreenWidth, height: 48))
        btn.setBackgroundImage(UIImage(named: kScheduleDetailsDeleteBack), for: .normal)
        btn.setTitle(kProfileSignOut, for: .normal)
        btn.titleLabel?.font = font16
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(SetUpController.signOut), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    // MARK:- 退出登录
    func signOut() {
        
        customLoadTip = CustomLoadTip.showLoadTip(nil)

        // 异步，
        DispatchQueue.global(qos: .default).async {
          
            // 环信退出
            EMClient.shared().logout(true)
            
            // 这里返回主线程，注销保存在本地的医生信息
            DispatchQueue.main.async(execute: {
                
                // 是否已注册环信
                defaults.setValue("", forKey: kIsResignHuanXin)
                // 是否已登录环信
                defaults.setValue("", forKey: kIsResignHuanXin)
                
                // 机构id
                defaults.setValue("", forKey: kOrganizationIDKey)
                // 诊所id
                defaults.setValue("", forKey: kPracticeIDKey)
                // 医生id
                defaults.setValue("", forKey: kPatientIDKey)
                // 医生token
                defaults.setValue("", forKey: kPatientTockenKey)
                // 头像
                defaults.setValue("", forKey: kPatientIconKey)
                // 性别
                defaults.setValue("", forKey: kPatientSexKey)
                // 中文名字
                defaults.setValue("", forKey: kPatientNameKey)
                // 英文名字
                defaults.setValue("", forKey: kPatientEnglishNameKey)
                // 用户名
                defaults.setValue("", forKey: kPatientUserNameKey)

                
                self.customLoadTip?.hideLoadTipWithSuccess()
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                    let window = UIApplication.shared.delegate!.window!
//                    let vc = LoginController()
                    let vc = LoginViewController()
                    let navVC = BaseNavigationController(rootViewController: vc)
                    window?.rootViewController = navVC
                    window?.makeKeyAndVisible()
                }
            })
        }
    }
    
    var alertView: CustomAlertView?
    func goToChangeLanguage() {
        // 防止多次弹出
        if alertView == nil {
            alertView = CustomAlertView(titls: btnTitles)
            UIApplication.shared.keyWindow?.addSubview(alertView!)
            alertView!.delegate = self
        }
    }
}


// MARK: - Table view data source
extension SetUpController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: nil)
            cell.textLabel?.textColor = rgb102
            cell.textLabel?.font = font16
            cell.detailTextLabel?.font = font16
            cell.detailTextLabel?.textColor = rgb51
            
            let line = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5))
            line.backgroundColor = lineColor
            cell.contentView.addSubview(line)
            
            if indexPath.row == 2 {
                let line = UIView(frame: CGRect(x: 0, y: kCellHeight - 0.5, width: kScreenWidth, height: 0.5))
                line.backgroundColor = lineColor
                cell.contentView.addSubview(line)
            }
            
            cell.textLabel?.text = titles[indexPath.row]
            
            var CnOrEnglish = "中文简体"
            let isEnglishString = defaults.object(forKey: kIsEnglishKey) as? Bool
            if isEnglishString == true {
                CnOrEnglish = "English"
            }
            cell.detailTextLabel?.text = CnOrEnglish
            
            return cell
        }
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.textColor = rgb102
        cell.textLabel?.font = font16
        
        let arroeW: CGFloat = 6
        let arroeH: CGFloat = 10
        let arroeX = kScreenWidth - 15 - arroeW
        let arroeY = (kCellHeight - arroeH)/2
        let arrow = UIImageView(frame: CGRect(x: arroeX, y: arroeY, width: arroeW, height: arroeH))
        arrow.image = UIImage(named: "ArrowGray610")
        cell.contentView.addSubview(arrow)
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5))
        line.backgroundColor = lineColor
        cell.contentView.addSubview(line)
        
        if indexPath.row == 2 {
            let line = UIView(frame: CGRect(x: 0, y: kCellHeight - 0.5, width: kScreenWidth, height: 0.5))
            line.backgroundColor = lineColor
            cell.contentView.addSubview(line)
        }
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = "fad"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            goToChangeLanguage()
        case 1:
            navigationController?.pushViewController(AccountSecurityController(), animated: true)
        default:
            navigationController?.pushViewController(FeedbackController(), animated: true)
        }
    }

}


// MARK: - CustomAlertViewDelegate
extension SetUpController: CustomAlertViewDelegate {
    func someButtonOfCustomAlertViewClicked(_ tagNumber: Int) {
        
        let currentIsLanguageEnvironmental = ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental()
        switch tagNumber {
        case 0: // 简体中文
            if currentIsLanguageEnvironmental == true {
                isEnglishEnvironmentalNumber = 0
            }
        case 1: // English
            if currentIsLanguageEnvironmental == false {
                isEnglishEnvironmentalNumber = 1
            }
        default: // 取消
            LLog(tagNumber)
        }
    }
    
    // 清空nil
    func customAlertViewSignOut() {
        alertView = nil
        if isEnglishEnvironmentalNumber == 0 {
            startChangeLanguage(false)
        } else if isEnglishEnvironmentalNumber == 1 {
            startChangeLanguage(true)
        }
    }
    
    fileprivate func startChangeLanguage(_ isEnlish: Bool) {
        if isEnlish {
            defaults.set(true, forKey: kIsEnglishKey)
        } else {
            defaults.set(false, forKey: kIsEnglishKey)
        }
        defaults.synchronize()
        
        let window = UIApplication.shared.delegate!.window!
        let vc: MainTabBarController = MainTabBarController()
        isPushToSetUpController = true
        vc.selectedIndex = 4
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

