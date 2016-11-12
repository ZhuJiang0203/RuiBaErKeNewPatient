
//
//  Article.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class Article: NSObject {
    
    /// 文章id
    var articleId = ""
    /// 文章头像id
    var fileId = ""
    /// 文章标题
    var title = ""
    /// 文章url
    var url = ""
    /// 文章标签
    var label = ""
    /// 是否是精华文章 1是，2是一般
    var isEssence = ""
    /// 是否收藏
    var focus = false

    /// 作者
    var author = ""
    /// 医生id
    var doctorId = ""
    /// 科室
    var department = ""
    /// 职称
    var profession = ""
}
