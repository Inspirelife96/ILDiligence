//
//  ILDDateHelper.h
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ILDDateHelper : NSObject

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

+ (NSString *)stringOfDay:(NSDate *)date;
+ (NSString *)stringOfHour:(NSDate *)date;
+ (NSString *)stringOfWeekday:(NSDate *)date;
+ (NSString *)stringOfDayWithWeekDay:(NSDate *)date;

+ (NSString *)minutesFormatBySeconds:(CGFloat)seconds;

+ (NSArray *)weekDaysList;
+ (NSArray *)monthList;
+ (NSArray *)hourList;

+ (NSString *)weekDaysName:(NSInteger)index;

+ (NSArray *)diligenceTimeList;
+ (NSArray *)diligenceTimeType;

+ (NSArray *)restTimeList;
+ (NSArray *)restTimeType;

+ (NSArray *)alertHourList;
+ (NSArray *)alertMinuteList;

+ (NSString *)dateToString:(NSDate *)date withForamt:(NSString *)format;
+ (NSDate *)stringToDate:(NSString *)dateString withForamt:(NSString *)format;

@end
