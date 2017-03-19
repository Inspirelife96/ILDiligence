//
//  ILDPersistanceConstants.m
//  ILDPersistenceLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - task data column keys

NSString *const kTaskDataName               = @"name";
NSString *const kTaskDataColor              = @"color";
NSString *const kTaskDataMusicName          = @"musicName";
NSString *const kTaskDataDiligenceTime      = @"diligenceTime";
NSString *const kTaskDataRestTime           = @"restTime";
NSString *const kTaskDataIsFocusModeEnabled = @"isFocusModeEnabled";
NSString *const kTaskDataIsRestModeEnabled  = @"isRestModeEnabled";
NSString *const kTaskDataIsMusicModeEnabled = @"isMusicModeEnabled";
NSString *const kTaskDataIsAlertModeEnabled = @"isAlertModeEnabled";
NSString *const kTaskDataAlertTime          = @"alertTime";

#pragma mark - diligence data column keys

NSString *const kDiligenceDataTaskId        = @"taskId";
NSString *const kDiligenceDataStartDate     = @"startDate";
NSString *const kDiligenceDataEndDate       = @"endDate";
NSString *const kDiligenceDataBreakTimes    = @"breakTimes";
NSString *const kDiligenceDataDiligenceTime = @"diligenceTime";

#pragma mark - story data column keys

NSString *const kStoryDataDate              = @"date";
NSString *const kStoryDataTitle             = @"title";
NSString *const kStoryDataAttribute         = @"attribute";
NSString *const kStoryDataPara1             = @"para1";
NSString *const kStoryDataImageData         = @"imageData";
