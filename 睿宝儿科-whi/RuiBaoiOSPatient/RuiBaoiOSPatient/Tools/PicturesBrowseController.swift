
//
//  PhotoBrowseController.swift
//  XLWBSwift20160314
//
//  Created by whj on 16/4/5.
//  Copyright © 2016年 mifengyiliao. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

private let kPicturesCollectionCell = "PicturesCollectionCell"
var titleLabel: UILabel?
var controller: PicturesBrowseController?

class PicturesBrowseController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CustomAlertViewDelegate {
    
    var indexNumber: Int = 0
    var picturesString: [String]
    
    init(pictures: [String], index: Int) {
        picturesString = pictures
        indexNumber = index
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var collectionVw: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = self
        
        // 1. 创建collectionView
        collectionVw = creatGoodsCollectionView()
        view.addSubview(collectionVw!)
        
        
        // 2. 创建*/*
        LLog(picturesString)
        if picturesString.count > 0 {
            view.addSubview(tipLabel)
            tipLabel.text = "\(indexNumber + 1)" + "/" + "\(picturesString.count)"
        }
        
        // 3. 创建右上角按钮
        view.addSubview(rightBtn)
        
        // 4. 确定初始位置
        if indexNumber > 0 {
            collectionVw!.setContentOffset(CGPoint(x: kScreenWidth*CGFloat(indexNumber), y: 0), animated: false)
        }
    }
    
    // MARK: - 创建右上角按钮
    fileprivate lazy var rightBtn: UIButton = {
        let rightBtn = UIButton()
        let btnWH: CGFloat = 44
        let margin: CGFloat = 16
        let btnX: CGFloat = kScreenWidth - margin - btnWH
        rightBtn.frame = CGRect(x: btnX, y: 20, width: btnWH, height: btnWH)
        rightBtn.setImage(UIImage(named: "seekBigPictureRightItem"), for: .normal)
        rightBtn.addTarget(self, action: #selector(PicturesBrowseController.rightButtonClicked), for: .touchUpInside)
        return rightBtn
    }()

    var alertView: CustomAlertView?
    func rightButtonClicked() {
        if alertView == nil {
            alertView = CustomAlertView(titls: [kSavePicture, kCancle])
            UIApplication.shared.keyWindow?.addSubview(alertView!)
            alertView!.delegate = self
        }
    }
    
    // MARK: - CustomAlertViewDelegate
    func someButtonOfCustomAlertViewClicked(_ tagNumber: Int) {
        switch tagNumber {
        case 0: // 保存图片
            saveBtnClick()
        default:
            LLog(tagNumber)
        }
    }
    
    // MARK: - 保存图片
    func saveBtnClick() {
        // 1.获取当前显示图片的索引, 注意不能使用传入的索引, 因为用户可能已经滚动过了
        let indexPath = collectionVw!.indexPathsForVisibleItems.last!
        // 2.获取当前显示图片索引对应的cell, 然后从cell中取出图片
        let cell = collectionVw!.cellForItem(at: indexPath) as! PicturesCollestionCell
        // 3. ❤️❤️❤️ 保存图片 ❤️❤️❤️
        if let image = cell.imgVw.image {
            /*
            第一个参数: 需要保存的图片
            第二个参数: 谁类监听是否保存成功
            第三个参数: 哪个方法来监听是否保存成功
            第四个参数: 给回调方法传递的参数
            - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
            */
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(PicturesBrowseController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    // MARK: - 保存图片
    //                    ❤️❤️    ❤️❤️
    //                  ❤️❤️❤️❤️❤️❤️❤️❤️
    //                 ❤️❤️❤️❤️❤️❤️❤️❤️❤️
    //                  ❤️❤️❤️❤️❤️❤️❤️❤️
    //                    ❤️❤️❤️❤️❤️❤️
    //                      ❤️❤️❤️❤️
    //                        ❤️❤️
    func image(_ image: UIImage, didFinishSavingWithError error:NSError?, contextInfo: AnyObject) {
        if error != nil {
            SVProgressHUD.showError(withStatus: kSavePictureFiled)
        } else {
            SVProgressHUD.showSuccess(withStatus: kSavePictureSuccess)
        }
    }
    
    func customAlertViewSignOut() {
        alertView = nil
    }
    
    // MARK: - 创建*/*
    fileprivate lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.boldSystemFont(ofSize: 20)
        tipLabel.frame = CGRect(x: (kScreenWidth - 100)/2, y: 27, width: 100, height: 30)
        tipLabel.textAlignment = .center
        tipLabel.backgroundColor = rgbaSameColor(0, a: 0.3)
        tipLabel.layer.cornerRadius = kRadius
        tipLabel.clipsToBounds = true
        titleLabel = tipLabel
        return tipLabel
    }()
    
    // MARK: - 创建collectionView
    fileprivate func creatGoodsCollectionView() -> UICollectionView {
        // 1. 创建UICollectionViewFlowLayout
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // 1.1 滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        // 1.2 行间距、列间距
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        // 1.3 item的大小
        let itemW: CGFloat = kScreenWidth
        let itemH: CGFloat = kScreenHeight
        flowLayout.itemSize = CGSize(width: itemW, height: itemH)
        
        // 2. 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.black
        // 2.1 滚动范围
        collectionView.contentSize = CGSize(width: kScreenWidth*CGFloat(picturesString.count), height: kScreenHeight)
        // 2.2 设置数据源、代理
        collectionView.dataSource = self
        collectionView.delegate = self
        // 2.3 不显示滚动条
        collectionView.showsHorizontalScrollIndicator = false
        // 2.4 分页
        collectionView.isPagingEnabled = true
        // 2.5 注册UICollectionViewCell
        collectionView.register(PicturesCollestionCell.self, forCellWithReuseIdentifier: kPicturesCollectionCell)
        return collectionView
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPicturesCollectionCell, for: indexPath) as! PicturesCollestionCell
        
        cell.picture = picturesString[indexPath.item]
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 分子
        let molecule: Int = Int((scrollView.contentOffset.x + kScreenWidth/2)/kScreenWidth) + 1
        titleLabel?.text = "\(molecule)" + "/" + "\(picturesString.count)"
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

class PicturesCollestionCell: UICollectionViewCell, UIScrollViewDelegate {
    
    var picture: String? {
        didSet{
            LLog(picture)
            
            // 1. cell重用，重置cell所有属性
            resetScrollViewAllAttribute()
            
            
            // 2. 设置图片
            imgVw.sd_setImage(with: URL(string: picture!)) { (image, error, _, _) -> Void in
                // 2.1 调整图片的frame
                self.setupImagePostion()
                
                // 2.2 加载完毕，移除进度条
                self.progressVw.progress = 1.0
            }
            
//            SDWebImageManager.sharedManager().downloadImageWithURL(NSURL(string: picture!), options: SDWebImageOptions.RetryFailed, progress: { (current, total) -> Void in
//                // 回到主线程, 设置进度, 更新UI
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    let progress = CGFloat(current)/CGFloat(total)
//                    LLog(progress)
//                })
//                
//                }, completed: { (_, error, _, _, _) -> Void in
//                    LLog(error)
//            })

        }
    }
    
    /// cell重用，重置cell所有属性
    fileprivate func resetScrollViewAllAttribute() {
        imgVw.transform = CGAffineTransform.identity
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.contentOffset = CGPoint.zero
        scrollView.contentSize = CGSize.zero
    }
    
    /// 调整图片的frame
    fileprivate func setupImagePostion() {
        // 0.安全校验
        guard let _ = imgVw.image else {
            return
        }
         
        // 1. 拿到图片宽高比
        let s = imgVw.image!.size.height/imgVw.image!.size.width
        // 2. 按照图片的宽高比缩放图片, 保证能够显示整张图片
        let height = s*kScreenWidth
        imgVw.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: kScreenWidth, height: height))
        // 3. 判断当前是长图还是短图
        if height > kScreenHeight { // 长图
            scrollView.contentSize = imgVw.bounds.size
        } else { // 短图
            /*********** 调整contentInset，使得imgVw位于scrollView的中心位置 ***********/
            /*********** ！！！重点去理解！！！ **********/
            let y = (kScreenHeight - height)*0.5
            scrollView.contentInset = UIEdgeInsetsMake(y, 0, 0, y)
        }
        imgVw.center = CGPoint(x: kScreenWidth/2, y: height/2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 添加图片
        contentView.addSubview(scrollView)
        scrollView.addSubview(imgVw)
        contentView.addSubview(progressVw)
        
        scrollView.frame = bounds
        progressVw.frame.size = CGSize(width: 50, height: 50)
        progressVw.frame.origin = CGPoint(x: kScreenWidth/2, y: kScreenHeight/2)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PicturesCollestionCell.signOut))
        addGestureRecognizer(tap)
        
        let longPress = UILongPressGestureRecognizer(target: controller, action: #selector(PicturesBrowseController.rightButtonClicked))
        addGestureRecognizer(longPress)

        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PicturesCollestionCell.updateProgress), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func updateProgress() {
        progressVw.progress += 0.02
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3.0
        scrollView.minimumZoomScale = 0.5
        return scrollView
    }()
    
    func signOut() {
        controller?.dismiss(animated: true, completion: nil)
    }

    fileprivate lazy var imgVw: UIImageView = {
        let imgVw = UIImageView()
        return imgVw
    }()
    
    fileprivate lazy var progressVw: ProgressView = {
        let progressVw = ProgressView()
        progressVw.backgroundColor = UIColor.clear
        return progressVw
    }()
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgVw
    }
    
    // 该方法传入的view就是被缩放的view
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        // 注意: scrollview缩放内部的实现原理其实是利用transform实现的,
        // 如果是利用transform缩放控件, 那么bounds不会改变, 只有frame会改变
        // 重新调整图片的位置
        var offsetY = (kScreenHeight - view!.frame.height)*0.5
        var offsetX = (kScreenWidth - view!.frame.width)*0.5
        // 注意: 如果offsetX、offsetY是负数, 重置scrollView的contentInset为(0, 0, 0, 0)
        offsetY = offsetY < 0 ? 0 : offsetY
        offsetX = offsetX < 0 ? 0 : offsetX
        scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, offsetY, offsetX)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // 注意: scrollview缩放内部的实现原理其实是利用transform实现的,
        // 如果是利用transform缩放控件, 那么bounds不会改变, 只有frame会改变
        // 重新调整图片的位置
        var offsetY = (kScreenHeight - imgVw.frame.height)*0.5
        var offsetX = (kScreenWidth - imgVw.frame.width)*0.5
        // 注意: 如果offsetX、offsetY是负数, 重置scrollView的contentInset为(0, 0, 0, 0)
        offsetY = offsetY < 0 ? 0 : offsetY
        offsetX = offsetX < 0 ? 0 : offsetX
        scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, offsetY, offsetX)
    }
}
