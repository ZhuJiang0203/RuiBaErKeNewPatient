//
//  MedicalRecord.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/29.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class MedicalRecord: NSObject {

    var patientID = "" // 用户id
    var patientIcon = ""
    var name = ""
    var age = ""
    var dob = "" // 出生日期
    var sex = ""
    var medicalRecordNumber = "" // 病历号
    
    class func setupPatientsWithDictionarys(_ patients: [NSDictionary]) -> [MedicalRecord] {
        var models: [MedicalRecord] = Array()
        
        for i in 0..<patients.count {
            let dict = patients[i]
            LLog(dict)
            
            let patient = MedicalRecord()
            
            if let patientDic = dict["patient"] as? Dictionary<String, AnyObject> {
                if let patientID = patientDic["patientId"] as? NSNumber {
                    patient.patientID = patientID.stringValue
                }
                if let headFileId = patientDic["headFileId"] as? NSNumber {
                    patient.patientIcon = kBaseUrlString + "files/\(headFileId)/ran.jpg"
                }
                
                let isEnglish = ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental()
                if isEnglish == true { // 英文环境
                    // 英文名
                    if let givenName = patientDic["givenName"] as? String {
                        patient.name = givenName
                    }
                    // 英文姓
                    if let familyName = patientDic["familyName"] as? String {
                        patient.name = patient.name + " " + familyName
                    }
                    if patient.name.characters.count == 0 || patient.name == " " {
                        // 中文姓
                        if let familyNameCn = patientDic["familyNameCn"] as? String {
                            patient.name = familyNameCn
                        }
                        // 中文名
                        if let givenNameCn = patientDic["givenNameCn"] as? String {
                            patient.name = patient.name + givenNameCn
                        }
                    }
                } else { // 中文环境
                    // 中文姓
                    if let familyNameCn = patientDic["familyNameCn"] as? String {
                        patient.name = familyNameCn
                    }
                    // 中文名
                    if let givenNameCn = patientDic["givenNameCn"] as? String {
                        patient.name = patient.name + givenNameCn
                    }
                    
                    if patient.name.characters.count == 0 {
                        // 英文名
                        if let givenName = patientDic["givenName"] as? String {
                            patient.name = givenName
                        }
                        // 英文姓
                        if let familyName = patientDic["familyName"] as? String {
                            patient.name = patient.name + " " + familyName
                        }
                    }
                }
                if let age = patientDic["age"] as? NSNumber {
                    patient.age = age.stringValue
                }
                // 出生日期
                if let dob = patientDic["dob"] as? String {
                    patient.dob = dob
                }
                if let sex = patientDic["sex"] as? String {
                    patient.sex = sex == "F" ? kFemale : kMale
                }
                if let mrn = patientDic["mrn"] as? String {
                    patient.medicalRecordNumber = mrn
                }
            }
            
            models.append(patient)
        }
        return models
    }
    
    class func setupPatients(_ patientDic: NSDictionary) -> MedicalRecord {
        let patient = MedicalRecord()
        
        // 患者id
        if let patientID = patientDic["patientId"] as? NSNumber {
            patient.patientID = patientID.stringValue
        }
        
        // 头像（待完成）
        if let headFileId = patientDic["headFileId"] as? NSNumber {
            patient.patientIcon = kBaseUrlString + "files/\(headFileId)/ran.jpg"
            //            patient.patientIcon = kBaseUrlString + "headFiles/63/ran.jpg"
        }
        
        // 患者姓名
        if let patientName = patientDic["patientName"] as? String {
            patient.name = patientName
        }
        
        // 患者年龄
        if let age = patientDic["patientAge"] as? NSNumber {
            patient.age = age.stringValue
        }
        
        // 患者出生日期(待完成)
        if let dob = patientDic["dob"] as? String {
            patient.dob = dob
        }
        
        // 患者性别
        if let sex = patientDic["patientSex"] as? String {
            patient.sex = sex == "F" ? "\(kFemale)" : "\(kMale)"
        }
        
        // 病历号
        if let mrn = patientDic["mrn"] as? String {
            patient.medicalRecordNumber = mrn
        }
        
        
        return patient
    }
    
    class func setupPMSPatients(_ patientDic: NSDictionary) -> MedicalRecord {
        let patient = MedicalRecord()
        
        // 患者id
        if let patientID = patientDic["patientId"] as? NSNumber {
            patient.patientID = patientID.stringValue
        }
        
        // 头像（待完成）
        if let patientIcon = patientDic["patientIcon"] as? NSNumber {
            patient.patientIcon = kBaseUrlString + "headFiles/\(patientIcon)/ran.jpg"
            patient.patientIcon = kBaseUrlString + "headFiles/63/ran.jpg"
        }
        
        // 患者姓名
        let isEnglish = ChangeLanguage.shareChangeLanguage().isEnglishEnvironmental()
        if isEnglish == true { // 英文环境
            // 英文名
            if let givenName = patientDic["givenName"] as? String {
                patient.name = givenName
            }
            // 英文姓
            if let familyName = patientDic["familyName"] as? String {
                patient.name = patient.name + " " + familyName
            }
            if patient.name.characters.count == 0 || patient.name == " " {
                // 中文姓
                if let familyNameCn = patientDic["familyNameCn"] as? String {
                    patient.name = familyNameCn
                }
                // 中文名
                if let givenNameCn = patientDic["givenNameCn"] as? String {
                    patient.name = patient.name + givenNameCn
                }
            }
        } else { // 中文环境
            // 中文姓
            if let familyNameCn = patientDic["familyNameCn"] as? String {
                patient.name = familyNameCn
            }
            // 中文名
            if let givenNameCn = patientDic["givenNameCn"] as? String {
                patient.name = patient.name + givenNameCn
            }
            
            if patient.name.characters.count == 0 {
                // 英文名
                if let givenName = patientDic["givenName"] as? String {
                    patient.name = givenName
                }
                // 英文姓
                if let familyName = patientDic["familyName"] as? String {
                    patient.name = patient.name + " " + familyName
                }
            }
        }
        
        // 患者年龄
        if let age = patientDic["age"] as? NSNumber {
            patient.age = age.stringValue
        }
        
        // 患者出生日期
        if let dob = patientDic["dob"] as? String {
            patient.dob = dob
        }
        
        // 患者性别
        if let sex = patientDic["sex"] as? String {
            patient.sex = sex == "F" ? "\(kFemale)" : "\(kMale)"
        }
        
        // 病历号
        if let mrn = patientDic["mrn"] as? String {
            patient.medicalRecordNumber = mrn
        }
        
        return patient
    }

}
