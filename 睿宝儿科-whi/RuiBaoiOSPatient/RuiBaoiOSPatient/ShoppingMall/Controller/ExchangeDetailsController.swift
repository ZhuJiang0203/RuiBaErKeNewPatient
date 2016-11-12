//
//  ExchangeDetailsController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/7.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  兑换详情

import UIKit

class ExchangeDetailsController: BaseViewController {

    var model: ExchangeRecord?
    
    fileprivate var mainScrollView: UIScrollView?
    fileprivate var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "兑换详情"
        view.backgroundColor = rgb244
        
        // 创建mainScrollView
        setupMainScrollView()
        
        // 创建topView
        setupTopView()
        
        // 创建shopView
        setupShopView()
        
        // 创建phoneView
        setupPhoneView()
    }
    
    // MARK:- 创建mainScrollView
    fileprivate func setupMainScrollView() {
        mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64 - 44))
        mainScrollView!.showsVerticalScrollIndicator = false
        mainScrollView!.alwaysBounceVertical = true
        mainScrollView!.backgroundColor = rgb244
        view.addSubview(mainScrollView!)
    }
    
    // MARK:- 创建topView
    fileprivate func setupTopView() {
        let top = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        top.backgroundColor = rgbColor(86, g: 93, b: 99)
        mainScrollView!.addSubview(top)
        
        let car = UIImageView()
        car.image = UIImage(named: "ExchangeDetailsControllerCar")
        car.sizeToFit()
        car.frame.origin = CGPoint(x: 10, y: 18)
        top.addSubview(car)
        
        let styleX: CGFloat = car.frame.maxX + 10
        let styleW: CGFloat = kScreenWidth - styleX - 10
        let style = UILabel(frame: CGRect(x: styleX, y: 15, width: styleW, height: 20))
        style.text = "配送方式：\(model?.shippingStyle ?? "")"
        style.textColor = UIColor.white
        style.font = font14
        top.addSubview(style)
        
        let name = UILabel(frame: CGRect(x: styleX, y: style.frame.maxY + 5, width: styleW, height: 20))
        name.text = "收货人：\(model?.receiver ?? "")"
        name.textColor = UIColor.white
        name.font = font14
        top.addSubview(name)
        
        let address = UILabel(frame: CGRect(x: styleX, y: name.frame.maxY + 5, width: styleW, height: 20))
        address.text = "地址：\(model?.address ?? "")"
        address.textColor = UIColor.white
        address.font = font14
        top.addSubview(address)
    }
    
    // MARK:- 创建shopView
    fileprivate func setupShopView() {
        let shopView = UIView(frame: CGRect(x: 0, y: 110, width: kScreenWidth, height: 180))
        shopView.backgroundColor = UIColor.white
        mainScrollView!.addSubview(shopView)
        
        let icon = UIImageView(frame: CGRect(x: 15, y: 23, width: 90, height: 90))
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.layer.borderColor = rgbSameColor(224).cgColor
        icon.layer.borderWidth = 0.5
        icon.sd_setImage(with: URL(string: model?.shopIcon ?? ""), placeholderImage: UIImage(named: model?.shopIconPlachoder ?? ""))
        shopView.addSubview(icon)
        
        let nameX: CGFloat = icon.frame.maxX + 10
        let nameW: CGFloat = kScreenWidth - 10 - nameX
        let name = UILabel(frame: CGRect(x: nameX, y: 21, width: nameW, height: 21))
        name.textColor = rgbSameColor(76)
        name.font = font15
        name.text = model?.shopName ?? ""
        shopView.addSubview(name)
        
        let price = UILabel(frame: CGRect(x: nameX, y: name.frame.maxY + 12, width: 200, height: 28))
        price.textColor = rgbSameColor(76)
        price.font = font12

        let ptxt = "\(model?.shopPrice ?? "") \(kRainbowCoin)"
        let mutableString = NSMutableAttributedString(string: ptxt)
        mutableString.addAttributes([NSForegroundColorAttributeName : rgbColor(253, g: 119, b: 142)], range: NSMakeRange(0, ptxt.characters.count - 4))
        mutableString.addAttributes([NSForegroundColorAttributeName : rgbSameColor(153)], range: NSMakeRange(ptxt.characters.count - 4, 4))
        mutableString.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 20)], range: NSMakeRange(0, ptxt.characters.count - 4))
        mutableString.addAttributes([NSFontAttributeName : font12], range: NSMakeRange(ptxt.characters.count - 4, 4))
        price.attributedText = mutableString

        shopView.addSubview(price)
        
        let timeY: CGFloat = price.frame.maxY + 13
        let time = UILabel(frame: CGRect(x: nameX, y: timeY, width: 200, height: 20))
        time.textColor = rgbSameColor(153)
        time.font = font14
        time.text = model?.shopTime ?? ""
        shopView.addSubview(time)
        
        let numberW: CGFloat = 100
        let numberX: CGFloat = kScreenWidth - 10 - numberW
        let number = UILabel(frame: CGRect(x: numberX, y: timeY, width: numberW, height: 20))
        number.textColor = rgbSameColor(102)
        number.font = font13
        number.textAlignment = .right
        number.text = "x\(model?.shopNumber ?? "")"
        shopView.addSubview(number)
        
        let line = UIView(frame: CGRect(x: 0, y: 132, width: kScreenWidth, height: 0.5))
        line.backgroundColor = rgbSameColor(235)
        shopView.addSubview(line)
        
        let totalKeyY: CGFloat = 134
        let totalKeyH: CGFloat = 44
        let totalKey = UILabel(frame: CGRect(x: 10, y: totalKeyY, width: 200, height: totalKeyH))
        totalKey.textColor = rgbSameColor(50)
        totalKey.font = font14
        totalKey.text = "商品总价："
        shopView.addSubview(totalKey)
        
        let totalValueW: CGFloat = 200
        let totalValueX: CGFloat = kScreenWidth - 10 - totalValueW
        let totalValue = UILabel(frame: CGRect(x: totalValueX, y: totalKeyY, width: totalValueW, height: totalKeyH))
        totalValue.textColor = rgbSameColor(50)
        totalValue.font = font14
        totalValue.textAlignment = .right
        
        var totalInt = 0
        if model != nil {
            totalInt = Int(model!.shopPrice) ?? 0
            let number = Int(model!.shopNumber) ?? 0
            totalInt *= number
        }
        let total = "\(totalInt) \(kRainbowCoin)"
        let mutableTotal = NSMutableAttributedString(string: total)
        mutableTotal.addAttributes([NSForegroundColorAttributeName : rgbColor(253, g: 119, b: 142)], range: NSMakeRange(0, total.characters.count - 4))
        mutableTotal.addAttributes([NSForegroundColorAttributeName : rgbSameColor(153)], range: NSMakeRange(total.characters.count - 4, 4))
        mutableTotal.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 20)], range: NSMakeRange(0, total.characters.count - 4))
        mutableTotal.addAttributes([NSFontAttributeName : font12], range: NSMakeRange(total.characters.count - 4, 4))
        totalValue.attributedText = mutableTotal
        
        shopView.addSubview(totalValue)
    }

    // MARK:- 创建phoneView
    fileprivate func setupPhoneView() {
        let phoneH: CGFloat = 44
        let phoneView = UIView(frame: CGRect(x: 0, y: kScreenHeight - phoneH, width: kScreenWidth, height: phoneH))
        phoneView.backgroundColor = UIColor.white
        view.addSubview(phoneView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ExchangeDetailsController.phoneViewClicked))
        phoneView.addGestureRecognizer(tap)
        
        let imgWH: CGFloat = 15
        let ttlW: CGFloat = 60
        let ttlH: CGFloat = 18
        let imgX: CGFloat = (kScreenWidth - imgWH - ttlW)/2
        let imgY: CGFloat = (phoneH - imgWH)/2
        let img = UIImageView(frame: CGRect(x: imgX, y: imgY, width: imgWH, height: imgWH))
        img.image = UIImage(named: "ExchangeDetailsControllerPhone")
        phoneView.addSubview(img)
        
        let ttlX: CGFloat = img.frame.maxX
        let ttlY: CGFloat = (phoneH - ttlH)/2
        let ttl = UILabel(frame: CGRect(x: ttlX, y: ttlY, width: ttlW, height: ttlH))
        ttl.text = "联系客服"
        ttl.textColor = rgbSameColor(76)
        ttl.font = font13
        ttl.textAlignment = .center
        phoneView.addSubview(ttl)
    }
    
    @objc fileprivate func phoneViewClicked() {
        if webView == nil {
            webView = UIWebView(frame: CGRect.zero)
            webView!.delegate = self
        }
        webView!.loadRequest(URLRequest(url: URL(string: "tel://021-64669699")!))
    }
}

extension ExchangeDetailsController: UIWebViewDelegate {

}
