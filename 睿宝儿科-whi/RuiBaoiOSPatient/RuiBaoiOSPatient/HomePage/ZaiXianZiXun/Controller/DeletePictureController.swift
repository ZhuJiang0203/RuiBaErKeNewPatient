//
//  DeletePictureController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/24.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  删除图片

import UIKit

class DeletePictureController: BaseViewController {
    
    weak var pictureConsultingController: PictureConsultingController!
    var currentIndex = 0

    private var scrollView: UIScrollView!
    private var imgs = [UIImage]()
    
    // 判断当前导航栏是否是 隐藏 状态
    private var isHidingNavBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgs = pictureConsultingController.pictures
        
        setNavigationBar()
        
        setupScrollView()
    }
    
    private func setNavigationBar() {
      
        title = "1/\(imgs.count)"
        
        setupRightBarButtonItem()
    }
    
    override func leftBackBarBttonItemClick() {
        pictureConsultingController.pictures = imgs
        _ = navigationController!.popViewController(animated: true)
    }

    /**
     rightBarButtonItem
     */
    private func setupRightBarButtonItem() {
        let delete = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        delete.setImage(UIImage(named: "Trash"), for: .normal)
        delete.contentHorizontalAlignment = .right
        delete.addTarget(self, action: #selector(DeletePictureController.isDeleteThePicture), for: .touchUpInside)
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: delete)
    }
    
    @objc private func isDeleteThePicture() {
        
        let alertController = UIAlertController(title: nil, message: kDeleteThisPicture, preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: kDelete, style: .destructive) { (action) in
            // 删除当前图片
            self.deleteCurrentPicture()
        }
        alertController.addAction(delete)
        
        let cancle = UIAlertAction(title: kCancle, style: .cancel, handler: nil)
        alertController.addAction(cancle)

        present(alertController, animated: true, completion: nil)
    }
    
    /**
     删除当前图片
     */
    private func deleteCurrentPicture() {
        
        // 重新布局PictureConsultingController的图片模块
        pictureConsultingController.isLayoutPictures = true
        
        /// 移除当前图片
        let pictureIndex = Int(self.scrollView.contentOffset.x/kScreenWidth)
        imgs.remove(at: pictureIndex)
        
        if imgs.count == 0 {
            leftBackBarBttonItemClick()
        } else {
            // 重新布局scrollView的子控件
            for subView in scrollView.subviews {
                subView.removeFromSuperview()
            }
            
            currentIndex = pictureIndex > 0 ? pictureIndex - 1 : 0
            layoutScrollViewSubViews()
        }
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        scrollView.contentSize = CGSize(width: kScreenWidth*CGFloat(imgs.count), height: kScreenWidth)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.black
        let tap = UITapGestureRecognizer(target: self, action: #selector(DeletePictureController.hideOrShownavigationBar))
        scrollView.addGestureRecognizer(tap)
        view.addSubview(scrollView)
        
        // 布局scrollView的子控件
        layoutScrollViewSubViews()
    }
    
    /**
     布局scrollView的子控件
     */
    private func layoutScrollViewSubViews() {
        for i in 0..<imgs.count {
            let imageView = UIImageView(frame: CGRect(x: kScreenWidth*CGFloat(i), y: 0, width: kScreenWidth, height: kScreenHeight - 64))
            imageView.image = imgs[i]
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
        }
        
        // 确定scrollView的contentSize
        scrollView.contentSize = CGSize(width: kScreenWidth*CGFloat(imgs.count), height: 0)
        
        // 确定scrollView的contentOffset
        scrollView.contentOffset = CGPoint(x: kScreenWidth*CGFloat(currentIndex), y: 0)
        
        // 确定title展示内容
        titleOfCurrentPage()
    }
    
    // 确定title展示内容
    fileprivate func titleOfCurrentPage() {
        let page = Int((scrollView.contentOffset.x + kScreenWidth/2)/kScreenWidth)
        let total = imgs.count
        title = "\(page + 1)/\(total)"
    }
    
    @objc private func hideOrShownavigationBar() {
        
//        isHidingNavBar = !isHidingNavBar
//        
//        
//        
//        navigationController?.setNavigationBarHidden(isHidingNavBar, animated: true)
////        UIApplication.sharedApplication().statusBarHidden = isHidingNavBar
////        navigationController?.setToolbarHidden(isHidingNavBar, animated: true)
//        
//        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
//
////        preferredStatusBarStyle()
//        
//        navigationController?.setStatusBarStyle(.Default)
    }
//    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
//    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.Default
//    }

}

extension DeletePictureController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 确定title展示内容
        titleOfCurrentPage()
    }
}
