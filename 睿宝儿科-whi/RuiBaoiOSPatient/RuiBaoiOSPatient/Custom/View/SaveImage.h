//
//  SaveImage.h
//  RuiBaoiOSPatient
//
//  Created by whj on 16/11/4.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SaveImage : NSObject

+ (void)saveImage:(UIImage *)image andImageName: (NSString *)imageString;
+ (UIImage *)getImageWithImageName: (NSString *)imageString;

@end
