//
//  MedicalRecordDetailsController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/7/9.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  病历详情


import UIKit
import AFNetworking
//import MBProgressHUD

class MedicalRecordDetailsController: BaseViewController {

    var patient: MedicalRecord!
    
    // 目录按钮
    var catalog: UIButton!
    var tableView: UITableView!
    fileprivate var allergy: UILabel?
    
//    var sections = [SMTZ, GMLB, JWS, JZS, JBLB, YYLB, YMLB, SYSJC, JZJL]//[String]()
    var sections = [SMTZ, GMLB, JBLB, YYLB, YMLB, SYSJC, JZJL]//[String]()
    var lists = RecordSectionModel()
    
    var listView: UIView?
    var masking: UIView?
  
    var customLoadTip: CustomLoadTip?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBarButtonItem()
        
//        for _ in 0..<9 {
//            var dd = [RecordListModel]()
//            for _ in 0..<5 {
//                let mdl = RecordListModel()
//                mdl.listKey = "送达方式"
//                mdl.listValue = "法师打发多少发送发送"
//                dd.append(mdl)
//            }
//            lists.append(dd)
//        }
        
        LLog(lists)

        // tableView
        setupTableView()
        
        // 加载数据
        loadData()
    }
    
    fileprivate func setupBarButtonItem() {
        title = kMedicalRecordDetails
        
        catalog = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        catalog.setTitle(kCatalog, for: .normal)
        catalog.setTitleColor(UIColor.white, for: .normal)
        catalog.titleLabel?.font = font16
        catalog.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        catalog.addTarget(self, action: #selector(MedicalRecordDetailsController.catalogClicked), for: .touchUpInside)
        catalog.isHidden = true
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: catalog)
        
        
        
        // 创建目录列表模块
        if listView == nil {
            let btnW: CGFloat = 120
            let btnH: CGFloat = 44
            let listW = btnW
            let listH = btnH*CGFloat(sections.count)
            let listX = kScreenWidth - listW
            listView = UIView(frame: CGRect(x: listX, y: 64, width: listW, height: listH))
            listView!.backgroundColor = UIColor.white
            view.insertSubview(listView!, at: 0)
            
            let line = UIView(frame: CGRect(x: 0, y: 0, width: 0.5, height: listH))
            line.backgroundColor = rgbSameColor(213)
            listView!.addSubview(line)
            
            for i in 0..<sections.count {
                let btn = UIButton(frame: CGRect(x: 0, y: CGFloat(i)*btnH, width: btnW, height: btnH))
                btn.tag = i
                btn.setTitle(sections[i], for: .normal)
                btn.setTitleColor(rgb51, for: .normal)
                btn.titleLabel?.font = font16
                btn.addTarget(self, action: #selector(MedicalRecordDetailsController.btnClicked(_:)), for: .touchUpInside)
                listView!.addSubview(btn)
                
                let line = UIView(frame: CGRect(x: 0, y: btnH - 0.5, width: btnW, height: 0.5))
                line.backgroundColor = rgbSameColor(213)
                btn.addSubview(line)
            }
        }
    }
    
    func btnClicked(_ btn: UIButton) {
        maskingClicked()
        
        switch btn.tag {
        case 0:
            if lists.shengMingTiZhengs.count == 0 {
                return
            }
        case 1:
            if lists.guoMinLieBiaos.count == 0 {
                return
            }
        case 2:
            if lists.jiBingLieBiaos.count == 0 {
                return
            }
        case 3:
            if lists.yongYaoLieBiaos.count == 0 {
                return
            }
        case 4:
            if lists.yiMiaoLieBiaos.count == 0 {
                return
            }
        case 5:
            if lists.shiYanShiJianChas.count == 0 {
                return
            }
        case 6:
            if lists.jiuZhenJiLus.count == 0 {
                return
            }
        default:
            LLog("")
        }
        
        let path = IndexPath(row: 0, section: btn.tag)
        tableView.scrollToRow(at: path, at: UITableViewScrollPosition.top, animated: false)
    }

    
    // 返回
    func leftBarBttonItemClick(_ bar:AnyObject) {
        masking?.removeFromSuperview()
        self.tableView.frame.origin.x = 0
        _ = navigationController?.popViewController(animated: true)
    }
    
    // 目录
    func catalogClicked() {
        
        if tableView.frame.origin.x == 0 { // 显示目录
            
            UIView.animate(withDuration: 0.25, animations: {
                self.tableView.frame.origin.x = -120
            }) 
            
            if masking == nil {
                masking = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 120, height: kScreenHeight))
                
                // 点击
                let tap = UITapGestureRecognizer(target: self, action: #selector(MedicalRecordDetailsController.maskingClicked))
                masking!.addGestureRecognizer(tap)
                
                // 拖拽
                let pan = UIPanGestureRecognizer(target: self, action: #selector(MedicalRecordDetailsController.maskingClicked))
                masking!.addGestureRecognizer(pan)
            }
            view.addSubview(masking!)
            
        } else { // 隐藏目录
            maskingClicked()
        }
    }

    func maskingClicked() {
        masking?.removeFromSuperview()
        
        UIView.animate(withDuration: 0.25, animations: { 
            self.tableView.frame.origin.x = 0
        }) 
    }
    
    // MARK:- tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableHeaderView = setupTableHeaderView()
        tableView.backgroundColor = rgb244
        view.addSubview(tableView)
    }
    
    fileprivate func setupTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 98))
        header.backgroundColor = UIColor.white
        
        let icon = UIImageView(frame: CGRect(x: 15, y: 20, width: 45, height: 45))
        let iconStr = patient.sex == "F" ? "Bitmap22" : "Bitmap"
        icon.image = UIImage(named: iconStr)
        icon.layer.cornerRadius = 22.5
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.scaleAspectFill
        header.addSubview(icon)
        icon.sd_setImage(with: URL.init(string: patient!.patientIcon), placeholderImage: UIImage.init(named: iconStr))

        let nameX = icon.frame.maxX + 15
        let nameW = kScreenWidth - nameX - 15
        let name = UILabel(frame: CGRect(x: nameX, y: 16, width: nameW, height: 22))
        name.text = patient.name
        name.textColor = rgb51
        name.font = font16
        header.addSubview(name)
        
        let sexAgeBirthday = UILabel(frame: CGRect(x: nameX, y: name.frame.maxY + 2, width: nameW, height: 17))
        var sexAgeBirthdayStr = patient.sex == "F" ? "\(kFemale)" : "\(kMale)"
        if patient.age.characters.count > 0 {
            sexAgeBirthdayStr = sexAgeBirthdayStr + " " + "\(patient.age)\(kAge)"
        }
        if patient.dob.characters.count > 0 {
            sexAgeBirthdayStr = sexAgeBirthdayStr + " " + patient.dob
        }
        sexAgeBirthday.text = sexAgeBirthdayStr
        sexAgeBirthday.textColor = rgb153
        sexAgeBirthday.font = font12
        header.addSubview(sexAgeBirthday)
        
        allergy = UILabel(frame: CGRect(x: nameX, y: sexAgeBirthday.frame.maxY + 2, width: nameW, height: 20))
        allergy!.text = "\(kAllergy)"
        allergy!.textColor = rgb102
        allergy!.font = font14
        header.addSubview(allergy!)
        
        return header
    }
    
    // 加载数据
    fileprivate func loadData() {

        let url = "cases/\(patient.patientID)"
        LLog(url)
        
        customLoadTip = CustomLoadTip.showLoadTip(view)
        
        NetworkTools.shareNetworkTools().get(url, parameters: nil, progress: { (progress) -> Void in
            LLog(progress)
            }, success: { (_, responseObject) -> Void in
               
                LLog(responseObject)
                
                if (responseObject != nil) {
                    
                    if let dict = responseObject as? Dictionary<String, AnyObject> {
                        
                        self.customLoadTip?.hideLoadTipWithSuccess()
                        
                        if let dics = dict["values"] as? Dictionary<String, AnyObject> {
                            
                            self.lists = RecordSectionModel.setupRecordSectionModelWithDictionary(dics as NSDictionary)
                            
                            // 过敏原
                            var allergyTxt = "\(kAllergy)"
                            for model in self.lists.guoMinLieBiaos {
                                allergyTxt = allergyTxt + model.guoMinYuan + "、"
                            }
                            if allergyTxt.characters.count > 3 {
                                allergyTxt = (allergyTxt as NSString).substring(to: allergyTxt.characters.count - 1)
                            }
                            self.allergy?.text = allergyTxt

                            // 目录
                            self.catalog.isHidden = false

                            
                            // 刷新数据
                            self.tableView.reloadData()
                        }
                    } else {
                        self.customLoadTip?.hideLoadTipWithError()
                    }
                } else {
                    self.customLoadTip?.hideLoadTipWithError()
                }
        }) { (_, error) -> Void in
            LLog(error)
            self.customLoadTip?.hideLoadTipWithError()
        }
    }
}

extension MedicalRecordDetailsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return lists.shengMingTiZhengs.count > 0 ? 1 : 0
        case 1:
            return lists.guoMinLieBiaos.count
        case 2:
            return min(lists.jiBingLieBiaos.count, 3)
        case 3:
            return min(lists.yongYaoLieBiaos.count, 3)
        case 4:
            return min(lists.yiMiaoLieBiaos.count, 3)
        case 5:
            return min(lists.shiYanShiJianChas.count, 3)
        case 6:
            return min(lists.jiuZhenJiLus.count, 3)
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = RecordSMTZCell.setupRecordSMTZCell(tableView, indexPath: indexPath)
            cell.model = lists.shengMingTiZhengs[0]
            return cell
        }        
        
        let cell = RecordListCell.setupRecordListCell(tableView, indexPath: indexPath)
       
        switch indexPath.section {
        case 1:
            cell.model1 = lists.guoMinLieBiaos[indexPath.row]
        case 2:
            cell.model2 = lists.jiBingLieBiaos[indexPath.row]
        case 3:
            cell.model3 = lists.yongYaoLieBiaos[indexPath.row]
        case 4:
            cell.model4 = lists.yiMiaoLieBiaos[indexPath.row]
        case 5:
            cell.model5 = lists.shiYanShiJianChas[indexPath.row]
        default:
            cell.model6 = lists.jiuZhenJiLus[indexPath.row]
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 6*40
        }
//        else if indexPath.section == 2 {
//            
//            let maxW: CGFloat = kScreenWidth - 30
//            let ttH = lists.jiWangShi.jiWangShiString.calculateTheSizeOfTheString(font14, maxWidth: maxW).height
//            let endH = max(ttH + 24, 40)
//            LLog(endH)
//            return endH
//        } else if indexPath.section == 3 {
//            
//            let maxW: CGFloat = kScreenWidth - 30
//            let ttH = lists.jiaZuShi.JiaZuShiString.calculateTheSizeOfTheString(font14, maxWidth: maxW).height
//            let endH = max(ttH + 24, 40)
//            LLog(endH)
//            return endH
//        }
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 41))
        header.backgroundColor = rgb244
        
        let top = UIView(frame: CGRect(x: 0, y: kMargin, width: kScreenWidth, height: 31))
        top.backgroundColor = UIColor.white
        header.addSubview(top)

        let sectionTip = sections[section]
        let backImgW = sectionTip.calculateTheSizeOfTheString(font14, maxWidth: 200).width + 30
        let backImg = UIImageView(frame: CGRect(x: 0, y: 0, width: backImgW, height: 26))
        backImg.image = UIImage(named: kSchedulingPaiBanInfoTip)
        top.addSubview(backImg)

        let tip = UILabel(frame: backImg.bounds)
        let tipTxt = sectionTip
        tip.text = tipTxt
        tip.font = font14
        tip.textColor = UIColor.white
        tip.textAlignment = .center
        top.addSubview(tip)
        
        if ((section == 0 && lists.shengMingTiZhengs.count > 1)
            || (section == 2 && lists.jiBingLieBiaos.count > 3)
            || (section == 3 && lists.yongYaoLieBiaos.count > 3)
            || (section == 4 && lists.yiMiaoLieBiaos.count > 3)
            || (section == 5 && lists.shiYanShiJianChas.count > 3)
            || (section == 6 && lists.jiuZhenJiLus.count > 3)) {
            let moreW: CGFloat = 100
            let moreX = kScreenWidth - 15 - moreW
            let more = UIButton(frame: CGRect(x: moreX, y: 0, width: moreW, height: 26))
            more.setTitle("\(kMore)", for: .normal)
            more.setTitleColor(rgbColor(55, g: 62, b: 78), for: .normal)
            more.titleLabel?.font = font14
            // 按钮中的文字水平居中
            more.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
            more.tag = section
            more.addTarget(self, action: #selector(MedicalRecordDetailsController.seekMore(_:)), for: .touchUpInside)
            top.addSubview(more)
        }
        
        return header
    }
    
    // 更多
    func seekMore(_ btn: UIButton) {
        
        switch btn.tag {
        case 0: // 生命体征
            
            let vc = SMTZListController()
            vc.shengMingTiZhengs = lists.shengMingTiZhengs
            navigationController?.pushViewController(vc, animated: true)
            
        case 2: // 疾病列表
            
            let vc = JiBingListController()
            vc.jiBingLieBiaos = lists.jiBingLieBiaos
            navigationController?.pushViewController(vc, animated: true)

        case 3: // 用药列表
            
            let vc = YongYaoListController()
            vc.yongYaoLieBiaos = lists.yongYaoLieBiaos
            navigationController?.pushViewController(vc, animated: true)

        case 4: // 疫苗列表
            
            let vc = YiMiaoListController()
            vc.yiMiaoLieBiaos = lists.yiMiaoLieBiaos
            navigationController?.pushViewController(vc, animated: true)

        case 5: // 实验室检查
            
            let vc = SYSJCListController()
            vc.shiYanShiJianChas = lists.shiYanShiJianChas
            navigationController?.pushViewController(vc, animated: true)

        case 6: // 就诊记录
            
            let vc = JuZhenJiLuListController()
            vc.jiuZhenJiLus = lists.jiuZhenJiLus
            navigationController?.pushViewController(vc, animated: true)

        default:
            LLog("其他")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
      
        case 1: // 过敏原
            
            let vc = GuoMinDetailsController()
            vc.model = lists.guoMinLieBiaos[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        case 2: // 疾病列表
            
            let vc = JiBingDetailsController()
            vc.model = lists.jiBingLieBiaos[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)

        case 3: // 用药列表
            
            let vc = YongYaoDetailsController()
            vc.model = lists.yongYaoLieBiaos[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)

        case 4: // 疫苗列表
            
            let vc = YiMiaoDetailsController()
            vc.model = lists.yiMiaoLieBiaos[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)

        case 5: // 实验室检查
            
            let vc = SYSJCDetailsController()
            vc.model = lists.shiYanShiJianChas[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)

        case 6: // 就诊记录
            
            let vc = JuZhenJiLuDetailsController()
            vc.model = lists.jiuZhenJiLus[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)

        default:
            LLog("其他")
        }
    }
}
