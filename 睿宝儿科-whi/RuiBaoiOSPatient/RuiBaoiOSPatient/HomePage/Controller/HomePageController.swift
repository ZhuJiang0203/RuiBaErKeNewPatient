//
//  HomePageController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class HomePageController: BaseViewController {

    private var tableView: UITableView!
    /// 签到模块
    private var signView: SignView?
    /// 活动数据
    private var activities = [Activity]()
    /// 文章数据
    fileprivate var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = rgb244
        
        // 测试数据
        for i in 0..<3 {
            
            let model = Activity()
            model.activityId = "\(i)"
            /// 文章title
            model.title = ""
            /// 图片id
            model.imageId = ""
            /// 开始时间
            model.startTime = ""
            /// 结束时间
            model.endTime = ""
            /// 活动url
            model.url = ""
            /// 活动状态：进行中、结束
            model.state = ""

            activities.append(model)
        }
        
        // 创建tableView
        setupTableView()
        
        // 测试数据
        for i in 0..<3 {
            
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if signView != nil {
            judgeTodayWhetherCanSignIn(signView!)
        }
    }
    
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64 - 49), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        // 添加tableHeaderView
        setupTableHeaderView()
    }
    
    /**
     添加tableHeaderView
     */
    private func setupTableHeaderView() {

        var headerH: CGFloat = 380
        if activities.count == 0 {
            headerH = 270
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: headerH))
        headerView.backgroundColor = rgb244 //UIColor.redColor()
        
        let topViewH: CGFloat = 160
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: topViewH))
        topView.backgroundColor = UIColor.white
        headerView.addSubview(topView)
        
        // 预约挂号
        let appointmentH: CGFloat = 160
        let appointment = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth/2, height: appointmentH))
        topView.addSubview(appointment)
        
        let appointmentTap = UITapGestureRecognizer(target: self, action: #selector(HomePageController.appointmentClicked))
        appointment.addGestureRecognizer(appointmentTap)
        
        let appointImg = UIImageView()
        appointImg.image = UIImage(named: "YuYueGuaHaoIcon")
        appointImg.sizeToFit()
        appointImg.center = CGPoint(x: kScreenWidth/4, y: 65)
        appointment.addSubview(appointImg)
        
        let appointTtl = UILabel(frame: CGRect(x: 0, y: appointImg.frame.maxY + 12, width: kScreenWidth/2, height: 22))
        appointTtl.textColor = rgb51
        appointTtl.font = UIFont.boldSystemFont(ofSize: 16)
        appointTtl.textAlignment = .center
        appointTtl.text = kMakeAnAppointment
        appointment.addSubview(appointTtl)
        
        // 在线咨询
        let onlineConsulting = UIView(frame: CGRect(x: kScreenWidth/2, y: 0, width: kScreenWidth/2, height: appointmentH))
        topView.addSubview(onlineConsulting)
        
        let onlineConsultingTap = UITapGestureRecognizer(target: self, action: #selector(HomePageController.onlineConsultingTapClicked))
        onlineConsulting.addGestureRecognizer(onlineConsultingTap)
        
        let consultImg = UIImageView()
        consultImg.image = UIImage(named: "ZaiXianZiXunIcon")
        consultImg.sizeToFit()
        consultImg.center = CGPoint(x: kScreenWidth/4, y: 65)
        onlineConsulting.addSubview(consultImg)
        
        let consultTtl = UILabel(frame: CGRect(x: 0, y: consultImg.frame.maxY + 12, width: kScreenWidth/2, height: 22))
        consultTtl.textColor = rgb51
        consultTtl.font = UIFont.boldSystemFont(ofSize: 16)
        consultTtl.textAlignment = .center
        consultTtl.text = kOnlineConsultation
        onlineConsulting.addSubview(consultTtl)
        
        // 水平线
        let hline = UIView(frame: CGRect(x: 0, y: topViewH - 0.5, width: kScreenWidth, height: 0.5))
        hline.backgroundColor = rgbSameColor(215)
        topView.addSubview(hline)
        
        // 竖直线
        let vline = UIView(frame: CGRect(x: kScreenWidth/2, y: 0, width: 0.5, height: appointmentH))
        vline.backgroundColor = rgbSameColor(215)
        topView.addSubview(vline)
        
        
        // 签到模块
        signView = SignView(frame: CGRect(x: 0, y: topView.frame.maxY, width: kScreenWidth, height: 100))
        signView!.delegate = self
        signView!.dayNumber = 0
        signView!.backgroundColor = UIColor.white
        headerView.addSubview(signView!)
        // 判断今天是否可签到
        judgeTodayWhetherCanSignIn(signView!)
        
        // 滚动界面
        if activities.count > 0 {
            let scrollView = UIView(frame: CGRect(x: 0, y: signView!.frame.maxY + 10, width: kScreenWidth, height: 100))
            scrollView.backgroundColor = UIColor.white
            headerView.addSubview(scrollView)
            
            let carousel = HomeCarouselView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
            carousel.backgroundColor = UIColor.orange
            carousel.delegate = self
            carousel.data = activities
            scrollView.addSubview(carousel)
        }

        tableView.tableHeaderView = headerView
    }
    
    // MARK:- 预约挂号
    @objc private func appointmentClicked() {
        //        requestPracticeData()
        
        // 测试
//        let vc = ToEvaluateController()
        let vc = ClinicViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK:- 在线咨询
    @objc private func onlineConsultingTapClicked() {
//        let vc = DoctorHomePageController()
        let vc = OnlineConsultController()
        navigationController?.pushViewController(vc, animated: true)
    }

    
    // MARK:- 判断今天是否可签到（whj）
    private func judgeTodayWhetherCanSignIn(_ signView: SignView?) {
        if signView == nil {
            return
        }
        
        // 签到按钮是否可点击
        let recentSignDateString = defaults.value(forKey: kRecentSignDateKey) as? String ?? ""
        let todayYMD = formatter.string(from: Date())
        signView!.sign.isEnabled = recentSignDateString != todayYMD
        
        // 彩虹币总值
        let rainbowCoin = defaults.value(forKey: kRainbowCoinValueKey) as? Int ?? 0
        signView!.coinNumber.text = "\(rainbowCoin)"
        
        // 判断是否连续，如果不连续则清0
        // 连续签到天数
        var days = defaults.value(forKey: kContinuitySignDaysKey) as? Int ?? 0
        if days >= 30 {
            days = 0
            defaults.setValue(days, forKey: kContinuitySignDaysKey)
            signView!.dayNumber = days
        } else {
            // 判断 最近签到日期 是否 是大于昨天
            let recentSignDate = formatter.date(from: recentSignDateString) ?? Date()
            let isYesterday = Calendar.current.isDateInYesterday(recentSignDate)
            let isToday = Calendar.current.isDateInToday(recentSignDate)
            if isToday == false && isYesterday == false { // 非今天、非昨天
                days = 0
                defaults.setValue(days, forKey: kContinuitySignDaysKey)
            }
            signView!.dayNumber = days
        }
    }
    
    fileprivate lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter
    }()
    

    /**
     热门资讯
     */
    @objc fileprivate func viewForHeaderInSectionClicked() {
        let view = TotalArticlesController()
        navigationController?.pushViewController(view, animated: true)
    }
    

    
}

extension HomePageController: UITableViewDataSource, UITableViewDelegate {
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
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let vwH: CGFloat = 44
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: vwH))
        vw.backgroundColor = UIColor.white
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomePageController.viewForHeaderInSectionClicked))
        vw.addGestureRecognizer(tap)
        
        let margin: CGFloat = 15
        let ttl = UILabel(frame: CGRect(x: margin, y: 0, width: 200, height: vwH))
        ttl.text = kMostPopular
        ttl.font = font13
        ttl.textColor = rgb102
        vw.addSubview(ttl)
        
        let arrowW: CGFloat = 9
        let arrowH: CGFloat = 15
        let arrowX: CGFloat = kScreenWidth - 15 - arrowW
        let arrowY: CGFloat = (vwH - arrowH)/2
        let arrow = UIImageView(frame: CGRect(x: arrowX, y: arrowY, width: arrowW, height: arrowH))
        arrow.image = UIImage(named: "HomeViewControllerArrow")
        vw.addSubview(arrow)
        
        return vw
    }
}






extension HomePageController: SignViewDelegate {

    func gotoSignWithSignButton(_ signView: SignView, signButton: UIButton) {
        
        signButton.isEnabled = false
        
        // 连续签到天数
        var days = defaults.value(forKey: kContinuitySignDaysKey) as? Int ?? 0
        days = days > 30 ? 0 : days
        // 判断 最近签到日期 是否 是昨天
        let recentSignString = defaults.value(forKey: kRecentSignDateKey) as? String ?? ""
        let recentSignDate = formatter.date(from: recentSignString) ?? Date()
        let isYesterday = Calendar.current.isDateInYesterday(recentSignDate)
        days = isYesterday ? (days + 1) : 1
        signView.dayNumber = days
        defaults.setValue(days, forKey: kContinuitySignDaysKey)
        
        // 保存最近签到日期（今天日期）
        let todayYMD = formatter.string(from: Date())
        defaults.setValue(todayYMD, forKey: kRecentSignDateKey)
        
        // 改变彩虹币数值
        var rainbowCoin = defaults.value(forKey: kRainbowCoinValueKey) as? Int ?? 0
        rainbowCoin += signView.rainbowCoinValue
        signView.coinNumber.text = "\(rainbowCoin)"
        defaults.setValue(rainbowCoin, forKey: kRainbowCoinValueKey)
        
        // 获得彩虹币数组
        var coinsArray = defaults.value(forKey: kRainbowCoinsArrayKey) as? [String] ?? [String]()
        coinsArray.append("\(signView.rainbowCoinValue)")
        defaults.set(coinsArray, forKey: kRainbowCoinsArrayKey)
        
        // 对应的时间
        var timesArray = defaults.value(forKey: kGetRainbowCoinsTimeArrayKey) as? [String] ?? [String]()
        
        let fr = DateFormatter()
        fr.dateFormat = "yyyy-MM-dd HH:mm:ss"
        fr.locale = Locale(identifier: "zh_CN")
        let dataString = fr.string(from: Date())
        timesArray.append(dataString)
        
        defaults.set(timesArray, forKey: kGetRainbowCoinsTimeArrayKey)
    }
}






extension HomePageController: HomeCarouselViewDelegate {
   
    func carouselViewCellClicked(_ index: Int) {
        
        let vc = ActivityDetailsController()
//        vc.urlString = ""
        navigationController?.pushViewController(vc, animated: true)

//        let view = CHWebViewController()
//        let arl = activityArray[index]
//        view.loadURL = arl.url ?? ""
//        let url = CHGetPicUrl + (arl.imageId?.stringValue)! + "/photo.jpg"
//        view.imageURL = url
//        navigationController?.pushViewController(view, animated: true)
    }
}
