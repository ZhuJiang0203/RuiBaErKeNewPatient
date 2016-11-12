//
//  Goods.swift
//  RuiBaoiOSPatient
//
//  Created by whj on 16/9/29.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class Goods: NSObject {
    
    // 商品ID
    var goodsId = ""
    // 商品名称
    var goodsName = ""
    // 商品图片id、商品图片url
    var goodsImageId = ""
    var goodsImageString = ""
    // 广告图片id
    var advertisementImageId = ""
    // 商品价格
    var price = 0.0
    // 库存数量
    var stock = 0
    // 限购数量
    var limitNumber = 0
    // 是否首页
    var homePage = false
    // 上架时间
    var shelvesTime = ""
    // 商品描述
    var desc = ""
    // 是否虚拟商品
    var fictitious = true
    // 是否可自取
    var pickUp = true
    // 自取货地址
    var pickUpAddress = ""
}
