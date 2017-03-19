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

extern NSString *const kDiligenceDataTaskId;
extern NSString *const kDiligenceDataStartDate;
extern NSString *const kDiligenceDataEndDate;
extern NSString *const kDiligenceDataBreakTimes;
extern NSString *const kDiligenceDataDiligenceTime;

#pragma mark - story data column keys

extern NSString *const kStoryDataDate;
extern NSString *const kStoryDataTitle;
extern NSString *const kStoryDataAttribute;
extern NSString *const kStoryDataPara1;
extern NSString *const kStoryDataImageData;

#endif /* ILKeysConstants_h */
