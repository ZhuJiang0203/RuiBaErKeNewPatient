//
//  PatientInformationController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit
import AssetsLibrary

class PatientInformationController: BaseViewController {

    var profileCtl: ProfileController!
    
    var tableView: UITableView!
    var keys = [kName, kSex, kDateOfBirth, kMedicalRecordTabBar]
    var values = [kNothing, kNothing, kNothing, kNotBound]
    
    var binDingView: BinDingView?
    
    fileprivate var iconBtn: UIButton?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = kEssentialInformation
        
        setupTableView()
    }
    
    /**
     * 添加 BinDingView 界面
     */
    fileprivate func addBinDingView() {
        binDingView = BinDingView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        binDingView!.delegate = self
        view.addSubview(binDingView!)
        
        // 执行自定义的动画
        binDingView!.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 0.25) { 
            self.binDingView!.transform = CGAffineTransform.identity
        }
    }
    
    /**
     * 移除 BinDingView 界面
     */
    fileprivate func removeBinDingView(tag: Int) {
        
        // 执行自定义的动画
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            // 由于CGFloat是不准确的, 所以传入0.0之后没有动画效果
            self.binDingView!.transform = CGAffineTransform(scaleX: 1.0, y: 0.000001)
            }, completion: { (_) -> Void in
                
                self.binDingView?.removeFromSuperview()
                self.binDingView = nil
                
                if tag == 0 {
                    let vc = MedicalRecordBindingController()
                    vc.type = 1
                    self.navigationController?.pushViewController(vc, animated: true)
                } else if tag == 1 {
                    let vc = AddPatientInfoController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
        })
    }
    
    
    // MARK:- 创建tableView
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64), style: .grouped)
        tableView.backgroundColor = rgb244
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    // MARK:- 相册
    @objc fileprivate func iconButtonClicked() {
        
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
    fileprivate func takePhoto() {
        
        let author = ALAssetsLibrary.authorizationStatus()
        if author == .restricted || author == .denied { // 无权限
            jumpToSystemSettingsWithNumber(0)
        } else {
            let vc = UIImagePickerController()
            // 设置打开数据源类型
            vc.sourceType = .camera
            vc.delegate = self
            vc.allowsEditing = true
            // 弹出拍照
            present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK:- 相册
    fileprivate func selecteFromPhotoLibrary() {
        
        let author = ALAssetsLibrary.authorizationStatus()
        if author == .restricted || author == .denied { // 无权限
            jumpToSystemSettingsWithNumber(0)
        } else {
            let vc = UIImagePickerController()
            // 设置打开数据源类型
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            // 弹出相册
            present(vc, animated: true, completion: nil)
        }
    }
    
    /**
     type == 0：相机
     type == 1：相册
     */
    fileprivate func jumpToSystemSettingsWithNumber(_ type: Int) {
        
        let photoAlbumOrCamera = type == 0 ? kCamera : kAlbum
        let organizationName = kRainbowChildrenClinic
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

extension PatientInformationController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = TopCell.setupTopCellWithTableView(tableView, cellForRowAt: indexPath)
            cell.delegate = self
            iconBtn = cell.iconButton
            return cell
        }
        
        let cell = BottomCell.setupBottomCellWithTableView(tableView, cellForRowAt: indexPath)
        cell.keyLabel.text = keys[indexPath.row]
        cell.valueLabel.text = values[indexPath.row]
        cell.line.isHidden = indexPath.row == keys.count - 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 3 {
            // 添加 BinDingView 界面
            addBinDingView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

@objc
protocol TopCellDelegate: NSObjectProtocol {
    @objc optional func iconOfTopCellClicked()
}

fileprivate class TopCell: UITableViewCell {
    
    weak var delegate: TopCellDelegate?
    
    class func setupTopCellWithTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> TopCell {
        let cell = TopCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
        contentView.addSubview(keyLabel)
        contentView.addSubview(iconButton)
        
        let cellH: CGFloat = 80
        keyLabel.frame = CGRect(x: kMargin15, y: 0, width: 150, height: cellH)
        let iconImageViewWH: CGFloat = 60
        let iconImageViewX: CGFloat = kScreenWidth - kMargin15 - iconImageViewWH
        let iconImageViewY: CGFloat = (cellH - iconImageViewWH)/2
        iconButton.frame = CGRect(x: iconImageViewX, y: iconImageViewY, width: iconImageViewWH, height: iconImageViewWH)
        
        iconButton.sd_setBackgroundImage(with: URL.init(string: ""), for: .normal, placeholderImage: UIImage(named: "IconPlacehoderFenWhite"))
        
        let iconImage = SaveImage.getImageWithImageName(kUserIconUIImageKey)
        let img = (iconImage != nil) ? iconImage : UIImage(named: "IconPlacehoderFenWhite")
        iconButton.setBackgroundImage(img, for: .normal)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var keyLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = kProfileInfoIcon
        lbl.textColor = rgb102
        lbl.font = font16
        return lbl
    }()

    fileprivate lazy var iconButton: UIButton = {
        let icon = UIButton()
        icon.layer.cornerRadius = 30
        icon.clipsToBounds = true
        icon.imageView?.contentMode = .scaleAspectFit
        icon.addTarget(self, action: #selector(iconClicked), for: .touchUpInside)
        
        return icon
    }()
    
    @objc private func iconClicked() {
        delegate?.iconOfTopCellClicked?()
    }
}

private class BottomCell: UITableViewCell {
    
    class func setupBottomCellWithTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> BottomCell {
        let cell = BottomCell(style: .default, reuseIdentifier: nil, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, indexPath: IndexPath) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(keyLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(line)

        
        let cellH: CGFloat = 60
        keyLabel.frame = CGRect(x: kMargin15, y: 0, width: 150, height: cellH)
        let valueLabelW: CGFloat = 200
        let valueLabelX: CGFloat = kScreenWidth - kMargin15 - valueLabelW
        valueLabel.frame = CGRect(x: valueLabelX, y: 0, width: valueLabelW, height: cellH)
        line.frame = CGRect(x: kMargin15, y: cellH - 0.5, width: kScreenWidth - 2*kMargin15, height: 0.5)
        
        
        /// 箭头
        if indexPath.row == 3 {
            contentView.addSubview(arrowImageView)
            let arrowImageViewW: CGFloat = 6
            let arrowImageViewH: CGFloat = 10
            let arrowImageViewX: CGFloat = kScreenWidth - kMargin15 - arrowImageViewW
            let arrowImageViewY: CGFloat = (cellH - arrowImageViewH)/2
            arrowImageView.frame = CGRect(x: arrowImageViewX, y: arrowImageViewY, width: arrowImageViewW, height: arrowImageViewH)
            valueLabel.frame.origin.x = arrowImageView.frame.minX - 4 - valueLabelW
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var keyLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font16
        return lbl
    }()
    
    fileprivate lazy var valueLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = rgb102
        lbl.font = font16
        lbl.textAlignment = .right
        return lbl
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "ArrowGray610")
        return icon
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = lineColor
        return line
    }()
}


extension PatientInformationController: BinDingViewDelegate {

    func nextButtonClickedOfBinDingView(selectedBtn: BinDingButton, binDingView: BinDingView) {
        
        // 移除 BinDingView 界面
        removeBinDingView(tag: selectedBtn.tag)
    }
}




// MARK: - UIImagePickerControllerDelegate
extension PatientInformationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        picker.dismiss(animated: true, completion: nil)
        
        // 更换头像
        iconBtn?.setBackgroundImage(image, for: .normal)
        
        // 保存到本地（到处理）
        profileCtl.isRefresh = true
        SaveImage.save(image, andImageName: kUserIconUIImageKey)
    }
}

extension PatientInformationController: TopCellDelegate {
    func iconOfTopCellClicked() {
        iconButtonClicked()
    }
}



