//
//  PictureConsultingController.swift
//  CHCloudPlatformsPatient
//
//  Created by whj on 16/9/23.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  图文咨询

import UIKit
import AssetsLibrary

class PictureConsultingController: BaseViewController {

    var patient: PatientModel?
    
    private var scrollView: UIScrollView!
    // 患者信息
    private var patientValue: UILabel?
    // 疾病名称
    fileprivate var diseaseValue: UITextField?
    // 病情描述、症状等
    fileprivate var textView: UITextView?
    
    private var picturesView: UIView!
    private var addButton: UIButton!
    private var picturesViewLine: UIView!

    // 图片
    var pictures = [UIImage]()
    var isLayoutPictures = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建导航栏
        setupNavigationBar()
        
        // 创建scrollView
        setupScrollView()
        
        // 基本信息模块
        setupInfosView()
        
        // 疾病描述模块
        setupDiseaseDescriptionView()
        
        // 上传图片模块
        setupPicturesView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if patient != nil {
            patientValue?.text = "\(patient!.name) \(patient!.sex) \(patient!.age)"
        }
        
        if isLayoutPictures == true {
            isLayoutPictures = false
            layoutPitures()
        }
    }

    // MARK:- 创建导航栏
    private func setupNavigationBar() {
       
        title = kTextConsulting
        
        setupRightBarButton()
    }
    
    /**
      重写父类方法
     */
    override func leftBackBarBttonItemClick() {
        
        if diseaseValue!.hasText || textView!.hasText || pictures.count > 0 {
            let alertController = UIAlertController(title: nil, message: kQuitTheEditor, preferredStyle: .alert)
            
            let cancle = UIAlertAction(title: kCancle, style: .cancel, handler: nil)
            alertController.addAction(cancle)
            
            let signOut = UIAlertAction(title: kQuit, style: .default) { (action) in
                _ = self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(signOut)
            
            present(alertController, animated: true, completion: nil)
        } else {
            super.leftBackBarBttonItemClick()
        }
    }
    
    private func setupRightBarButton() {
        
        let quest = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        quest.setTitle(kPutQuestionsTo, for: .normal)
        quest.setTitleColor(UIColor.white, for: .normal)
        quest.titleLabel?.font = font16
        quest.contentHorizontalAlignment = .right
        quest.addTarget(self, action: #selector(PictureConsultingController.goToQuest), for: .touchUpInside)
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: quest)
    }

    // MARK:- 提问
    @objc private func goToQuest() {
        
        if diseaseValue?.hasText == false {
            CustomMBProgressHUD.showTipAndHideImmediately(kPleaseEnterTheNameOfTheDisease, details: nil, view:view)
            return
        }
        
        if textView?.hasText == false {
            CustomMBProgressHUD.showTipAndHideImmediately(kPleaseSpecifyYourCondition, details: nil, view:view)
            return
        }
        
        // 提交至 环信
        
    
    }
    
    // MARK:- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~发送文字
    private func sendMessage(txt: String) {
//        LLog(txt)
//        // 1.创建一个消息对象
//        // 1.1 构造文字消息
//        let body = EMTextMessageBody.init(text: txt)
//        
//        // 生成Message
//        LLog(self.listModel!.conversationID)
//        LLog(self.listModel!.patientID)
//        let conversationID = self.listModel!.conversationID
//        
//        
//        
//        // 扩展信息
//        let doctorID = defaults.string(forKey: kDoctorIDKey) ?? ""
//        let dic = ["ID" : huanXinID,
//                   "UserType" : "1",
//                   "UserID" : doctorID,
//                   "Icon" : doctorIcon,
//                   "Name" : doctorName,
//                   "ConsultOrFollowUp" : ConsultOrFollowUp,
//                   "FollowUpType" : FollowUpType,
//                   "ConsultType" : ConsultType,
//                   "ConsultID" : ConsultID,
//                   "ConsultTime" : ConsultTime,
//                   ]
//        
//        LLog(message: "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + ConsultOrFollowUp)
//        LLog(message: "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + FollowUpType)
//        LLog(message: ConsultType)
//        LLog(message: ConsultTime)
//        
//        let message = EMMessage(conversationID: conversationID, from: huanXinID, to: conversationID, body: body, ext: dic)
//        message?.chatType = EMChatTypeChat // 设置为单聊消息
//        
//        // 2 发送消息
//        title = kSending
//        EMClient.shared().chatManager.send(message, progress: { (_) in
//            LLog(message: message)
//            }, completion: { (msg, error) in
//                self.title = self.listModel?.name
//                LLog(message: error)
//                if error == nil {
//                    if self.consultListCtl != nil {
//                        self.consultListCtl!.isRefresh = true
//                    }
//                    
//                    
//                    self.addToFrameModels(allMsges: [msg!], isScrollToEnd: true, isInsert: false)
//                    
//                }
//        })
    }
    

    // MARK:- 创建scrollView
    private func setupScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = rgb244
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    // MARK:- 基本信息模块
    private func setupInfosView() {
        
        let viewH: CGFloat = 60
        let topview = UIView(frame: CGRect(x: 0, y: 10, width: kScreenWidth, height: viewH*2))
        topview.backgroundColor = UIColor.white
        scrollView.addSubview(topview)
        
        let patientView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: viewH))
        topview.addSubview(patientView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PictureConsultingController.patientViewClicked))
        patientView.addGestureRecognizer(tap);
        
        let patientKey = UILabel(frame: CGRect(x: 15, y: 0, width: 100, height: viewH))
        patientKey.text = kPatient
        patientKey.textColor = rgb102
        patientKey.font = font16
        patientView.addSubview(patientKey)

        let arrowW: CGFloat = 6
        let arrowH: CGFloat = 10
        let arrowX: CGFloat = kScreenWidth - 15 - arrowW
        let arrowY: CGFloat = (viewH - arrowH)/2
        let arrow = UIImageView(frame: CGRect(x: arrowX, y: arrowY, width: arrowW, height: arrowH))
        arrow.image = UIImage(named: "ArrowGray610")
        patientView.addSubview(arrow)

        let patientW: CGFloat = 200
        let patientX: CGFloat = arrow.frame.minX - 10 - patientW
        patientValue = UILabel(frame: CGRect(x: patientX, y: 0, width: patientW, height: viewH))
        patientValue!.text = "小尹 男 31岁"
        patientValue!.textColor = rgb51
        patientValue!.font = font16
        patientValue!.textAlignment = .right
        patientView.addSubview(patientValue!)
        
        
        
        let diseaseView = UIView(frame: CGRect(x: 0, y: viewH, width: kScreenWidth, height: viewH))
        topview.addSubview(diseaseView)
        
        let diseaseKey = UILabel(frame: CGRect(x: 15, y: 0, width: 100, height: viewH))
        diseaseKey.text = kDiseaseName
        diseaseKey.textColor = rgb102
        diseaseKey.font = font16
        diseaseView.addSubview(diseaseKey)
        
        let diseaseValueW: CGFloat = 200
        let diseaseValueX: CGFloat = kScreenWidth - 15 - diseaseValueW
        diseaseValue = UITextField(frame: CGRect(x: diseaseValueX, y: 0, width: diseaseValueW, height: viewH))
        diseaseValue!.textColor = rgb51
        diseaseValue!.font = font16
        diseaseValue!.textAlignment = .right
        // 光标颜色
        diseaseValue!.tintColor = rgbColor(249, g: 117, b: 140)
        // 占位文字
        diseaseValue!.placeholder = kPleaseEnterDiseaseName
        diseaseView.addSubview(diseaseValue!)
    }
    
    @objc private func patientViewClicked() {
        let vc = SelectedPatientController()
        vc.pictureConsultingController = self
        vc.selectedModel = patient
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK:- 疾病描述模块
    private func setupDiseaseDescriptionView() {
        
        let diseaseViewH: CGFloat = 180
        let diseaseView = UIView(frame: CGRect(x: 0, y: 140, width: kScreenWidth, height: diseaseViewH))
        diseaseView.backgroundColor = UIColor.white
        scrollView.addSubview(diseaseView)
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.5))
        line.backgroundColor = rgbSameColor(237)
        diseaseView.addSubview(line)
        
        let textViewX: CGFloat = 15
        let textViewY: CGFloat = 10
        let textViewW: CGFloat = kScreenWidth - 2*textViewX
        let textViewH: CGFloat = diseaseViewH - textViewY*2
        textView = UITextView(frame: CGRect(x: textViewX, y: textViewY, width: textViewW, height: textViewH), textContainer: nil)
        textView!.font = font14
        textView!.textColor = rgb51
        textView!.delegate = self
        textView!.tintColor = rgbColor(249, g: 117, b: 140)
        textView!.returnKeyType = UIReturnKeyType.go
        textView!.addSubview(placehoder)
        placehoder.frame = CGRect(x: 5, y: 8, width: kScreenWidth - 40, height: 100)
        diseaseView.addSubview(textView!)
    }
    
    fileprivate lazy var placehoder: VerticalAlignmentLabel = {
        let tip = VerticalAlignmentLabel()
        tip.textColor = UIColor.gray
        tip.font = font14
        tip.text = kDetailsOfYourIllnessEtc
        tip.numberOfLines = 0
        tip.verAlignment = .top
        return tip
    }()
    
    // MARK:- 上传图片模块
    private func setupPicturesView() {
    
        let margin: CGFloat = 15
        let maxCount = 4
        let picWH = (kScreenWidth - CGFloat(maxCount + 1)*margin)/CGFloat(maxCount)
        let picsViewH = picWH + 2*margin
        picturesView = UIView(frame: CGRect(x: 0, y: 320, width: kScreenWidth, height: picsViewH))
        picturesView.backgroundColor = UIColor.white
        scrollView.addSubview(picturesView)
        
        addButton = UIButton(frame: CGRect(x: margin, y: margin, width: picWH, height: picWH))
        addButton.setBackgroundImage(UIImage(named: "AddPicturesIcon"), for: .normal)
        addButton.addTarget(self, action: #selector(PictureConsultingController.addButtonClicked), for: .touchUpInside)
        picturesView.addSubview(addButton)
        
        picturesViewLine = UIView(frame: CGRect(x: 0, y: picsViewH - 0.5, width: kScreenWidth, height: 0.5))
        picturesViewLine.backgroundColor = rgbSameColor(237)
        picturesView.addSubview(picturesViewLine)
        
        scrollView.contentSize = CGSize(width: kScreenWidth, height: picturesView.frame.maxY + 10)
    }
    
    // MARK:- 布局图片
    fileprivate func layoutPitures() {
        
        for subView in picturesView.subviews {
            if subView.isKind(of: UIImageView.self) {
                subView.removeFromSuperview()
            }
        }
        
        
        let margin: CGFloat = 15
        let maxCount = 4
        let picWH = (kScreenWidth - CGFloat(maxCount + 1)*margin)/CGFloat(maxCount)

        for i in 0..<pictures.count + 1 {
            let picX: CGFloat = CGFloat(i%maxCount)*(picWH + margin) + margin
            let picY: CGFloat = CGFloat(i/maxCount)*(picWH + margin) + margin
            if i == pictures.count {
                addButton.frame.origin = CGPoint(x: picX, y: picY)
            } else {
                let imageView = UIImageView(frame: CGRect(x: picX, y: picY, width: picWH, height: picWH))
                imageView.image = pictures[i]
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.isUserInteractionEnabled = true
                imageView.tag = i
                let tap = UITapGestureRecognizer(target: self, action: #selector(PictureConsultingController.imageViewClicked(_:)))
                imageView.addGestureRecognizer(tap)
                picturesView.addSubview(imageView)
            }
        }
        
        picturesView.frame.size.height = addButton.frame.maxY + margin
        picturesViewLine.frame.origin.y = picturesView.frame.maxY - 0.5
        scrollView.contentSize = CGSize(width: kScreenWidth, height: picturesView.frame.maxY + 10)
        
        // 确定contentOffset的位置
        scrollView.contentOffset.y = max(scrollView.contentSize.height - scrollView.frame.height, 0)
        
        // 最多9张图片
        addButton.isHidden = pictures.count == 9
    }
    
    @objc private func imageViewClicked(_ tap: UITapGestureRecognizer) {
        let vc = DeletePictureController()
        vc.pictureConsultingController = self
        vc.currentIndex = tap.view!.tag
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- 相册
    @objc private func addButtonClicked() {
        
        let alertController = UIAlertController(title: nil, message: kSelectPhotos, preferredStyle: .actionSheet)

        let camera = UIAlertAction(title: kChoiceMakePhone, style: .default) { (action) in
            self.takePhoto()
        }
        alertController.addAction(camera)
       
        let photoLibrary = UIAlertAction(title: kSelectFromTheAlbum, style: .default) { (action) in
            self.selecteFromPhotoLibrary()
        }
        alertController.addAction(photoLibrary)
        
        let cancle = UIAlertAction(title: kCancle, style: .cancel) { (action) in
            print("取消")
        }
        alertController.addAction(cancle)
        
        present(alertController, animated: true, completion: nil)
    }

    // MARK:- 拍照
    private func takePhoto() {
        
        // 方法一：
        let author = ALAssetsLibrary.authorizationStatus()
        if author == .restricted || author == .denied { // 无权限
            jumpToSystemSettingsWithNumber(0)
        } else {
            let vc =  UIImagePickerController()
            // 设置打开数据源类型
            vc.sourceType = .camera
            vc.delegate = self
            // 弹出拍照
            present(vc, animated: true, completion: nil)
        }
  
        
//        // 方法二：
//        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
//            let alertController = UIAlertController(title: "相机授权未开启", message: "请在系统设置中开启相机授权", preferredStyle: UIAlertControllerStyle.Alert)
//            let action = UIAlertAction(title: "知道了", style: .Cancel, handler: { (action) in
//                LLog("点击了知道了")
//            })
//            alertController.addAction(action)
//            
//            presentViewController(alertController, animated: true, completion: {
//                LLog("弹出了提示框")
//            })
//        } else {
//            let vc =  UIImagePickerController()
//            // 设置打开数据源类型
//            vc.sourceType = .Camera
//            vc.delegate = self
//            // 弹出拍照
//            presentViewController(vc, animated: true, completion: nil)
//        }
    }
    
    // MARK:- 相册
    private func selecteFromPhotoLibrary() {
        
        // 方法一：
        let author = ALAssetsLibrary.authorizationStatus()
        if author == .restricted || author == .denied { // 无权限
            jumpToSystemSettingsWithNumber(0)
        } else {
            let vc =  UIImagePickerController()
            // 设置打开数据源类型
            vc.sourceType = .photoLibrary
            vc.delegate = self
            // 弹出相册
            present(vc, animated: true, completion: nil)
        }
        

//        // 方法二：
//        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
//            
//            let alertController = UIAlertController(title: "相册授权未开启", message: "请在系统设置中开启相册授权", preferredStyle: UIAlertControllerStyle.Alert)
//            let action = UIAlertAction(title: "知道了", style: UIAlertActionStyle.Cancel, handler: { (action) in
//                LLog("点击了知道了")
//            })
//            alertController.addAction(action)
//            presentViewController(alertController, animated: true, completion: {
//                LLog("弹出了提示框")
//            })
//            return
//        } else {
//            let vc =  UIImagePickerController()
//            // 设置打开数据源类型
//            vc.sourceType = .PhotoLibrary
//            vc.delegate = self
//            // 弹出相册
//            presentViewController(vc, animated: true, completion: nil)
//        }
    }

    /**
     type == 0：相机
     type == 1：相册
     */
    private func jumpToSystemSettingsWithNumber(_ type: Int) {
       
        let photoAlbumOrCamera = type == 0 ? kCamera : kAlbum
        let organizationName = "睿宝儿科"
        let alertController = UIAlertController(title: "\(photoAlbumOrCamera)不可访问", message: "使用\(photoAlbumOrCamera)之前，请先允许\(organizationName)访问您的\(photoAlbumOrCamera)", preferredStyle: .alert)
       
        let cancle = UIAlertAction(title: kCancle, style: .cancel) { (action) in
            print("取消")
        }
        alertController.addAction(cancle)
        
        let toSetup = UIAlertAction(title: kToSet, style: .default) { (action) in
            // 此处考虑进了iOS8.0之前的系统
            let url = URL(string: UIApplicationOpenSettingsURLString)
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.openURL(url!)
            }
        }
        alertController.addAction(toSetup)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    


}

// MARK: - UITextViewDelegate
extension PictureConsultingController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placehoder.isHidden = textView.hasText
    }
}

// MARK: - UIImagePickerControllerDelegate
extension PictureConsultingController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        picker.dismiss(animated: true, completion: nil)
        
        pictures.append(image)
        
        layoutPitures()
        
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            
//            let imageValue = UIImage.fixOrientation(image)
//            let data: NSData = UIImagePNGRepresentation(imageValue)!
//            
//        })
    }
    
}



