//
//  ShareToConsultationListController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit
//import MBProgressHUD

class ShareToConsultationListController: BaseViewController {

    var ttl: String!
    var content: String!
    var url: String!
    var imgStr: String!
    var consultations: [ConsultationListModel] = Array()
    var tableView: UITableView!

    var maskingNoData: UIImageView?

    var dic:[String : String] = [ : ]
    var doctorIcon: String!
    var doctorIconString: String!
    var doctorIconImage: UIImage?
    var doctorName: String!
    var doctorPhone: String!
    
    var customLoadTip: CustomLoadTip?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置tableView
        setupTableView()
        
        // 加载好友请求
        headerRefresh()
        
        customNavigationItem.leftBarButtonItem = UIBarButtonItem(title: kClose, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ShareToConsultationListController.closeCurrentVC))
        
        // 医生信息
        doctorPhone = defaults.string(forKey: kPatientUserNameKey) ?? ""
        doctorIcon = defaults.string(forKey: kPatientIconKey) ?? ""
        doctorName = defaults.string(forKey: kPatientNameKey) ?? ""
        LLog(doctorPhone)
        dic = ["ID" : doctorPhone, "Icon" : doctorIcon, "Name" : doctorName]
        LLog(dic)
    }
    
    func closeCurrentVC() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = kCellHeight
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    // MARK:- 加载好友列表
    func headerRefresh() {
        DispatchQueue.global(qos: .default).async {
            // 从数据库获取所有会话列表
            let conversations = EMClient.shared().chatManager.getAllConversations()//loadAllConversationsFromDB()
            DispatchQueue.main.async(execute: {
                self.handerData(conversations as [AnyObject]!)
            })
        }
    }
    
    func handerData(_ userlist: [AnyObject]!) {
        self.consultations.removeAll()

        if userlist.count > 0 {
            
            // 去掉蒙版
            maskingNoData?.removeFromSuperview()
            
            for item in userlist {
                LLog(item)
                
                let conversation = item as? EMConversation
                if conversation != nil {
                    let cs = conversation!
                    LLog(cs)
                    let model = ConsultationListModel.setupConsultationListModelWithShare(cs)
                    self.consultations.append(model)
                }
            }
            
            self.tableView.reloadData()
        } else {
            // 获取数据为空
            self.loadNoData()
        }
    }
    
    // MARK:- 加载数据为nil----数据处理
    fileprivate func loadNoData() {
        maskingNoData?.removeFromSuperview()
        if maskingNoData == nil {
            let maskingW: CGFloat = 78
            let maskingH: CGFloat = 66
            let maskingX: CGFloat = (kScreenWidth - maskingW)/2
            let maskingY: CGFloat = (tableView.frame.height - maskingW)/2
            
            maskingNoData = UIImageView(frame: CGRect(x: maskingX, y: maskingY, width: maskingW, height: maskingH))
            maskingNoData?.image = UIImage(named: "NoConsulation")
        }
        view.addSubview(maskingNoData!)
    }
}

// MARK:- UITableViewDataSource, UITableViewDelegate
extension ShareToConsultationListController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consultations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShareToConsulatListCell.setupConsultationCell(tableView, indexPath: indexPath)
        cell.model = consultations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = consultations[indexPath.row]
        let alertController = UIAlertController(title: kSureToSendTo, message: model.name, preferredStyle: UIAlertControllerStyle.alert)

        let cancleAction = UIAlertAction(title:kCancle, style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancleAction)
        
        let yesAction = UIAlertAction(title: kEnsure, style: UIAlertActionStyle.default) { (action) in
            
            // 1. 构造文字消息
            let txt = "#^!#" + self.ttl + "#^!#" + self.content + "#^!#" + self.imgStr + "#^!#" + self.url 
            LLog(txt)
            let body = EMTextMessageBody.init(text: txt)
            
            // 2. 生成Message
            let model = self.consultations[indexPath.row]
            let message = EMMessage(conversationID: model.patientID, from: self.doctorPhone, to: model.patientID, body: body, ext: self.dic)
            message?.chatType = EMChatTypeChat // 设置为单聊消息
            
            // 3. 发送消息
//            MBProgressHUD.showHUDAddedTo(nil, animated: true)
            self.customLoadTip = CustomLoadTip.showLoadTip(self.view)
            
            EMClient.shared().chatManager.send(message, progress: { (progress) in
                LLog(progress)
                }, completion: { (msg, error) in
                    LLog(error)
                    //                    MBProgressHUD.showHUDAddedTo(nil, animated: true)
                    self.customLoadTip?.hideLoadTipWithSuccess()
                    
                    if error == nil {
                        CustomMBProgressHUD.showSuccess(kShareSuccessTip, view: nil)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        CustomMBProgressHUD.showFailed(kShareFaileTip, view: nil)
                    }
            })
            
//            EMClient.shared().chatManager.asyncSend(message, progress: { (_) in
//                LLog(message)
//                }, completion: { (msg, error) in
//            })
        }
        alertController.addAction(yesAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView(frame: CGRect(x: kMargin, y: 0, width: 100, height: 30))
        
        let lbl = UILabel(frame: CGRect(x: kMargin, y: 0, width: 100, height: 30))
        lbl.text = kRecentChat
        lbl.font = font12
        lbl.textColor = rgb153
        vw.addSubview(lbl)

        return vw
    }
}
