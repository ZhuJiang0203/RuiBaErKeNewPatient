//
//  CusTomWebViewController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/4.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  H5界面

import UIKit
import MBProgressHUD

class CusTomWebViewController: BaseViewController {
    
    var urlString: String?
    var isModal = false // 是否是modal控制器
    var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isModal {
            setUpNavigationBar()
        }
        
        webView = UIWebView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        webView.backgroundColor = rgb244
        webView.delegate = self
        webView.scalesPageToFit = true
        let request = URLRequest(url: URL(string: urlString!)!)
        LLog(request)
        webView.loadRequest(request)
        view.addSubview(webView)
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    fileprivate func setUpNavigationBar() {
        customNavigationItem.leftBarButtonItem = UIBarButtonItem(title: kCancle, style: UIBarButtonItemStyle.plain, target: self, action: #selector(CusTomWebViewController.signOutCurrentController))
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(title: kOver, style: UIBarButtonItemStyle.plain, target: self, action: #selector(CusTomWebViewController.doOver))
    }
    
    func signOutCurrentController() {
        dismiss(animated: true, completion: nil)
    }
    
    func doOver() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CusTomWebViewController: UIWebViewDelegate {
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
