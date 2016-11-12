//
//  CustomUMFile.h
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/27.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomUMFile : NSObject

+ (void)setupCustomUMFileWithCurrentVC:(UIViewController *)vc title: (NSString *)title content: (NSString *)content img: (UIImage *)img url: (NSString *)url toType: (NSString *)type;

@end
