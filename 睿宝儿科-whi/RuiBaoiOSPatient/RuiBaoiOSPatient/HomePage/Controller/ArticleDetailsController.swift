//
//  ArticleDetailsController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  文章详情

import UIKit
import MBProgressHUD

class ArticleDetailsController: BaseViewController {

    var urlString = "http://www.baidu.com"
    private var share: UIButton?
    private var collect: UIButton?
    private var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = kArticleDetail
        
        // 创建分享、收藏 按钮
        setupShareCollectButton()

        
        // 创建webView模块
        setupWebView()
    }
    
    // 创建分享、收藏 按钮
    private func setupShareCollectButton() {
        
        let btnW: CGFloat = 30
        let btnH: CGFloat = 44
        let right = UIView(frame: CGRect(x: 0, y: 0, width: btnW*2, height: btnH))
        
        collect = UIButton(frame: CGRect(x: 0, y: 0, width: btnW, height: btnH))
        collect!.setImage(UIImage(named: "CollectionIconWhite"), for: .normal)
        collect!.setImage(UIImage(named: "CollectionIconBlack"), for: .selected)
        collect!.contentHorizontalAlignment = .right
        collect!.addTarget(self, action: #selector(ArticleDetailsController.collectButtonClicked), for: .touchUpInside)
        right.addSubview(collect!)
        
        share = UIButton(frame: CGRect(x: btnW, y: 0, width: btnW, height: btnH))
        share!.setImage(UIImage(named: "ArticleShareButtonIcon"), for: .normal)
        share!.contentHorizontalAlignment = .right
        share!.addTarget(self, action: #selector(ArticleDetailsController.shareButtonClicked), for: .touchUpInside)
        right.addSubview(share!)
        
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: right)
    }

    /// 分享
    @objc private func shareButtonClicked() {
        var tts = [kCopyLink]

        if WXApi.isWXAppInstalled() == true {
            tts.append(kCircleOfFriends)
            tts.append(kWeChat)
        }
        if QQApiInterface.isQQInstalled() == true {
            tts.append("QQ")
            tts.append(kQQZone)
        }
        if WeiboSDK.isWeiboAppInstalled() {
            tts.append(kMicroBlog)
        }
        let shareView = CustomShareView.shareShareView(tts)
        shareView.delegate = self
    }

    /// 收藏、取消收藏
    @objc private func collectButtonClicked() {
    
    }
    
    private func setupWebView() {
        webView = UIWebView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        webView.backgroundColor = rgb244
        webView.delegate = self
        webView.scalesPageToFit = true
        let request = URLRequest(url: URL(string: urlString)!)
        LLog(request)
        webView.loadRequest(request)
        view.addSubview(webView)
        
        MBProgressHUD.showAdded(to: view, animated: true)
    }
}

extension ArticleDetailsController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // 停止提示
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        // 停止提示
        MBProgressHUD.hide(for: view, animated: true)
        CustomMBProgressHUD.showFailed(nil, view: view)
    }
}

// MARK:- CustomShareViewDelegate
extension ArticleDetailsController: CustomShareViewDelegate {
    func oneButtonClicked(_ btn: ShareButton, shareView: CustomShareView) {
        print(btn.tag)
        
        let title = "文章详情"
        let url = "https://www.baidu.com"
        let content = "文章具体内容："
        let img = UIImage(named: "appIconPicture")!

        
        if btn.tag == 0 {
            let pasteboard = UIPasteboard.general
            pasteboard.string = url
            CustomMBProgressHUD.showSuccess(kLinkHasBeenCopied, view: view)
        } else {
            CustomUMFile.setupCustomUMFile(withCurrentVC: self, title: title, content: content, img: img, url: url, toType: "\(btn.tag)")
        }
        shareView.removeFromSuperview()
    }
    
    func cancleButtonClicked(_ shareView: CustomShareView) {
        shareView.removeFromSuperview()
    }
}


