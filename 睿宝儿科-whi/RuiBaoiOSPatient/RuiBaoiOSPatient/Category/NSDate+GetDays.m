//
//  NSDate+GetDays.m
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/28.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

#import "NSDate+GetDays.h"

@implementation NSDate (GetDays)

// 这个月有几天
+ (int)totalDaysInThisMonth:(NSDate *)date {
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return (int)totaldaysInMonth.length;
}

// 第一天是周几
+ (int)firstWeekdayInThisMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return (int)firstWeekday - 1;
}

@end
