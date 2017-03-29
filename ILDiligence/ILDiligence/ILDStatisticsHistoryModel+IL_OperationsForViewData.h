//
//  ILDStatisticsHistoryModel+IL_OperationsForViewData.h
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/29.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <ILDBusinessLogicLayer/ILDBusinessLogicLayer.h>

@interface ILDStatisticsHistoryModel (IL_OperationsForViewData)

- (NSString *)il_diligenceTimesValue;
- (NSString *)il_diligenceHoursValue;
- (NSString *)il_diligenceDaysValue;

- (NSString *)il_diligenceTimesTitle;
- (NSString *)il_diligenceHoursTitle;
- (NSString *)il_diligenceDaysTitle;

- (NSString *)il_bestWeekdayPlusString;
- (NSString *)il_bestHourPlusString;
- (NSString *)il_everageMinutesString;

@end
