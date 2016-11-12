//
//  ActivityDetailsController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/8.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  活动详情

import UIKit
import MBProgressHUD

class ActivityDetailsController: BaseViewController {

    var urlString = "http://www.baidu.com"
    var webView: UIWebView!
    var share: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = kEventDetails
        
        // 创建分享按钮
        setupShareButton()
        
        // 创建webView模块
        setupWebView()
    }
    
    // MARK:- 创建分享按钮
    private func setupShareButton() {
        let shareWH: CGFloat = 44
        let shareX: CGFloat = kScreenWidth - 50
        share = UIButton(frame: CGRect(x: shareX, y: 0, width: shareWH, height: shareWH))
        share!.setImage(UIImage(named: "ArticleShareButtonIcon"), for: .normal)
        share!.contentHorizontalAlignment = .right
        share!.addTarget(self, action: #selector(ActivityDetailsController.shareButtonClicked), for: .touchUpInside)
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: share!)
    }

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
        tts.append(kMicroBlog)
        let shareView = CustomShareView.shareShareView(tts)
        shareView.delegate = self
    }
    

    // MARK:- 创建webView模块
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

extension ActivityDetailsController: UIWebViewDelegate {
   
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
extension ActivityDetailsController: CustomShareViewDelegate {
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

