//
//  ILDDateHelper.m
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDDateHelper.h"

@implementation ILDDateHelper

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return (([comp1 day] == [comp2 day]) &&
            ([comp1 month] == [comp2 month]) &&
            ([comp1 year] == [comp2 year]));
}


+ (NSArray *)weekDaysList {
    return @[
             @"星期日",
             @"星期一",
             @"星期二",
             @"星期三",
             @"星期四",
             @"星期五",
             @"星期六",
             ];
}

+ (NSArray *)hourList {
    return @[
             @"凌晨00:00",
             @"凌晨10:00",
             @"凌晨20:00",
             @"凌晨30:00",
             @"凌晨40:00",
             @"凌晨50:00",
             @"凌晨60:00",
             @"上午70:00",
             @"上午80:00",
             @"上午90:00",
             @"上午10:00",
             @"上午11:00",
             @"上午12:00",
             @"下午13:00",
             @"下午14:00",
             @"下午15:00",
             @"下午16:00",
             @"下午17:00",
             @"下午18:00",
             @"夜晚19:00",
             @"夜晚20:00",
             @"夜晚21:00",
             @"夜晚22:00",
             @"夜晚23:00",
             @"夜晚24:00",
             ];
}

+ (NSArray *)monthList {
    return @[
             @"1 月",
             @"2 月",
             @"3 月",
             @"4 月",
             @"5 月",
             @"6 月",
             @"7 月",
             @"8 月",
             @"9 月",
             @"10月",
             @"11月",
             @"12月",
             ];
}

+ (NSString *)stringOfDay:(NSDate *)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents* comp = [calendar components:unitFlags fromDate:date];
    NSString *monthString = [ILDDateHelper monthList][[comp month] - 1];
    return [NSString stringWithFormat:@"%ld %@ %ld 日", (long)[comp year] , monthString, [comp day]];
}

+ (NSString *)stringOfHour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:date];
    return [[ILDDateHelper hourList] objectAtIndex:[components hour]];
    
}

+ (NSString *)stringOfWeekday:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    return [[ILDDateHelper hourList] objectAtIndex:([components weekday] - 1)];
}

+ (NSString *)stringOfDayWithWeekDay:(NSDate *)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents* comp = [calendar components:unitFlags fromDate:date];
    NSString *monthString = [ILDDateHelper monthList][[comp month] - 1];
    NSString *weekdayString = [ILDDateHelper weekDaysList][[comp weekday] - 1];
    return [NSString stringWithFormat:@"%@ %ld %@ %ld", monthString, (long)[comp day], weekdayString, [comp year]];
}

+ (NSString *)minutesFormatBySeconds:(CGFloat)seconds {
    NSInteger second = (NSInteger)ceil(seconds) % 60;
    NSInteger minute = (NSInteger)ceil(seconds) / 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minute, second];
}

+ (NSString *)weekDaysName:(NSInteger)index {
    return [[ILDDateHelper weekDaysList] objectAtIndex:index - 1];
}

@end
