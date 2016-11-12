//
//  UIImage+PhotoSelectView.swift
//  11-布局图片选择器
//
//  Created by apple on 15/10/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//
//  绘制新图片（减少内存，提高性能）

import UIKit

extension UIImage {
    // 宽 <= 高
    func scaleImageWithWidth(_ width: CGFloat) -> UIImage {
        // 1. 根据宽度获得高度
        let h = width*self.size.height/self.size.width
        // 2. 获得图片
        return scaleImage(width, height: h)
    }
    
    // 高 <= 宽
    func scaleImageWithHeight(_ height: CGFloat) -> UIImage {
        // 1.按照指定的宽度等比缩放图片
        let w = height*self.size.width/self.size.height
        // 2. 获得图片
        return scaleImage(w, height: height)
    }
    
    fileprivate func scaleImage(_ width: CGFloat, height: CGFloat) -> UIImage {
        // 1. 绘制图片
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // 2.返回图片
        return newImage!
    }
    
    // MARK:-  iOS拍照之后图片自动旋转90度解决办法： 
    class func fixOrientation(_ aImage: UIImage) -> UIImage {
        if aImage.imageOrientation == UIImageOrientation.up {
            return aImage
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch aImage.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))

        default:
            LLog("")
        }
        
        
        switch aImage.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: aImage.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        default:
            LLog("")
        }
        
        let ctx = CGContext(data: nil,
                                        width: Int(aImage.size.width),
                                        height: Int(aImage.size.height),
                                        bitsPerComponent: (aImage.cgImage?.bitsPerComponent)!,
                                        bytesPerRow: 0,
                                        space: (aImage.cgImage?.colorSpace)!,
                                        bitmapInfo: (aImage.cgImage?.bitmapInfo.rawValue)!)
        ctx?.concatenate(transform)
        
        switch (aImage.imageOrientation) {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(aImage.cgImage!, in: CGRect(x: 0, y: 0, width: aImage.size.height,height: aImage.size.width))
        default:
            ctx?.draw(aImage.cgImage!, in: CGRect(x: 0, y: 0, width: aImage.size.width,height: aImage.size.height))
        }
        
        let cgimg = ctx?.makeImage()
        return UIImage(cgImage: cgimg!)
    }
}
