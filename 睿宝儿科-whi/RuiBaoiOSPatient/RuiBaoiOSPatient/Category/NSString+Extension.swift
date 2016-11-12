//
//  NSString+Extension.swift
//  XLWBSwift20160314
//
//  Created by whj on 16/3/24.
//  Copyright © 2016年 mifengyiliao. All rights reserved.
//

// MARK: - 全局变量！！！
var kRetainString: String?

import UIKit

extension NSString {
    
    /// MARK: - 返回内容的实际高度（含行间距）
    func calculateTheHeightOfTheString(_ font: UIFont, width: CGFloat, margin: CGFloat, maxRow: Int) -> CGFloat {
        
        var mar: CGFloat = margin
        if mar == 0 {
            mar = 6.0 // 默认值
        }
        
        // 1. 单行高度
        let rowHeight: CGFloat = CGFloat("好好好".calculateTheSizeOfTheString(font, maxWidth: width).height)
        LLog(rowHeight)
        // 2. 总高度（不加行高）
        let contentHeight: CGFloat  = CGFloat(self.calculateTheSizeOfTheString(font, maxWidth: width).height)
        LLog(contentHeight)
        // 3. 总的行数
        let numberRow: Int  = (Int)((contentHeight + 8)/rowHeight)
        LLog(numberRow)
        // 4. 实际总高度（加行高）
        var actualHeight: CGFloat  = contentHeight + CGFloat(numberRow)*mar
        LLog(actualHeight)
        // 5. 根据需求，确定最终值
        LLog(maxRow)
        if maxRow > 0 {
            let maxHeight: CGFloat = (rowHeight + mar)*CGFloat(maxRow)
            if (actualHeight > maxHeight) {
                actualHeight = maxHeight
            }
        }
        LLog(actualHeight)
        return actualHeight
    }
    
    // MARK: - 计算文字的尺寸
    func calculateTheSizeOfTheString(_ font: UIFont, maxWidth: CGFloat) -> CGSize {
        let maxSize: CGSize = CGSize(width: CGFloat(maxWidth), height: CGFloat(MAXFLOAT))
        let attrs: Dictionary<String, UIFont> = [NSFontAttributeName : font]
        return self.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil).size
    }

    // MARK: - 计算文字的尺寸
    func calculateTheSizeOfString(_ font: UIFont, maxSize: CGSize) -> CGSize {
        let attrs: Dictionary<String, UIFont> = [NSFontAttributeName : font]
        return self.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil).size
    }
    
    // MARK: - 去除字符创两端的空格、回车键
    /**
     * 如：" faksdjf  \n  \n    "
     * 最终结果是："faksdjf"
     */
    class func removeSpaceAndEnterKeyWithContent(_ string: String) -> String {
        // 去除两端空格
        kRetainString = string.trimmingCharacters(in: CharacterSet.whitespaces)
        // 去除字符串前端的回车键、后端的回车键
        removeEnterKeyWithContent()
        if kRetainString!.characters.count == 0 {
            return kPlaceText
        }
        return kRetainString!
    }
    
    class func removeEnterKeyWithContent() {
        // 去除字符串前端的回车键
        removePrefixEnterKeyWithContent()
        // 去除字符串后端的回车键
        removeSuffixEnterKeyWithContent()
    }
    
    // MARK: - 去除字符串前端的回车键
    class func removePrefixEnterKeyWithContent()  {
        if kRetainString!.hasPrefix("\n") || kRetainString!.hasPrefix("\r") {
            // 从第几个字符开始
            let start = kRetainString!.characters.index(kRetainString!.startIndex, offsetBy: 1)
            // ！！！从字符结尾去掉几个 ！！！
            let end = kRetainString!.characters.index(kRetainString!.endIndex, offsetBy: 0)
            let range = start..<end
//            let range = Range<String.Index>(start: start, end: end)
            kRetainString = kRetainString!.substring(with: range)
            
            // 下面一行不可删除（去除两端空格）
            kRetainString = kRetainString!.trimmingCharacters(in: CharacterSet.whitespaces)
            removePrefixEnterKeyWithContent()
        }
    }
    
    // MARK: - 去除字符串后端的回车键
    class func removeSuffixEnterKeyWithContent() {
        if kRetainString!.hasSuffix("\n") || kRetainString!.hasSuffix("\r") {
            let start = kRetainString!.characters.index(kRetainString!.startIndex, offsetBy: 0)
            let end = kRetainString!.characters.index(kRetainString!.endIndex, offsetBy: -1)

//            let range = Range(start: start, end: end)
            let range = start..<end
            kRetainString! = kRetainString!.substring(with: range)
            
            // 下面一行不可删除（去除两端空格）
            kRetainString = kRetainString!.trimmingCharacters(in: CharacterSet.whitespaces)
            removeSuffixEnterKeyWithContent()
        }
    }
}
