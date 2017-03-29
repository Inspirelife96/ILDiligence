//
//  ILDStatisticsTodayModel+IL_OperationsForViewData.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsTodayModel+IL_OperationsForViewData.h"

@implementation ILDStatisticsTodayModel (IL_OperationsForViewData)

- (NSString *)il_diligenceTimesValue {
    return [self.diligenceTimes stringValue];
}

- (NSString *)il_diligenceHoursValue {
    double diligenceHoursValue = [self.diligenceHours doubleValue];
    return [NSString stringWithFormat:@"%.01f", diligenceHoursValue];
}

- (NSString *)il_diligenceFocusValue {
    return [self.diligenceFocusPercentage stringValue];
}

- (NSString *)il_diligenceTimesTitle {
    return @"专注次数";
}

- (NSString *)il_diligenceHoursTitle {
    return @"专注小时";
}

- (NSString *)il_diligenceFocusTitle {
    return @"专注程度";
}

- (UIImage *)il_diligenceTimesIcon {
    return [UIImage imageNamed:@"redfire_30x30_"];
}

- (UIImage *)il_diligenceHoursIcon {
    return [UIImage imageNamed:@"yellowclock_30x30_"];
}

- (UIImage *)il_diligenceFocusIcon {
    return [UIImage imageNamed:@"greenheart_30x30_"];
}


@end
