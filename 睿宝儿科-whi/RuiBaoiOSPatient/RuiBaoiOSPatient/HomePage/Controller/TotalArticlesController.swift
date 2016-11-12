//
//  TotalArticlesController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  热门资讯

import UIKit

class TotalArticlesController: BaseViewController {

    private var tableView: UITableView!
    fileprivate var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = kMostPopular
        view.backgroundColor = rgb244
        
        // 创建tableView
        setupTableView()
     
        // 测试数据
        for i in 0..<30 {
            
            let model = Article()
            model.articleId = "\(i)"
            model.fileId = "\(i)"
            model.title = "文章标题"
            model.url = "http://www.baidu.com"
            model.label = "标签"
            model.isEssence = "2"
            model.focus = true
            
            model.author = "作者"
            model.doctorId = "\(i)"
            model.department = "科室"
            model.profession = ""
            
            articles.append(model)
        }
        tableView.reloadData()
    }

    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
}


// MARK:- UITableViewDataSource, UITableViewDelegate 

extension TotalArticlesController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ArticleListCell.setupArticleListCell(tableView, cellForRowAtIndexPath: indexPath)
        cell.model = articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 进入文章详情
        let vc = ArticleDetailsController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
