//
//  UIBarButtonItem+Extion.swift
//  XLWBSwift20160314
//
//  Created by whj on 16/3/24.
//  Copyright © 2016年 mifengyiliao. All rights reserved.
//

import UIKit

/// 分类
extension UIBarButtonItem {
    
    // MARK: - 类方法
    class func creatCustomBarButtonItem(_ imageSting: String, target: AnyObject?, actionName: String) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageSting), for: .normal)
        btn.setImage(UIImage(named: imageSting + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        btn.addTarget(target, action: Selector(actionName), for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    
    // MARK: - 便利构造器
    // 被convenience修饰过的构造方法，我们都称之为：便利构造方法
    // 普通构造方法是一级方法，便利构造方法是二级构造方法
    // 便利构造方法必须调用self.init方法
    convenience init(imageSting: String, target: AnyObject?, actionName: String) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageSting), for: .normal)
        btn.setImage(UIImage(named: imageSting + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        btn.addTarget(target, action: Selector(actionName), for: .touchUpInside)
        self.init(customView: btn)
    }
}
