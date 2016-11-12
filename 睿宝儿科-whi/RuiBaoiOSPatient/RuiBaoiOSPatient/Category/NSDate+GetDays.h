//
//  NSDate+GetDays.h
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GetDays)

// 这个月有几天
+ (int)totalDaysInThisMonth:(NSDate *)date;

// 第一天是周几
+ (int)firstWeekdayInThisMonth:(NSDate *)date;

@end
