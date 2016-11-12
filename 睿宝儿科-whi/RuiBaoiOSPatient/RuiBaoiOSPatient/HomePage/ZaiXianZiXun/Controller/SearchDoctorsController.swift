//
//  SearchDoctorsController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/6.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit


class SearchDoctorsController: BaseViewController {
    
    var onlineConsultCtl: OnlineConsultController?
    
    fileprivate var searchBar: UISearchBar!
    fileprivate var tableView: UITableView!
    fileprivate var searchHistory: [String] = Array()
    fileprivate var clearBtn: ClearHistoryButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置titleView
        customNavigationItem.titleView = setupTitleView()
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: setupRightBarButtonItem())
        
        // 取出历史搜索
        searchHistory = (defaults.object(forKey: kSearchDoctorsArrayKey) as? [String]) ?? []
        LLog(searchHistory)

        // 创建tableView
        setupTableView()
     }
    
    private func setupRightBarButtonItem() -> UIButton {
        let btnW: CGFloat = kCancle.calculateTheSizeOfTheString(font16, maxWidth: 100).width
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: btnW, height: 44))
        btn.setTitle(kCancle, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = font16
        btn.titleLabel?.textAlignment = .right
        btn.addTarget(self, action: #selector(SearchDoctorsController.dismissCurrentCtl), for: .touchUpInside)
        return btn
    }
    
    func dismissCurrentCtl() {
        searchBar.resignFirstResponder()
        dismiss(animated: false, completion: nil)
    }
    
   // MARK:- 设置titleView
    private func setupTitleView() -> UIView {
        
        let titleViewH: CGFloat = 44
        let titleView = UIView(frame: CGRect(x: 0, y: 20, width: kScreenWidth, height: titleViewH))
//        titleView.backgroundColor = UIColor.blue
        
        let searchH: CGFloat = 30
        let searchY: CGFloat = (titleViewH - searchH)/2
        let searchX: CGFloat = 0
        let searchW: CGFloat = kScreenWidth - 70//2*searchX
        searchBar = UISearchBar(frame: CGRect(x: searchX, y: searchY, width: searchW, height: searchH))
        titleView.addSubview(searchBar)
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        searchBar.placeholder = kDoctorsPlaechoder
        searchBar.tintColor = appMainColor
        // 删除UISearchBar中的UISearchBarBackground
        for vw in searchBar.subviews {
            
            if vw.isKind(of: UIView.self) {
                for subView in vw.subviews {
                    
                    LLog(subView)
                    
                    if subView.isKind(of: UITextField.self) {
                        subView.backgroundColor = rgb244
                    } else if subView.isKind(of: UIView.self) {
                        subView.removeFromSuperview()
                    }
                    
//                    if subView.isKindOfClass(NSClassFromString("UISearchBarBackground")!) {
//                        subView.removeFromSuperview()
//                    } else if subView.isKindOfClass(NSClassFromString("UISearchBarTextField")!) {
//                        subView.backgroundColor = rgb244
//                    }
                }
                break
            }
        }
        searchBar.showsCancelButton = false
//        searchBar.backgroundColor = UIColor.red
        
        return titleView
    }

    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 40
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = setupTableFooterView()
        view.addSubview(tableView)
        
        tableView.isHidden = searchHistory.count == 0
    }
    
    private func setupTableFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 55))
        footerView.backgroundColor = UIColor.white
        
        let clearBtnW: CGFloat = kClearHistoryRecord.calculateTheSizeOfTheString(font15, maxWidth: 200).width + 10 + 15 + 10 + 10
        let clearBtnX: CGFloat = (kScreenWidth - clearBtnW)/2
        clearBtn = ClearHistoryButton(frame: CGRect(x: clearBtnX, y: 15, width: clearBtnW, height: 30))
//        clearBtn!.backgroundColor = UIColor.red
        clearBtn!.addTarget(self, action: #selector(SearchDoctorsController.qingKongLiShi), for: .touchUpInside)
        footerView.addSubview(clearBtn!)
        
        return footerView
    }
    
    func qingKongLiShi() {
        let alertCtl = UIAlertController(title: nil, message: kClearAllQueryHistoryTip, preferredStyle: .alert)
        let cancle = UIAlertAction(title: kCancle, style: .cancel) { (action) in
            
        }
        alertCtl.addAction(cancle)
        let ok = UIAlertAction(title: kEnsure, style: .destructive) { (action) in
            
            // 清空列表数据
            self.searchHistory = []
            self.tableView.reloadData()

            // 清空本地记录
            defaults.set(self.searchHistory, forKey: kSearchDoctorsArrayKey)

            self.tableView.isHidden = true
        }
        alertCtl.addAction(ok)
        
        present(alertCtl, animated: true, completion: nil)
    }
}

// MARK:- UISearchBarDelegate
extension SearchDoctorsController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: false, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        let text = searchBar.text
        if searchHistory.contains(text!) {
            searchHistory.remove(at: searchHistory.index(of: text!)!)
        }
        searchHistory.insert(text!, at: 0)
        tableView.reloadData()
        defaults.set(searchHistory, forKey: kSearchDoctorsArrayKey)
        tableView.isHidden = false
        
        // 查询搜索结果
        if onlineConsultCtl != nil {
            onlineConsultCtl!.keyword = text ?? ""
            onlineConsultCtl!.isRefresh = true
            dismiss(animated: false, completion: nil)
        }
    }
    
    
    @objc fileprivate func rightButtonClicked(btn: UIButton) {
        deleteOneSearchHistoryRecoder(index: btn.tag)
    }
    
    fileprivate func deleteOneSearchHistoryRecoder(index: Int) {
        
        searchHistory.remove(at: index)
        
        // 清空本地记录
        defaults.set(self.searchHistory, forKey: kSearchDoctorsArrayKey)
        
        tableView.reloadData()
        
        CustomMBProgressHUD.showSuccess(kDeleteSuccess, view: nil)
        
        tableView.isHidden = searchHistory.count == 0
    }
}

// MARK:- UITableViewDataSource, UITableViewDelegate
extension SearchDoctorsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellH: CGFloat = 40
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.font = font14
        cell.textLabel?.textColor = rgb50
        cell.textLabel?.text = searchHistory[indexPath.row]
        let line = UIView(frame: CGRect(x: 0, y: 39.5, width: kScreenWidth, height: 0.5))
        line.backgroundColor = lineColor
        cell.contentView.addSubview(line)
        
        let rightButtonW: CGFloat = 50
        let rightButtonX: CGFloat = kScreenWidth - rightButtonW
        let rightButton = UIButton(frame: CGRect(x: rightButtonX, y: 0, width: rightButtonW, height: cellH))
        rightButton.setImage(UIImage.init(named: "SearchDeleteNormal"), for: .normal)
        rightButton.setImage(UIImage.init(named: "SearchDeleteSelected"), for: .highlighted)
        rightButton.tag = indexPath.row
        rightButton.addTarget(self, action: #selector(SearchDoctorsController.rightButtonClicked(btn:)), for: .touchUpInside)
        cell.contentView.addSubview(rightButton)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchBar.resignFirstResponder()
        
        if onlineConsultCtl != nil {
            onlineConsultCtl!.keyword = searchHistory[indexPath.row]
            onlineConsultCtl!.isRefresh = true
            dismiss(animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vwH: CGFloat = 40
        let vw = UIView(frame: CGRect(x: 0, y: kMargin, width: kScreenWidth, height: vwH))
        vw.backgroundColor = UIColor.white
        
        let tip = UILabel(frame: CGRect(x: kMargin, y: 0, width: 100, height: vwH))
        tip.text = kHistoryRecord
        tip.textColor = rgb102
        tip.font = font14
        vw.addSubview(tip)
        
        return vw
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    
    
    
    /*************** ❤️❤️❤️ ***************/
    /**************** ❤️❤️ ***************/
    /***************** ❤️ ***************/

    // MARK: - 切记：ios9之前必须实现此方法，不然没效果
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {}
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let action1 = UITableViewRowAction(style: .destructive, title: kDelete) { (action, indexpath) in
            self.deleteOneSearchHistoryRecoder(index: indexpath.row)
        }
        action1.backgroundColor = UIColor.red

        return [action1]
    }
}
