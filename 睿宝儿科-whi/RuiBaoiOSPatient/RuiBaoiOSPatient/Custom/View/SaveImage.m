//
//  SaveImage.m
//  RuiBaoiOSPatient
//
//  Created by whj on 16/11/4.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

#import "SaveImage.h"

@implementation SaveImage

+ (void)saveImage:(UIImage *)image andImageName: (NSString *)imageString {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_%@.png", imageString]];   // 保存文件的名称
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];

}

+ (UIImage *)getImageWithImageName: (NSString *)imageString {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_%@.png", imageString]];   // 保存文件的名称
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    
    return img;
}

@end
