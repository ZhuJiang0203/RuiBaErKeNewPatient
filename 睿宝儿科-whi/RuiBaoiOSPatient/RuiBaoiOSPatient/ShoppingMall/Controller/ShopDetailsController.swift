//
//  ShopDetailsController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/2.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  商品详情-whj

import UIKit


class ShopDetailsController: BaseViewController {

    var good: Goods?
    
    fileprivate var mainScrollView: UIScrollView!
    
    /// 顶部模块
    fileprivate var iconView: UIImageView?
    fileprivate let iconViewH: CGFloat = (kScreenWidth/320.0)*130
    /// 中间模块
    fileprivate var centerView: UIView?
    /// 底部模块
    fileprivate var bottomView: UIView?
    
    /// 商品简介模块
    fileprivate var productProfile: UIView?
    /// 使用范围
    fileprivate var applyScope: UIView?
    /// 使用有效期
    fileprivate var validityPeriod: UIView?
    /// 兑换流程
    fileprivate var exchangeProcess: UIView?
    /// 注意事项
    fileprivate var mattersNeedingAttention: UIView?
    /// 客服电话
    fileprivate var serviceTelephone: UIView?
    /// 商家简介
    fileprivate var businessProfile: UIView?

    fileprivate var webView: UIWebView?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "商品详情"
        
        // mainScrollView
        setupMainScrollView()
        
        // 顶部
        setupTopView()
        
        // 中间
        setupCenterView()
        
        // 底部
        setupBottomView()
    }
    
    // MARK:- mainScrollView
    fileprivate func setupMainScrollView() {
        mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        mainScrollView.alwaysBounceVertical = true
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.backgroundColor = rgb244
        mainScrollView.delegate = self
        view.addSubview(mainScrollView)
    }
    
    // MARK:- 顶部
    fileprivate func setupTopView() {
        iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: iconViewH))
        let iconString = good?.goodsImageString ?? ""
        iconView!.sd_setImage(with: URL(string: iconString), placeholderImage: UIImage(named: "RuiBaoPlacehoderIcon"))
        iconView!.contentMode = .scaleAspectFill
        iconView!.clipsToBounds = true
        iconView!.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ShopDetailsController.iconViewClicked))
        iconView!.addGestureRecognizer(tap)
        mainScrollView.addSubview(iconView!)
    }
    
    
    // MARK: - 转场动画
    lazy var animator: PopoverAnimator = {
        let animator = PopoverAnimator.init(presentedViewController: self, presenting: nil)
        return animator
    }()
    
    @objc fileprivate func iconViewClicked() {
        let iconString = good?.goodsImageString ?? ""
        let pictures = [iconString]
        let vc = PicturesBrowseController(pictures: pictures, index: 0)
        vc.transitioningDelegate = animator
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }

    // MARK:- 中间
    fileprivate func setupCenterView() {
        centerView = UIView(frame: CGRect(x: 0, y: iconView!.frame.maxY + 10, width: kScreenWidth, height: 72))
        centerView!.backgroundColor = UIColor.white
        mainScrollView.addSubview(centerView!)
        
        let ttl = UILabel(frame: CGRect(x: 10, y: 12, width: 200, height: 22))
        ttl.font = UIFont.boldSystemFont(ofSize: 16)
        ttl.textColor = rgbSameColor(76)
        ttl.text = good?.goodsName ?? ""
        centerView!.addSubview(ttl)
        
        let caihongbi = UILabel(frame: CGRect(x: 10, y: ttl.frame.maxY, width: 200, height: 28))
        caihongbi.font = UIFont.boldSystemFont(ofSize: 16)
        caihongbi.textColor = rgbSameColor(76)
        let price = "\(good?.price ?? 0.0)"
        let caihongbiTxt = "\(price) \(kRainbowCoin)"
        let mutableString = NSMutableAttributedString(string: caihongbiTxt)
        mutableString.addAttributes([NSForegroundColorAttributeName : rgbColor(253, g: 119, b: 142)], range: NSMakeRange(0, caihongbiTxt.characters.count - 4))
        mutableString.addAttributes([NSForegroundColorAttributeName : rgbSameColor(153)], range: NSMakeRange(caihongbiTxt.characters.count - 4, 4))
        mutableString.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 20)], range: NSMakeRange(0, caihongbiTxt.characters.count - 4))
        mutableString.addAttributes([NSFontAttributeName : font12], range: NSMakeRange(caihongbiTxt.characters.count - 4, 4))
        caihongbi.attributedText = mutableString
        centerView!.addSubview(caihongbi)
        
        let duihuanW: CGFloat = 100
        let duihuanX = kScreenWidth - 10 - duihuanW
        let duihuan = UIButton(frame: CGRect(x: duihuanX, y: 14, width: 100, height: 40))
        duihuan.backgroundColor = rgbColor(253, g: 119, b: 142)
        duihuan.layer.cornerRadius = 2.5
        duihuan.clipsToBounds = true
        duihuan.setTitle("立即兑换", for: .normal)
        duihuan.setTitleColor(.white, for: .normal)
        duihuan.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        duihuan.addTarget(self, action: #selector(ShopDetailsController.goToExchange), for: .touchUpInside)
        centerView!.addSubview(duihuan)
    }
    
    // MARK:- 立即兑换
    @objc fileprivate func goToExchange() {
        let vc = ConfirmOrderController()
        vc.goodData = good
        vc.previousCtl = self
        vc.rainbowNumber = "3000"
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK:- 底部（商品简介、适用范围、使用有效期、兑换流程、注意事项、客服电话、商家简介、重要说明）
    fileprivate func setupBottomView() {

        bottomView = UIView(frame: CGRect(x: 0, y: centerView!.frame.maxY + 10, width: kScreenWidth, height: 1000))
        bottomView!.backgroundColor = UIColor.white
        mainScrollView.addSubview(bottomView!)
        
        // 商品简介
        setupProductProfile()
        
        // 适用范围
        setupScopeOfApply()
        
        // 使用有效期
        setupUseValidityPeriod()
        
        // 兑换流程
        setupExchangeProcess()
        
        // 注意事项
        setupMattersNeedingAttention()
        
        // 客服电话
        setupCustomerServiceTelephoneNumbers()
        
        // 商家简介
        setupBusinessProfile()
        
        // 重要说明
        setupImportantNote()
        
    }
    
    // MARK:- 商品简介
    fileprivate func setupProductProfile() {
       
        let productProfileX: CGFloat = kMargin
        let productProfileW = kScreenWidth - 2*productProfileX
        productProfile = UIView(frame: CGRect(x: productProfileX, y: 14, width: productProfileW, height: 100))
        bottomView!.addSubview(productProfile!)
        
        let key = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        key.text = "商品简介"
        key.textColor = rgb153
        key.font = font14
        productProfile!.addSubview(key)

        let line = UIView(frame: CGRect(x: 0, y: key.frame.maxY + 6, width: productProfileW, height: 0.5))
        line.backgroundColor = rgbSameColor(237)
        productProfile!.addSubview(line)

        let valueText = "商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介商品简介"
        let rowMargin: CGFloat = 6
        let valueH: CGFloat = valueText.calculateTheHeightOfTheString(font15, width: productProfileW, margin: rowMargin, maxRow: 0)
        let value = UILabel(frame: CGRect(x: 0, y: line.frame.maxY + 5, width: productProfileW, height: valueH))

        // 行间距
        let attributedString = NSMutableAttributedString(string: valueText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = rowMargin
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        value.attributedText = attributedString

        value.textColor = rgbSameColor(76)
        value.font = font15
        value.numberOfLines = 0
        productProfile!.addSubview(value)
        
        // 商品简介模块的最终高度
        productProfile!.frame.size.height = value.frame.maxY
    }
    
    // MARK:- 使用范围
    fileprivate func setupScopeOfApply() {
       
        let applyScopeX: CGFloat = kMargin
        let applyScopeW = kScreenWidth - 2*applyScopeX
        applyScope = UIView(frame: CGRect(x: applyScopeX, y: productProfile!.frame.maxY + 30, width: applyScopeW, height: 100))
        bottomView!.addSubview(applyScope!)
        
        let key = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        key.text = "使用范围"
        key.textColor = rgb153
        key.font = font14
        applyScope!.addSubview(key)
        
        let line = UIView(frame: CGRect(x: 0, y: key.frame.maxY + 6, width: applyScopeW, height: 0.5))
        line.backgroundColor = rgbSameColor(237)
        applyScope!.addSubview(line)
        
        let valueText = "全国"
        let rowMargin: CGFloat = 6
        let valueH: CGFloat = valueText.calculateTheHeightOfTheString(font15, width: applyScopeW, margin: rowMargin, maxRow: 0)
        let value = UILabel(frame: CGRect(x: 0, y: line.frame.maxY + 5, width: applyScopeW, height: valueH))

        // 行间距
        let attributedString = NSMutableAttributedString(string: valueText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = rowMargin
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        value.attributedText = attributedString

        value.textColor = rgbSameColor(76)
        value.font = font15
        value.numberOfLines = 0
        applyScope!.addSubview(value)
        
        // 商品简介模块的最终高度
        applyScope!.frame.size.height = value.frame.maxY
    }
    
    // MARK:- 使用有效期
    fileprivate func setupUseValidityPeriod() {
    
        let validityPeriodX: CGFloat = kMargin
        let validityPeriodW = kScreenWidth - 2*validityPeriodX
        validityPeriod = UIView(frame: CGRect(x: validityPeriodX, y: applyScope!.frame.maxY + 30, width: validityPeriodW, height: 100))
        bottomView!.addSubview(validityPeriod!)
        
        let key = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        key.text = "使用有效期"
        key.textColor = rgb153
        key.font = font14
        validityPeriod!.addSubview(key)
        
        let line = UIView(frame: CGRect(x: 0, y: key.frame.maxY + 6, width: validityPeriodW, height: 0.5))
        line.backgroundColor = rgbSameColor(237)
        validityPeriod!.addSubview(line)
        
        let valueText = "兑换日期截止到2016年06月30日"
        let rowMargin: CGFloat = 6
        let valueH: CGFloat = valueText.calculateTheHeightOfTheString(font15, width: validityPeriodW, margin: rowMargin, maxRow: 0)
        let value = UILabel(frame: CGRect(x: 0, y: line.frame.maxY + 5, width: validityPeriodW, height: valueH))

        // 行间距
        let attributedString = NSMutableAttributedString(string: valueText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = rowMargin
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        value.attributedText = attributedString

        value.textColor = rgbSameColor(76)
        value.font = font15
        value.numberOfLines = 0
        validityPeriod!.addSubview(value)
        
        // 商品简介模块的最终高度
        validityPeriod!.frame.size.height = value.frame.maxY
    }

    // MARK:- 兑换流程
    fileprivate func setupExchangeProcess() {
        
        let exchangeProcessX: CGFloat = kMargin
        let exchangeProcessW = kScreenWidth - 2*exchangeProcessX
        exchangeProcess = UIView(frame: CGRect(x: exchangeProcessX, y: validityPeriod!.frame.maxY + 30, width: exchangeProcessW, height: 100))
        bottomView!.addSubview(exchangeProcess!)
        
        let key = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        key.text = "兑换流程"
        key.textColor = rgb153
        key.font = font14
        exchangeProcess!.addSubview(key)
        
        let line = UIView(frame: CGRect(x: 0, y: key.frame.maxY + 6, width: exchangeProcessW, height: 0.5))
        line.backgroundColor = rgbSameColor(237)
        exchangeProcess!.addSubview(line)
        
        let valueText = "1、兑换后获得兑换码\n2、进入天猫医药馆http://www.baidu.com（这是兑换页面网址）\n3、点击【我要兑换】--【下一步】--【输入收货地址和兑换券】-- 支付邮费后即可免费领取商品\n4、描述运费，需在线支付邮费10元"
        let rowMargin: CGFloat = 6
        let valueH: CGFloat = valueText.calculateTheHeightOfTheString(font15, width: exchangeProcessW, margin: rowMargin, maxRow: 0)
        let value = UILabel(frame: CGRect(x: 0, y: line.frame.maxY + 5, width: exchangeProcessW, height: valueH))

        // 行间距
        let attributedString = NSMutableAttributedString(string: valueText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = rowMargin
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        value.attributedText = attributedString

        value.textColor = rgbSameColor(76)
        value.font = font15
        value.numberOfLines = 0
        exchangeProcess!.addSubview(value)
        
        // 商品简介模块的最终高度
        exchangeProcess!.frame.size.height = value.frame.maxY
    }

    // MARK:- 注意事项
    fileprivate func setupMattersNeedingAttention() {
        
        let mattersNeedingAttentionX: CGFloat = kMargin
        let mattersNeedingAttentionW = kScreenWidth - 2*mattersNeedingAttentionX
        mattersNeedingAttention = UIView(frame: CGRect(x: mattersNeedingAttentionX, y: exchangeProcess!.frame.maxY + 30, width: mattersNeedingAttentionW, height: 100))
        bottomView!.addSubview(mattersNeedingAttention!)
        
        let key = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        key.text = "注意事项"
        key.textColor = rgb153
        key.font = font14
        mattersNeedingAttention!.addSubview(key)
        
        let line = UIView(frame: CGRect(x: 0, y: key.frame.maxY + 6, width: mattersNeedingAttentionW, height: 0.5))
        line.backgroundColor = rgbSameColor(237)
        mattersNeedingAttention!.addSubview(line)
        
        let valueText = "1、每位用户仅限兑换一位（账号必须绑定手机号）\n每个订单只能使用一次"
        let rowMargin: CGFloat = 6
        let valueH: CGFloat = valueText.calculateTheHeightOfTheString(font15, width: mattersNeedingAttentionW, margin: rowMargin, maxRow: 0)
        let value = UILabel(frame: CGRect(x: 0, y: line.frame.maxY + 5, width: mattersNeedingAttentionW, height: valueH))

        // 行间距
        let attributedString = NSMutableAttributedString(string: valueText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = rowMargin
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        value.attributedText = attributedString

        value.textColor = rgbSameColor(76)
        value.font = font15
        value.numberOfLines = 0
        mattersNeedingAttention!.addSubview(value)
        
        // 商品简介模块的最终高度
        mattersNeedingAttention!.frame.size.height = value.frame.maxY
    }

    // MARK:- 客服电话
    fileprivate func setupCustomerServiceTelephoneNumbers() {
        
        let serviceTelephoneX: CGFloat = kMargin
        let serviceTelephoneW = kScreenWidth - 2*serviceTelephoneX
        serviceTelephone = UIView(frame: CGRect(x: serviceTelephoneX, y: mattersNeedingAttention!.frame.maxY + 30, width: serviceTelephoneW, height: 100))
        bottomView!.addSubview(serviceTelephone!)
        
        let key = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        key.text = "客服电话"
        key.textColor = rgb153
        key.font = font14
        serviceTelephone!.addSubview(key)
        
        let line = UIView(frame: CGRect(x: 0, y: key.frame.maxY + 6, width: serviceTelephoneW, height: 0.5))
        line.backgroundColor = rgbSameColor(237)
        serviceTelephone!.addSubview(line)
        
        let valueText = "010-55667788"
        let rowMargin: CGFloat = 6
        let valueH: CGFloat = valueText.calculateTheHeightOfTheString(font15, width: serviceTelephoneW, margin: rowMargin, maxRow: 0)
        let value = UILabel(frame: CGRect(x: 0, y: line.frame.maxY + 5, width: serviceTelephoneW, height: valueH))

        // 行间距
        let attributedString = NSMutableAttributedString(string: valueText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = rowMargin
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        value.attributedText = attributedString

        value.textColor = rgbSameColor(76)
        value.font = font15
        value.numberOfLines = 0
        
        value.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ShopDetailsController.phoneViewClicked))
        value.addGestureRecognizer(tap)

        serviceTelephone!.addSubview(value)
        
        // 商品简介模块的最终高度
        serviceTelephone!.frame.size.height = value.frame.maxY
    }
    
    @objc fileprivate func phoneViewClicked(_ phone: String? = "") {
        if webView == nil {
            webView = UIWebView(frame: CGRect.zero)
        }
        webView!.loadRequest(URLRequest(url: URL(string: "tel://\(phone)")!))
    }

    // MARK:- 商家简介
    fileprivate func setupBusinessProfile() {
        
        let businessProfileX: CGFloat = kMargin
        let businessProfileW = kScreenWidth - 2*businessProfileX
        businessProfile = UIView(frame: CGRect(x: businessProfileX, y: serviceTelephone!.frame.maxY + 30, width: businessProfileW, height: 100))
        bottomView!.addSubview(businessProfile!)
        
        let key = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        key.text = "商家简介"
        key.textColor = rgb153
        key.font = font14
        businessProfile!.addSubview(key)
        
        let line = UIView(frame: CGRect(x: 0, y: key.frame.maxY + 6, width: businessProfileW, height: 0.5))
        line.backgroundColor = rgbSameColor(237)
        businessProfile!.addSubview(line)
        
        let valueText = "这是一家质量绝对不让你失望的良心商家！放心购买吧。"
        let rowMargin: CGFloat = 6
        let valueH: CGFloat = valueText.calculateTheHeightOfTheString(font15, width: businessProfileW, margin: rowMargin, maxRow: 0)
        let value = UILabel(frame: CGRect(x: 0, y: line.frame.maxY + 5, width: businessProfileW, height: valueH))

        // 行间距
        let attributedString = NSMutableAttributedString(string: valueText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = rowMargin
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        value.attributedText = attributedString

        value.textColor = rgbSameColor(76)
        value.font = font15
        value.numberOfLines = 0
        businessProfile!.addSubview(value)
        
        // 商品简介模块的最终高度
        businessProfile!.frame.size.height = value.frame.maxY
    }

    // MARK:- 重要说明
    fileprivate func setupImportantNote() {
        
        let importantNoteX: CGFloat = kMargin
        let importantNoteW = kScreenWidth - 2*importantNoteX
        let importantNoteImageView = UIImageView(frame: CGRect(x: importantNoteX, y: businessProfile!.frame.maxY + 50, width: importantNoteW, height: 100))
        var imageString = "OKViewTip5"
        if kScreenWidth == 375 {
            imageString = "OKViewTip6"
        } else if kScreenWidth == 414 {
            imageString = "OKViewTip6p"
        }
        importantNoteImageView.image = UIImage(named: imageString)
        importantNoteImageView.sizeToFit()
        bottomView!.addSubview(importantNoteImageView)

        // 最终确定bottom的高度、
        bottomView!.frame.size.height = importantNoteImageView.frame.maxY + 50
        mainScrollView.contentSize = CGSize(width: kScreenWidth, height: bottomView!.frame.maxY)
    }
}



extension ShopDetailsController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 0 {
            return
        }
        
        iconView?.frame.origin.y = scrollView.contentOffset.y
        iconView?.frame.size.height = iconViewH - scrollView.contentOffset.y
    }
}
