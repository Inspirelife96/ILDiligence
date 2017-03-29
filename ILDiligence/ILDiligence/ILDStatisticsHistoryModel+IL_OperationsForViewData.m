//
//  ILDStatisticsHistoryModel+IL_OperationsForViewData.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/29.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsHistoryModel+IL_OperationsForViewData.h"

@implementation ILDStatisticsHistoryModel (IL_OperationsForViewData)

- (NSString *)il_diligenceTimesValue {
    return [self.diligenceTimesInTotal stringValue];
}

- (NSString *)il_diligenceHoursValue {
    double diligenceHours = [self.diligenceHoursInTotal doubleValue];
    return [NSString stringWithFormat:@"%.01f", diligenceHours];
}

- (NSString *)il_diligenceDaysValue {
    return [self.diligenceDaysInTotal stringValue];
}

- (NSString *)il_diligenceTimesTitle {
    return @"总专注数";
}

- (NSString *)il_diligenceHoursTitle {
    return @"总专注小时";
}

- (NSString *)il_diligenceDaysTitle {
    return @"专注天数";
}

- (NSString *)il_bestWeekdayPlusString {
    return [NSString stringWithFormat:@"比平常多%@%%", self.bestWeekdayPlus];
}

- (NSString *)il_bestHourPlusString {
    return [NSString stringWithFormat:@"比平常多%@%%", self.bestHourPlus];
}

- (NSString *)il_everageMinutesString {
    return [NSString stringWithFormat:@"日均专注%@分钟", self.everageMinutes];
}

@end
