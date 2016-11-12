//
//  AddPatientInfoController.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/10/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//
//  新增就诊人

import UIKit

class AddPatientInfoController: BaseViewController {
    
    /// 家庭成员 -> 新增就诊人
    var memberOfFamilyCtl: MemberOfFamilyController?
    
    
    private var scrollView: UIScrollView!
    /// 就诊人姓名、拼音
    private var chinaNameView: UIView!
    private var chinaNameTextField: UITextField!
    private var chinaPinYinTextField: UITextField!
    private var keyLabelH: CGFloat = 22
    private var textFieldH: CGFloat = 42
    private var textFieldW: CGFloat = 0
    // 模块间距
    private var viewMarginY: CGFloat = 30
    /// Full name、Family name、Given name
    private var fullNameView: UIView!
    // 是否有Family name
    private var selectedFullNameButton: FullNameButton?
    private var familyNameTextField: UITextField!
    private var givenNameTextField: UITextField!
    /// 性别、出生日期、身份证类型、住址
    private var sexBirthCardAddressView: UIView!
    private var sexView: UIView!
    fileprivate var sexButton: UIButton!
    private var boyGirlButtonView: UIView!
    private var selectedSexButton: UIButton?
    private let boyGirl = [kMale, kFemale]
    private var birthDayTextField: UITextField!
    private var cardTypeView: UIView!
    fileprivate var cardTypeButton: UIButton!
    private var IDPassportView: UIView!
    private var selectedCardTypeButton: UIButton?
    private let IDPassport = [kID, kPassport]
    private var cardTextField: UITextField!
    // 省/市/区
    private var addressSSQButton: UIButton!
    // 详细地址
    private var addressTextField: UITextField!
    /// 是否保卡、保卡类型
    private var careCardView: UIView!
    // 是否有保卡
    private var selectedIsHasCardButton: FullNameButton?
    // 保险类型
    private var insuranceTypeButton: UIButton!
    var insuranceTypeText = kPleaseSelect
    private var insuranceCardTextField: UITextField!
    /// 父亲、母亲、Email、确认后就诊人信息只能去诊所进行更改
    private var parentsEmailTipView: UIView!
    private var fatherNameTextField: UITextField!
    private var fatherPhoneTextField: UITextField!
    private var motherNameTextField: UITextField!
    private var motherPhoneTextField: UITextField!
    private var emailTextField: UITextField!

    
    /** 省市县选择器 */
    fileprivate var masking: UIView?
    fileprivate var pickerVw: UIView?
    /** 省市县 */
    fileprivate var provinceIndex: Int = 0
    fileprivate var cityIndex: Int = 0
    fileprivate var countyIndex: Int = 0
    fileprivate var provinceArr = [AnyObject]()
    fileprivate var cityArr = [AnyObject]()
    fileprivate var countyArr = [String]()
    fileprivate var pickerH: CGFloat = 212

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldW = kScreenWidth - 2*kMargin

        title = kNewPatient
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(title: kEnsure, style: .plain, target: self, action: #selector(AddPatientInfoController.rightBarButtonItemClicked))
        
        
        // 获取省市区数据
        getPCCData()

        /// scrollView
        setupScrollView()
        
        /// 就诊人姓名、拼音
        seupChinaNameView()
        
        /// Full name、Family name、Given name
        seupFullNameView()
        
        /// 性别、出生日期、身份证类型、住址
        seupSexBirthDayCardAddressView()
        
        /// 是否保卡、保卡类型
        seupCareCardView()
        
        /// 父亲、母亲、Email、确认后就诊人信息只能去诊所进行更改
        seupParentsEmailTipView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        insuranceTypeButton.setTitle("  " + insuranceTypeText, for: .normal)
        
        let titleColor = insuranceTypeText == kPleaseSelect ? rgbSameColor(188) : rgb51
        insuranceTypeButton.setTitleColor(titleColor, for: .normal)
    }
    
    
    
    // MARK:- 获取省市区数据
    private func getPCCData() {
        
        DispatchQueue.global(qos: .default).async {
            let plistPath = Bundle.main.path(forResource: "address", ofType: "plist")
            let dataDictionary = NSMutableDictionary(contentsOfFile: plistPath!)!
            let dataDict = NSDictionary(dictionary: dataDictionary)
            let dataArr = dataDict["address"] as! [[String: AnyObject]]
            let provinceArrs = NSMutableArray(array: dataArr)
            print(provinceArrs)
            
            self.provinceArr = provinceArrs as [AnyObject]
            print(self.provinceArr)
            
            self.reloadCityDatas()
            self.reloadCountyDatas()
        }
    }

    fileprivate func reloadCityDatas() {
        cityArr.removeAll()
        
        let dic = provinceArr[provinceIndex] as! [String: AnyObject]
        print(dic)
        cityArr = dic["sub"] as! [AnyObject]
        print(cityArr)
    }
    
    fileprivate func reloadCountyDatas() {
        countyArr.removeAll()
        
        let dic = cityArr[cityIndex] as! [String: AnyObject]
        print(dic)
        countyArr = dic["sub"] as! [String]
        print(countyArr)
    }

    
    
    
    // MARK:- scrollView
    private func setupScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = rgb244
        view.addSubview(scrollView)
    }

    
    // MARK:- 确定
    @objc private func rightBarButtonItemClicked() {

        if memberOfFamilyCtl != nil {
            let model = MemberModel()
            model.memberId = "100"
            model.iconUrlString = "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1477896033&di=f6e53425029cf573602ed99a80e16c5a&src=http://pic11.nipic.com/20101111/1324566_220639484000_2.jpg"
            model.name = "100"
            model.sex = "M"
            model.age = "12岁"
            model.relationship = "妃子"
            model.phone = "100"
            model.familyPhone = "100"
            model.email = "100"
            model.weiXinNumber = "100"
            memberOfFamilyCtl!.members.append(model)
            memberOfFamilyCtl!.isReloadData = true
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 就诊人姓名、拼音
    private func seupChinaNameView() {
        chinaNameView = UIView(frame: CGRect(x: kMargin, y: kMargin, width: textFieldW, height: 160))
        chinaNameView.backgroundColor = UIColor.clear
        scrollView.addSubview(chinaNameView)
        
        let nameKey = UILabel(frame: CGRect(x: 0, y: 0, width: textFieldW, height: keyLabelH))
        nameKey.text = kNameOfPatient
        nameKey.textColor = rgb102
        nameKey.font = font16
        chinaNameView.addSubview(nameKey)
        
        chinaNameTextField = UITextField(frame: CGRect(x: 0, y: nameKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        chinaNameTextField.backgroundColor = UIColor.white
        chinaNameTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        chinaNameTextField.layer.cornerRadius = kRadius
        chinaNameTextField.clipsToBounds = true
        chinaNameTextField.layer.borderColor = rgbSameColor(193).cgColor
        chinaNameTextField.layer.borderWidth = 0.5
        chinaNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        chinaNameTextField.leftViewMode = UITextFieldViewMode.always
        chinaNameTextField.textColor = rgb51
        chinaNameTextField.font = font16
        chinaNameTextField.delegate = self
        chinaNameView.addSubview(chinaNameTextField)
        
        
        let pinyinKey = UILabel(frame: CGRect(x: 0, y: chinaNameTextField.frame.maxY + kMargin, width: textFieldW, height: keyLabelH))
        pinyinKey.text = kPinyin
        pinyinKey.textColor = rgb102
        pinyinKey.font = font16
        chinaNameView.addSubview(pinyinKey)
        
        chinaPinYinTextField = UITextField(frame: CGRect(x: 0, y: pinyinKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        chinaPinYinTextField.backgroundColor = UIColor.white
        chinaPinYinTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        chinaPinYinTextField.layer.cornerRadius = kRadius
        chinaPinYinTextField.clipsToBounds = true
        chinaPinYinTextField.layer.borderColor = rgbSameColor(193).cgColor
        chinaPinYinTextField.layer.borderWidth = 0.5
        chinaPinYinTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        chinaPinYinTextField.leftViewMode = UITextFieldViewMode.always
        chinaPinYinTextField.textColor = rgb51
        chinaPinYinTextField.font = font16
        chinaPinYinTextField.delegate = self
        chinaNameView.addSubview(chinaPinYinTextField)
        
        chinaNameView.frame.size.height = chinaPinYinTextField.frame.maxY + viewMarginY
    }
    
    // MARK:- Full name、Family name、Given name
    private func seupFullNameView() {
        
        fullNameView = UIView(frame: CGRect(x: kMargin, y: chinaNameView.frame.maxY, width: textFieldW, height: keyLabelH))
        fullNameView.clipsToBounds = true
        scrollView.addSubview(fullNameView)
        
        let fullName = UIView(frame: CGRect(x: 0, y: 0, width: textFieldW, height: keyLabelH))
        fullNameView.addSubview(fullName)
        
        let fullNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 82, height: keyLabelH))
        fullNameLabel.text = "Full name"
        fullNameLabel.textColor = rgb102
        fullNameLabel.font = font16
        fullName.addSubview(fullNameLabel)

        let btnW: CGFloat = 40
        let yesButton = FullNameButton.init(frame: CGRect(x: fullNameLabel.frame.maxX + btnW, y: 0, width: btnW, height: keyLabelH), text: kYES)
        yesButton.tag = 0
        yesButton.addTarget(self, action: #selector(AddPatientInfoController.yesOrNoButtonClicked(btn:)), for: .touchUpInside)
        fullName.addSubview(yesButton)
        
        let noButton = FullNameButton.init(frame: CGRect(x: yesButton.frame.maxX + btnW, y: 0, width: btnW, height: keyLabelH), text: kNO)
        noButton.tag = 1
        noButton.addTarget(self, action: #selector(AddPatientInfoController.yesOrNoButtonClicked(btn:)), for: .touchUpInside)
        fullName.addSubview(noButton)
        
        
        let familyNameKey = UILabel(frame: CGRect(x: 0, y: fullName.frame.maxY + kMargin, width: 200, height: keyLabelH))
        familyNameKey.text = "Family name"
        familyNameKey.textColor = rgb102
        familyNameKey.font = font16
        fullNameView.addSubview(familyNameKey)

        familyNameTextField = UITextField(frame: CGRect(x: 0, y: familyNameKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        familyNameTextField.backgroundColor = UIColor.white
        familyNameTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        familyNameTextField.layer.cornerRadius = kRadius
        familyNameTextField.clipsToBounds = true
        familyNameTextField.layer.borderColor = rgbSameColor(193).cgColor
        familyNameTextField.layer.borderWidth = 0.5
        familyNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        familyNameTextField.leftViewMode = UITextFieldViewMode.always
        familyNameTextField.textColor = rgb51
        familyNameTextField.font = font16
        familyNameTextField.delegate = self
        fullNameView.addSubview(familyNameTextField)
        
        let givenNameKey = UILabel(frame: CGRect(x: 0, y: familyNameTextField.frame.maxY + kMargin, width: 200, height: keyLabelH))
        givenNameKey.text = "Given name"
        givenNameKey.textColor = rgb102
        givenNameKey.font = font16
        fullNameView.addSubview(givenNameKey)

        givenNameTextField = UITextField(frame: CGRect(x: 0, y: givenNameKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        givenNameTextField.backgroundColor = UIColor.white
        givenNameTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        givenNameTextField.layer.cornerRadius = kRadius
        givenNameTextField.clipsToBounds = true
        givenNameTextField.layer.borderColor = rgbSameColor(193).cgColor
        givenNameTextField.layer.borderWidth = 0.5
        givenNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        givenNameTextField.leftViewMode = UITextFieldViewMode.always
        givenNameTextField.textColor = rgb51
        givenNameTextField.font = font16
        givenNameTextField.delegate = self
        fullNameView.addSubview(givenNameTextField)
    }
    
    @objc private func yesOrNoButtonClicked(btn: FullNameButton) {
        selectedFullNameButton?.isSelected = false
        btn.isSelected = true
        selectedFullNameButton = btn
     
        /// 刷新控件，重新布局
        refreshSubviewsFrame(tag: btn.tag)
    }
    
    // MARK:- 刷新控件，重新布局
    private func refreshSubviewsFrame(tag: Int) {
        
        UIView.animate(withDuration: 0.25, animations: {
            switch tag {
            case 0:
                self.fullNameView.frame.size.height = self.givenNameTextField.frame.maxY
            case 1:
                self.fullNameView.frame.size.height = self.keyLabelH
            case 2:
                self.careCardView.frame.size.height = self.insuranceCardTextField.frame.maxY
            case 3:
                self.careCardView.frame.size.height = self.keyLabelH
            default:
                LLog("other")
            }
            self.sexBirthCardAddressView.frame.origin.y = self.fullNameView.frame.maxY + self.viewMarginY
            self.careCardView.frame.origin.y = self.sexBirthCardAddressView.frame.maxY
            self.parentsEmailTipView.frame.origin.y = self.careCardView.frame.maxY + self.viewMarginY
            }) { (_) in
                self.scrollView.contentSize = CGSize(width: 0, height: self.parentsEmailTipView.frame.maxY)
        }
    }
    
    // MARK:- 性别、出生日期、身份证类型、住址
    private func seupSexBirthDayCardAddressView() {
        
        sexBirthCardAddressView = UIView(frame: CGRect(x: kMargin, y: fullNameView.frame.maxY + viewMarginY, width: textFieldW, height: 100))
        scrollView.addSubview(sexBirthCardAddressView)
        
        let sexKey = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: keyLabelH))
        sexKey.text = kSex
        sexKey.textColor = rgb102
        sexKey.font = font16
        sexBirthCardAddressView.addSubview(sexKey)

        
        sexView = UIView(frame: CGRect(x: 0, y: sexKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        sexView.backgroundColor = UIColor.white
        sexView.layer.borderColor = rgbSameColor(193).cgColor
        sexView.layer.borderWidth = 0.5
        sexView.layer.cornerRadius = kRadius
        sexView.clipsToBounds = true
        sexBirthCardAddressView.addSubview(sexView)
        
        sexButton = UIButton(frame: CGRect(x: 0, y: 0, width: textFieldW, height: textFieldH))
        sexButton.backgroundColor = UIColor.white
        sexButton.layer.borderColor = rgbSameColor(193).cgColor
        sexButton.layer.borderWidth = 0.5
        sexButton.titleLabel?.textColor = rgb51
        sexButton.titleLabel?.font = font16
        sexButton.setTitleColor(rgb51, for: .normal)
        sexButton.contentHorizontalAlignment = .left
        sexButton.addTarget(self, action: #selector(AddPatientInfoController.sexButtonClicked), for: .touchUpInside)
        sexView.addSubview(sexButton)
        
        boyGirlButtonView = UIView(frame: CGRect(x: 0, y: textFieldH, width: textFieldW, height: textFieldH*2))
        boyGirlButtonView.isHidden = true
        boyGirlButtonView.backgroundColor = UIColor.white
        sexView.addSubview(boyGirlButtonView)
        
        for i in 0..<2 {
            let btn = UIButton(frame: CGRect(x: 0, y: CGFloat(i)*textFieldH, width: textFieldW, height: textFieldH))
            btn.setTitle("  " + boyGirl[i], for: .normal)
            btn.setTitleColor(rgb51, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.contentHorizontalAlignment = .left
            btn.setBackgroundImage(UIImage.init(named: "ToEvaluateControllerSubmitBackImage"), for: .selected)
            btn.tag = i
            btn.addTarget(self, action: #selector(AddPatientInfoController.boyGirlButtonClicked(btn:)), for: .touchUpInside)
            boyGirlButtonView.addSubview(btn)
        }
        
        
        
        
        let birthDayKey = UILabel(frame: CGRect(x: 0, y: sexView.frame.maxY + kMargin, width: 200, height: keyLabelH))
        birthDayKey.text = kDateOfBirth
        birthDayKey.textColor = rgb102
        birthDayKey.font = font16
        sexBirthCardAddressView.addSubview(birthDayKey)
        
        birthDayTextField = UITextField(frame: CGRect(x: 0, y: birthDayKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        birthDayTextField.backgroundColor = UIColor.white
        birthDayTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        birthDayTextField.layer.cornerRadius = kRadius
        birthDayTextField.clipsToBounds = true
        birthDayTextField.layer.borderColor = rgbSameColor(193).cgColor
        birthDayTextField.layer.borderWidth = 0.5
        birthDayTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        birthDayTextField.leftViewMode = UITextFieldViewMode.always
        birthDayTextField.textColor = rgb51
        birthDayTextField.font = font16
        birthDayTextField.delegate = self
        sexBirthCardAddressView.addSubview(birthDayTextField)
        
        
        let cardTypeKey = UILabel(frame: CGRect(x: 0, y: birthDayTextField.frame.maxY + kMargin, width: 200, height: keyLabelH))
        cardTypeKey.text = kTypeOfIDCard
        cardTypeKey.textColor = rgb102
        cardTypeKey.font = font16
        sexBirthCardAddressView.addSubview(cardTypeKey)
        
//        cardTypeTextField = UITextField(frame: CGRect(x: 0, y: cardTypeKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
//        cardTypeTextField.backgroundColor = UIColor.white
//        cardTypeTextField.placeholder = kPleaseSelect
//        cardTypeTextField.layer.cornerRadius = kRadius
//        cardTypeTextField.clipsToBounds = true
//        cardTypeTextField.layer.borderColor = rgbSameColor(193).cgColor
//        cardTypeTextField.layer.borderWidth = 0.5
//        cardTypeTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
//        cardTypeTextField.leftViewMode = UITextFieldViewMode.always
//        cardTypeTextField.textColor = rgb51
//        cardTypeTextField.font = font16
//        cardTypeTextField.delegate = self
//        sexBirthCardAddressView .addSubview(cardTypeTextField)
        
        cardTypeView = UIView(frame: CGRect(x: 0, y: cardTypeKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        cardTypeView.backgroundColor = UIColor.white
        cardTypeView.layer.borderColor = rgbSameColor(193).cgColor
        cardTypeView.layer.borderWidth = 0.5
        cardTypeView.layer.cornerRadius = kRadius
        cardTypeView.clipsToBounds = true
        sexBirthCardAddressView.addSubview(cardTypeView)
        
        cardTypeButton = UIButton(frame: CGRect(x: 0, y: 0, width: textFieldW, height: textFieldH))
        cardTypeButton.backgroundColor = UIColor.white
        cardTypeButton.layer.borderColor = rgbSameColor(193).cgColor
        cardTypeButton.layer.borderWidth = 0.5
        cardTypeButton.titleLabel?.textColor = rgb51
        cardTypeButton.titleLabel?.font = font16
        cardTypeButton.setTitle("  " + kPleaseSelect, for: .normal)
        cardTypeButton.setTitleColor(rgbSameColor(188), for: .normal)
        cardTypeButton.contentHorizontalAlignment = .left
        cardTypeButton.addTarget(self, action: #selector(AddPatientInfoController.cardTypeButtonClicked), for: .touchUpInside)
        cardTypeView.addSubview(cardTypeButton)
        
        IDPassportView = UIView(frame: CGRect(x: 0, y: textFieldH, width: textFieldW, height: textFieldH*2))
        IDPassportView.isHidden = true
        IDPassportView.backgroundColor = UIColor.white
        cardTypeView.addSubview(IDPassportView)
        
        for i in 0..<2 {
            let btn = UIButton(frame: CGRect(x: 0, y: CGFloat(i)*textFieldH, width: textFieldW, height: textFieldH))
            btn.setTitle("  " + IDPassport[i], for: .normal)
            btn.setTitleColor(rgb51, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.contentHorizontalAlignment = .left
            btn.setBackgroundImage(UIImage.init(named: "ToEvaluateControllerSubmitBackImage"), for: .selected)
            btn.tag = i
            btn.addTarget(self, action: #selector(AddPatientInfoController.IDPassportButtonClicked(btn:)), for: .touchUpInside)
            IDPassportView.addSubview(btn)
        }

        
        cardTextField = UITextField(frame: CGRect(x: 0, y: cardTypeView.frame.maxY + kMargin, width: textFieldW, height: textFieldH))
        cardTextField.backgroundColor = UIColor.white
        cardTextField.placeholder = kPleaseEnterIDNumber
        cardTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        cardTextField.layer.cornerRadius = kRadius
        cardTextField.clipsToBounds = true
        cardTextField.layer.borderColor = rgbSameColor(193).cgColor
        cardTextField.layer.borderWidth = 0.5
        cardTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        cardTextField.leftViewMode = UITextFieldViewMode.always
        cardTextField.textColor = rgb51
        cardTextField.font = font16
        cardTextField.delegate = self
        cardTextField.keyboardType = .namePhonePad
        sexBirthCardAddressView.addSubview(cardTextField)
        
        
        let addressKey = UILabel(frame: CGRect(x: 0, y: cardTextField.frame.maxY + kMargin, width: 200, height: keyLabelH))
        addressKey.text = kAddress
        addressKey.textColor = rgb102
        addressKey.font = font16
        sexBirthCardAddressView.addSubview(addressKey)
        
        
        /// 省市区
        addressSSQButton = UIButton(frame: CGRect(x: 0, y: addressKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        addressSSQButton.backgroundColor = UIColor.white
        addressSSQButton.layer.borderColor = rgbSameColor(193).cgColor
        addressSSQButton.layer.borderWidth = 0.5
        addressSSQButton.titleLabel?.textColor = rgb51
        addressSSQButton.titleLabel?.font = font16
        addressSSQButton.setTitle("  " + kProvinceCityDistrict, for: .normal)
        addressSSQButton.setTitleColor(rgbSameColor(188), for: .normal)
        addressSSQButton.contentHorizontalAlignment = .left
        addressSSQButton.addTarget(self, action: #selector(AddPatientInfoController.addressSSQButtonClicked), for: .touchUpInside)
        sexBirthCardAddressView.addSubview(addressSSQButton)

        /// 详细地址
        addressTextField = UITextField(frame: CGRect(x: 0, y: addressSSQButton.frame.maxY + kMargin, width: textFieldW, height: textFieldH))
        addressTextField.backgroundColor = UIColor.white
        addressTextField.placeholder = kDetailedAddress
        addressTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        addressTextField.layer.cornerRadius = kRadius
        addressTextField.clipsToBounds = true
        addressTextField.layer.borderColor = rgbSameColor(193).cgColor
        addressTextField.layer.borderWidth = 0.5
        addressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        addressTextField.leftViewMode = UITextFieldViewMode.always
        addressTextField.textColor = rgb51
        addressTextField.font = font16
        addressTextField.delegate = self
        sexBirthCardAddressView.addSubview(addressTextField)

        sexBirthCardAddressView.frame.size.height = addressTextField.frame.maxY + viewMarginY
    }
    
    /********************* 选择性别（男、女） ******************/
    @objc private func sexButtonClicked() {
        
        // 退出键盘
        view.endEditing(true)
        
        // 避免遮挡，sexView移到最前面
        sexBirthCardAddressView.bringSubview(toFront: sexView)
        
        sexButton.isSelected = !sexButton.isSelected
        
        if sexButton.isSelected == true {
            sexView.layer.borderColor = appMainColor.cgColor
            sexView.frame.size.height = textFieldH*3
            sexButton.layer.borderColor = appMainColor.cgColor
            boyGirlButtonView.isHidden = false
        } else {
            sexView.layer.borderColor = rgbSameColor(193).cgColor
            sexView.frame.size.height = textFieldH
            sexButton.layer.borderColor = rgbSameColor(193).cgColor
            boyGirlButtonView.isHidden = true
        }
    }
    
    @objc fileprivate func boyGirlButtonClicked(btn: UIButton?) {
        
        if btn != nil {
            selectedSexButton?.isSelected = false
            btn!.isSelected = true
            selectedSexButton = btn
            sexButton.setTitle("  " + boyGirl[btn!.tag], for: .normal)
        }
        
        sexButton.isSelected = false
        sexView.layer.borderColor = rgbSameColor(193).cgColor
        sexView.frame.size.height = textFieldH
        sexButton.layer.borderColor = rgbSameColor(193).cgColor
        boyGirlButtonView.isHidden = true
    }
    
    
    /********************* 选择证件类型（身份证、护照） ******************/
    @objc private func cardTypeButtonClicked() {
        
        // 退出键盘
        view.endEditing(true)
        
        // 避免遮挡，cardTypeView移到最前面
        sexBirthCardAddressView.bringSubview(toFront: cardTypeView)
        
        cardTypeButton.isSelected = !cardTypeButton.isSelected
        
        if cardTypeButton.isSelected == true {
            cardTypeView.layer.borderColor = appMainColor.cgColor
            cardTypeView.frame.size.height = textFieldH*3
            cardTypeButton.layer.borderColor = appMainColor.cgColor
            IDPassportView.isHidden = false
        } else {
            cardTypeView.layer.borderColor = rgbSameColor(193).cgColor
            cardTypeView.frame.size.height = textFieldH
            cardTypeButton.layer.borderColor = rgbSameColor(193).cgColor
            IDPassportView.isHidden = true
        }
    }
    
    @objc fileprivate func IDPassportButtonClicked(btn: UIButton?) {
        
        if btn != nil {
            selectedCardTypeButton?.isSelected = false
            btn!.isSelected = true
            selectedCardTypeButton = btn
            cardTypeButton.setTitle("  " + IDPassport[btn!.tag], for: .normal)
            cardTypeButton.setTitleColor(rgb51, for: .normal)
        }
        
        cardTypeButton.isSelected = false
        cardTypeView.layer.borderColor = rgbSameColor(193).cgColor
        cardTypeView.frame.size.height = textFieldH
        cardTypeButton.layer.borderColor = rgbSameColor(193).cgColor
        IDPassportView.isHidden = true
    }
    

    
    
    
    
    
    
    // MARK:- 选择 省市区
    func addressSSQButtonClicked() {

        view.endEditing(true)
        
        addPickVw()
    }
    
    fileprivate func addPickVw() {
        if masking == nil {
            masking = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            masking?.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0.3)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(AddAddressController.cancleBtnClicked))
            masking?.addGestureRecognizer(tap)
        }
        if pickerVw == nil {
            pickerVw = UIView(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: pickerH))
            pickerVw?.backgroundColor = rgb244
            let tap = UITapGestureRecognizer(target: self, action: #selector(AddAddressController.doNothing))
            pickerVw?.addGestureRecognizer(tap)
            
            let topViewH: CGFloat = 44
            let topview = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: topViewH))
            topview.backgroundColor = UIColor.white
            pickerVw!.addSubview(topview)
            
            let btnW: CGFloat = 55
            let cancleBtn = UIButton(frame: CGRect(x: 0, y: 0, width: btnW, height: topViewH))
            cancleBtn.setTitle(kCancle, for: .normal)
            cancleBtn.setTitleColor(rgbColor(253, g: 119, b: 142), for: .normal)
            cancleBtn.titleLabel?.font = font16
            cancleBtn.addTarget(self, action: #selector(AddAddressController.cancleBtnClicked), for: .touchUpInside)
            pickerVw!.addSubview(cancleBtn)
            
            let btn = UIButton(frame: CGRect(x: kScreenWidth - btnW, y: 0, width: btnW, height: topViewH))
            btn.setTitle(kOver, for: .normal)
            btn.setTitleColor(rgbColor(253, g: 119, b: 142), for: .normal)
            btn.titleLabel?.font = font15
            btn.addTarget(self, action: #selector(AddAddressController.cityFinished), for: .touchUpInside)
            pickerVw!.addSubview(btn)
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: topview.frame.maxY, width: kScreenWidth, height: pickerH - topViewH))
            pickerView.delegate = self;
            pickerView.dataSource = self;
            pickerVw!.addSubview(pickerView)
            
            masking!.addSubview(self.pickerVw!)
        }
        
        view.addSubview(masking!)
        UIView.animate(withDuration: 0.25, animations: {
            self.masking!.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0.3)
            self.pickerVw!.frame.origin.y = kScreenHeight - self.pickerH
        })
    }
    
    // doNothing
    func doNothing() {
        
    }
    
    func cancleBtnClicked() {
        if self.pickerVw != nil {
            UIView.animate(withDuration: 0.25, animations: {
                self.pickerVw!.frame.origin.y = kScreenHeight
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.masking!.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0)
                        }, completion: { (_) in
                            self.masking!.removeFromSuperview()
                    })
            })
        }
    }
    
    func cityFinished() {
        let dic1 = provinceArr[provinceIndex] as! [String: AnyObject]
        let s1 = dic1["name"] as? String
        let dic2 = cityArr[cityIndex] as! [String: AnyObject]
        let s2 = dic2["name"] as? String
        let s3 = countyArr[countyIndex]
        addressSSQButton.setTitle("  " + s1! + " " + s2! + " " + s3, for: .normal)
        addressSSQButton.setTitleColor(rgb51, for: .normal)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.pickerVw!.frame.origin.y = kScreenHeight
            }, completion: { (_) in
                UIView.animate(withDuration: 0.25, animations: {
                    self.masking!.backgroundColor = rgbaColor(0, g: 0, b: 0, a: 0)
                    }, completion: { (_) in
                        self.masking!.removeFromSuperview()
                })
        }) 
    }
    
    

    
    
    
    
    
    
    
    // MARK:- 是否保卡、保卡类型
    private func seupCareCardView() {
       
        careCardView = UIView(frame: CGRect(x: kMargin, y: sexBirthCardAddressView.frame.maxY, width: textFieldW, height: keyLabelH))
        careCardView.clipsToBounds = true
        scrollView.addSubview(careCardView)
        
        let careCard = UIView(frame: CGRect(x: 0, y: 0, width: textFieldW, height: keyLabelH))
        careCardView.addSubview(careCard)
        
        let isHasCardLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 82, height: keyLabelH))
        isHasCardLabel.text = WhetherThereInsuranceCard
        isHasCardLabel.textColor = rgb102
        isHasCardLabel.font = font16
        careCard.addSubview(isHasCardLabel)
        
        let btnW: CGFloat = 40
        let yesButton = FullNameButton.init(frame: CGRect(x: isHasCardLabel.frame.maxX + btnW, y: 0, width: btnW, height: keyLabelH), text: kYES)
        yesButton.tag = 2
        yesButton.addTarget(self, action: #selector(AddPatientInfoController.isHasCardButton(btn:)), for: .touchUpInside)
        careCard.addSubview(yesButton)
        
        let noButton = FullNameButton.init(frame: CGRect(x: yesButton.frame.maxX + btnW, y: 0, width: btnW, height: keyLabelH), text: kNO)
        noButton.tag = 3
        noButton.addTarget(self, action: #selector(AddPatientInfoController.isHasCardButton(btn:)), for: .touchUpInside)
        careCard.addSubview(noButton)
        
        
        let cardTypeKey = UILabel(frame: CGRect(x: 0, y: careCard.frame.maxY + kMargin, width: 200, height: keyLabelH))
        cardTypeKey.text = kInsuranceType
        cardTypeKey.textColor = rgb102
        cardTypeKey.font = font16
        careCardView.addSubview(cardTypeKey)
        
        
//        insuranceTypeTextField = UITextField(frame: CGRect(x: 0, y: cardTypeKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
//        insuranceTypeTextField.backgroundColor = UIColor.white
//        insuranceTypeTextField.placeholder = kPleaseSelect
//        insuranceTypeTextField.clearButtonMode = UITextFieldViewMode.whileEditing
//        insuranceTypeTextField.layer.cornerRadius = kRadius
//        insuranceTypeTextField.clipsToBounds = true
//        insuranceTypeTextField.layer.borderColor = rgbSameColor(193).cgColor
//        insuranceTypeTextField.layer.borderWidth = 0.5
//        insuranceTypeTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
//        insuranceTypeTextField.leftViewMode = UITextFieldViewMode.always
//        insuranceTypeTextField.textColor = rgb51
//        insuranceTypeTextField.font = font16
//        insuranceTypeTextField.delegate = self
//        careCardView .addSubview(insuranceTypeTextField)
        
        
        insuranceTypeButton = UIButton(frame: CGRect(x: 0, y: cardTypeKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        insuranceTypeButton.backgroundColor = UIColor.white
        insuranceTypeButton.layer.borderColor = rgbSameColor(193).cgColor
        insuranceTypeButton.layer.borderWidth = 0.5
        insuranceTypeButton.layer.cornerRadius = kRadius
        insuranceTypeButton.clipsToBounds = true
        insuranceTypeButton.titleLabel?.font = font16
        insuranceTypeButton.contentHorizontalAlignment = .left
        insuranceTypeButton.addTarget(self, action: #selector(AddPatientInfoController.insuranceTypeButtonClicked), for: .touchUpInside)
        careCardView.addSubview(insuranceTypeButton)
        
        
        insuranceCardTextField = UITextField(frame: CGRect(x: 0, y: insuranceTypeButton.frame.maxY + kMargin, width: textFieldW, height: textFieldH))
        insuranceCardTextField.backgroundColor = UIColor.white
        insuranceCardTextField.placeholder = kInsuranceCardNumber
        insuranceCardTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        insuranceCardTextField.layer.cornerRadius = kRadius
        insuranceCardTextField.clipsToBounds = true
        insuranceCardTextField.layer.borderColor = rgbSameColor(193).cgColor
        insuranceCardTextField.layer.borderWidth = 0.5
        insuranceCardTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        insuranceCardTextField.leftViewMode = UITextFieldViewMode.always
        insuranceCardTextField.textColor = rgb51
        insuranceCardTextField.font = font16
        insuranceCardTextField.delegate = self
        insuranceCardTextField.keyboardType = .namePhonePad
        careCardView.addSubview(insuranceCardTextField)
    }
    
    /// 选择保险类型
    @objc private func insuranceTypeButtonClicked() {
        let vc = InsuranceTypeController()
        vc.addPatientInfoCtl = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func isHasCardButton(btn: FullNameButton) {
        selectedIsHasCardButton?.isSelected = false
        btn.isSelected = true
        selectedIsHasCardButton = btn
        
        /// 刷新控件，重新布局
        refreshSubviewsFrame(tag: btn.tag)
    }
    
    // MARK:- 父亲、母亲、Email、确认后就诊人信息只能去诊所进行更改
    private func seupParentsEmailTipView() {
        
        parentsEmailTipView = UIView(frame: CGRect(x: kMargin, y: careCardView.frame.maxY + viewMarginY, width: textFieldW, height: 100))
        scrollView.addSubview(parentsEmailTipView)
        
        
        let fatherKey = UILabel(frame: CGRect(x: 0, y: 0, width: textFieldW, height: keyLabelH))
        fatherKey.text = kFather
        fatherKey.textColor = rgb102
        fatherKey.font = font16
        parentsEmailTipView.addSubview(fatherKey)
        
        fatherNameTextField = UITextField(frame: CGRect(x: 0, y: fatherKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        fatherNameTextField.backgroundColor = UIColor.white
        fatherNameTextField.placeholder = kName
        fatherNameTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        fatherNameTextField.layer.cornerRadius = kRadius
        fatherNameTextField.clipsToBounds = true
        fatherNameTextField.layer.borderColor = rgbSameColor(193).cgColor
        fatherNameTextField.layer.borderWidth = 0.5
        fatherNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        fatherNameTextField.leftViewMode = UITextFieldViewMode.always
        fatherNameTextField.textColor = rgb51
        fatherNameTextField.font = font16
        fatherNameTextField.delegate = self
        parentsEmailTipView.addSubview(fatherNameTextField)
        
        fatherPhoneTextField = UITextField(frame: CGRect(x: 0, y: fatherNameTextField.frame.maxY + kMargin, width: textFieldW, height: textFieldH))
        fatherPhoneTextField.backgroundColor = UIColor.white
        fatherPhoneTextField.placeholder = kTelePhone
        fatherPhoneTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        fatherPhoneTextField.layer.cornerRadius = kRadius
        fatherPhoneTextField.clipsToBounds = true
        fatherPhoneTextField.layer.borderColor = rgbSameColor(193).cgColor
        fatherPhoneTextField.layer.borderWidth = 0.5
        fatherPhoneTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        fatherPhoneTextField.leftViewMode = UITextFieldViewMode.always
        fatherPhoneTextField.textColor = rgb51
        fatherPhoneTextField.font = font16
        fatherPhoneTextField.delegate = self
        fatherPhoneTextField.keyboardType = .phonePad
        parentsEmailTipView.addSubview(fatherPhoneTextField)
        
        let motherKey = UILabel(frame: CGRect(x: 0, y: fatherPhoneTextField.frame.maxY + kMargin, width: textFieldW, height: keyLabelH))
        motherKey.text = kMother
        motherKey.textColor = rgb102
        motherKey.font = font16
        parentsEmailTipView.addSubview(motherKey)
        
        motherNameTextField = UITextField(frame: CGRect(x: 0, y: motherKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        motherNameTextField.backgroundColor = UIColor.white
        motherNameTextField.placeholder = kName
        motherNameTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        motherNameTextField.layer.cornerRadius = kRadius
        motherNameTextField.clipsToBounds = true
        motherNameTextField.layer.borderColor = rgbSameColor(193).cgColor
        motherNameTextField.layer.borderWidth = 0.5
        motherNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        motherNameTextField.leftViewMode = UITextFieldViewMode.always
        motherNameTextField.textColor = rgb51
        motherNameTextField.font = font16
        motherNameTextField.delegate = self
        parentsEmailTipView.addSubview(motherNameTextField)
        
        motherPhoneTextField = UITextField(frame: CGRect(x: 0, y: motherNameTextField.frame.maxY + kMargin, width: textFieldW, height: textFieldH))
        motherPhoneTextField.backgroundColor = UIColor.white
        motherPhoneTextField.placeholder = kTelePhone
        motherPhoneTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        motherPhoneTextField.layer.cornerRadius = kRadius
        motherPhoneTextField.clipsToBounds = true
        motherPhoneTextField.layer.borderColor = rgbSameColor(193).cgColor
        motherPhoneTextField.layer.borderWidth = 0.5
        motherPhoneTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        motherPhoneTextField.leftViewMode = UITextFieldViewMode.always
        motherPhoneTextField.textColor = rgb51
        motherPhoneTextField.font = font16
        motherPhoneTextField.delegate = self
        motherPhoneTextField.keyboardType = .phonePad
        parentsEmailTipView.addSubview(motherPhoneTextField)
        
        let emailKey = UILabel(frame: CGRect(x: 0, y: motherPhoneTextField.frame.maxY + viewMarginY, width: textFieldW, height: keyLabelH))
        emailKey.text = "Email"
        emailKey.textColor = rgb102
        emailKey.font = font16
        parentsEmailTipView.addSubview(emailKey)
        
        emailTextField = UITextField(frame: CGRect(x: 0, y: emailKey.frame.maxY + 6, width: textFieldW, height: textFieldH))
        emailTextField.backgroundColor = UIColor.white
        emailTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        emailTextField.layer.cornerRadius = kRadius
        emailTextField.clipsToBounds = true
        emailTextField.layer.borderColor = rgbSameColor(193).cgColor
        emailTextField.layer.borderWidth = 0.5
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: kMargin, height: 0))
        emailTextField.leftViewMode = UITextFieldViewMode.always
        emailTextField.textColor = rgb51
        emailTextField.font = font16
        emailTextField.delegate = self
        emailTextField.keyboardType = .emailAddress
        parentsEmailTipView.addSubview(emailTextField)
        
        let tipY: CGFloat = emailTextField.frame.maxY + 20
        let tipLabelH: CGFloat = 20
        let tipIconWH: CGFloat = 6
        let tipIconY: CGFloat = (tipLabelH - tipIconWH)/2 + tipY
        let tipIcon = UIView(frame: CGRect(x: 0, y: tipIconY, width: tipIconWH, height: tipIconWH))
        tipIcon.layer.cornerRadius = tipIconWH/2
        tipIcon.clipsToBounds = true
        tipIcon.backgroundColor = appMainColor
        parentsEmailTipView.addSubview(tipIcon)

        let tipLabelX = tipIcon.frame.maxX + 8
        let tipLabelW = textFieldW - tipLabelX
        let tipLabel = UILabel(frame: CGRect(x: tipLabelX, y: tipY, width: tipLabelW, height: tipLabelH))
        tipLabel.text = kgoToTheClinicToChangeTip
        tipLabel.textColor = rgb50
        tipLabel.font = font16
        parentsEmailTipView.addSubview(tipLabel)
        
        parentsEmailTipView.frame.size.height = tipLabel.frame.maxY + 20

        scrollView.contentSize = CGSize(width: 0, height: parentsEmailTipView.frame.maxY
        )
    }
}



extension AddPatientInfoController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       
        if sexButton.isSelected == true {
            boyGirlButtonClicked(btn: nil)
        }
        
        if cardTypeButton.isSelected == true {
            IDPassportButtonClicked(btn: nil)
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = appMainColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = rgbColor(208, g: 190, b: 185).cgColor
    }
}



extension AddPatientInfoController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0 == component ? self.provinceArr.count : (1 == component ? self.cityArr.count : self.countyArr.count);
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if 0 == component {
            provinceIndex = row
            cityIndex = 0
            countyIndex = 0
            
            // 滚动省份，替换城市、区县数组
            reloadCityDatas()
            reloadCountyDatas()
            
            // 刷新
            pickerView.reloadAllComponents()
            
            // 滚动省份，让城市、区县默认选择第0个
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        } else if 1 == component {
            cityIndex = row
            countyIndex = 0
            
            // 滚动城市，替换区县数组
            reloadCityDatas()
            reloadCountyDatas()
            
            // 刷新
            pickerView.reloadAllComponents()
            
            // 滚动城市，让区县默认选择第0个
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        } else {
            countyIndex = row
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth/3, height: 44))
        lbl.font = font15
        lbl.textColor = rgb50
        lbl.textAlignment = .center
        
        switch component {
        case 0:
            provinceIndex = row;
            let dic = provinceArr[row] as! [String: AnyObject]
            lbl.text = dic["name"] as? String
        case 1:
            cityIndex = row;
            let dic = self.cityArr[row] as! [String: AnyObject]
            lbl.text = dic["name"] as? String
        default:
            countyIndex = row
            lbl.text = self.countyArr[row];
        }
        return lbl;
    }
}

