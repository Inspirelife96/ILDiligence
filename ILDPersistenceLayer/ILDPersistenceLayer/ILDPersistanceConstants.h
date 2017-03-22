//
//  ILDPersistanceConstants.h
//  ILDPersistenceLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#ifndef ILDPersistanceConstants_h
#define ILDPersistanceConstants_h

#pragma mark - task data column keys

extern NSString *const kTaskDataName;
extern NSString *const kTaskDataColor;
extern NSString *const kTaskDataMusicName;
extern NSString *const kTaskDataDiligenceTime;
extern NSString *const kTaskDataRestTime;
extern NSString *const kTaskDataIsFocusModeEnabled;
extern NSString *const kTaskDataIsRestModeEnabled;
extern NSString *const kTaskDataIsMusicModeEnabled;
extern NSString *const kTaskDataIsAlertModeEnabled;
extern NSString *const kTaskDataAlertTime;

#pragma mark - diligence data column keys

extern NSString *const kDiligenceConfiguration;
extern NSString *const kDiligenceTable;
extern NSString *const kDiligenceTaskIndex;
extern NSString *const kDiligenceHourIndex;
extern NSString *const kDiligenceDayIndex;
extern NSString *const kDiligenceWeekdayIndex;

#pragma mark - diligence configuration column keys

extern NSString *const kDiligenceConfigurationMaxKey;
extern NSString *const kDiligenceConfigurationVersion;

#pragma mark - diligence table column keys

extern NSString *const kDiligenceTableTaskId;
extern NSString *const kDiligenceTableStartDate;
extern NSString *const kDiligenceTableEndDate;
extern NSString *const kDiligenceTableBreakTimes;
extern NSString *const kDiligenceTableDiligenceMinutes;

#pragma mark - story data column keys

extern NSString *const kStoryDataDate;
extern NSString *const kStoryDataTitle;
extern NSString *const kStoryDataAttribute;
extern NSString *const kStoryDataPara1;
extern NSString *const kStoryDataImageData;

#endif /* ILKeysConstants_h */
