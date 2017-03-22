//
//  ILDDateHelper.h
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILDDateHelper : NSObject

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;



+ (NSString *)stringOfDay:(NSDate *)date;
+ (NSString *)stringOfHour:(NSDate *)date;
+ (NSString *)stringOfWeekday:(NSDate *)date;


@end
