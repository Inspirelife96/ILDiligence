//
//  ILDStatisticsHistoryModel.h
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/22.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILDStatisticsHistoryModel : NSObject

@property (nonatomic, strong) NSNumber *diligenceTimesInTotal;
@property (nonatomic, strong) NSNumber *diligenceHoursInTotal;
@property (nonatomic, strong) NSNumber *diligenceDaysInTotal;

@property (nonatomic, strong) NSString *bestWeekday;
@property (nonatomic, strong) NSString *bestHour;
@property (nonatomic, strong) NSString *bestTask;

@property (nonatomic, strong) NSNumber *bestWeekdayPlus;
@property (nonatomic, strong) NSNumber *bestHourPlus;
@property (nonatomic, strong) NSNumber *everageMinutes;

@property (nonatomic, strong) NSArray  *dataForPieChartArray;
@property (nonatomic, strong) NSArray  *dataForBarChartArray;


@end
