//
//  ILDDiligenceDataCenter.m
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDDiligenceDataCenter.h"
#import "ILDTaskDataCenter.h"
#import "ILDStatisticsTodayModel.h"
#import "ILDStatisticsHistoryModel.h"
#import "ILDPieChartDataModel.h"
#import "ILDDateHelper.h"
#import <ILDPersistenceLayer/ILDPersistenceLayer.h>


@interface ILDDiligenceDataCenter ()

@property (strong, nonatomic) NSMutableDictionary *diligenceDataDictionary;
@property (strong, nonatomic) NSMutableDictionary *configurationDictionary;
@property (strong, nonatomic) NSMutableDictionary *tableDictionary;
@property (strong, nonatomic) NSMutableDictionary *taskIndexDictionary;
@property (strong, nonatomic) NSMutableDictionary *hourIndexDictionary;
@property (strong, nonatomic) NSMutableDictionary *dayIndexDictionary;
@property (strong, nonatomic) NSMutableDictionary *weekdayIndexDictionary;

@end

@implementation ILDDiligenceDataCenter

static ILDDiligenceDataCenter *sharedInstance = nil;

#pragma mark - singleton init

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
        
    });
    
    return sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [ILDDiligenceDataCenter sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [ILDDiligenceDataCenter sharedInstance] ;
}

- (instancetype)init {
    if (self = [super init]) {
        [self diligenceDataDictionary];
    }
    
    return self;
}

#pragma mark - Public Method

- (void)addDiligence:(ILDDiligenceModel *)diligenceData {
    NSNumber *maxNumber = self.configurationDictionary[kDiligenceConfigurationMaxKey];
    NSNumber *newKeyNumber = [NSNumber numberWithInteger:([maxNumber integerValue] + 1)];
    NSString *diligenceKey = [newKeyNumber stringValue];

    // update configuraiton
    self.configurationDictionary[kDiligenceConfigurationMaxKey] = newKeyNumber;

    // update diligence table
    [self.tableDictionary setObject:[diligenceData convertToDictionary] forKey:diligenceKey];
    
    // update index
    NSString *stringOfDay = [ILDDateHelper stringOfDay:diligenceData.startDate];
    NSString *stringOfHour = [ILDDateHelper stringOfHour:diligenceData.startDate];
    NSString *stringOfWeekday = [ILDDateHelper stringOfWeekday:diligenceData.startDate];
    [self addDiligenceKey:diligenceKey toTargetDictionary:self.taskIndexDictionary withIndexKey:diligenceData.taskId];
    [self addDiligenceKey:diligenceKey toTargetDictionary:self.hourIndexDictionary withIndexKey:stringOfHour];
    [self addDiligenceKey:diligenceKey toTargetDictionary:self.dayIndexDictionary withIndexKey:stringOfDay];
    [self addDiligenceKey:diligenceKey toTargetDictionary:self.weekdayIndexDictionary withIndexKey:stringOfWeekday];
    
    [self saveDiligenceData];
}

- (void)removeDiligence:(NSString *)taskId; {
    // remove index
    [self removeDiligenceKeyIn:self.taskIndexDictionary withTask:taskId];
    [self removeDiligenceKeyIn:self.hourIndexDictionary withTask:taskId];
    [self removeDiligenceKeyIn:self.dayIndexDictionary withTask:taskId];
    [self removeDiligenceKeyIn:self.weekdayIndexDictionary withTask:taskId];
    
    // remove diligence
    [self.tableDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *diligenceDetail, BOOL * _Nonnull stop) {
        if ([diligenceDetail[kDiligenceTableTaskId] isEqualToString:taskId]) {
            [self.tableDictionary removeObjectForKey:key];
        }
    }];
    
    [self saveDiligenceData];
}

- (void)addDiligenceKey:(NSString *)diligenceKey toTargetDictionary:(NSMutableDictionary *)targetDictionary withIndexKey:(NSString *)indexKey {
    NSMutableArray *diligenceTableArray = targetDictionary[indexKey];
    [diligenceTableArray addObject:diligenceKey];
    targetDictionary[indexKey] = diligenceTableArray;
}

- (void)removeDiligenceKeyIn:(NSMutableDictionary *)targetDictionary withTask:(NSString *)taskId {
    if (targetDictionary == self.taskIndexDictionary) {
        [self.taskIndexDictionary removeObjectForKey:taskId];
    } else {
        [targetDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *diligenceArray, BOOL * _Nonnull stop) {
            NSMutableArray *mutableArray = [diligenceArray mutableCopy];
            [mutableArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString *diligenceKey, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *diligenceDetail = self.tableDictionary[diligenceKey];
                if ([diligenceDetail[kDiligenceTableTaskId] isEqualToString:taskId]) {
                    [mutableArray removeObjectAtIndex:idx];
                }
            }];
            
            if (mutableArray.count > 0) {
                targetDictionary[key] = mutableArray;
            } else {
                [targetDictionary removeObjectForKey:key];
            }
        }];
    }
}


#pragma mark - Public Method

- (ILDStatisticsTodayModel *)prepareStatisticsToday {
    NSInteger __block diligenceTimes = 0;
    NSInteger __block diligenceMinutes = 0;
    NSInteger __block diligenceFocusScore = 0;
    NSMutableArray<ILDPieChartDataModel*> *diligenceArray = [[NSMutableArray alloc] init];
    
    NSString *stringOfDay = [ILDDateHelper stringOfDay:[NSDate date]];
    NSArray *diligenceKeyArray = self.dayIndexDictionary[stringOfDay];
    
    [diligenceKeyArray enumerateObjectsUsingBlock:^(NSString *diligenceKey, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *diligenceDict = self.tableDictionary[diligenceKey];
        NSInteger currentMinutes = [diligenceDict[kDiligenceTableDiligenceMinutes] integerValue];
        NSInteger currentBreakTimes = [diligenceDict[kDiligenceTableBreakTimes] integerValue];
        
        diligenceTimes++;
        diligenceMinutes += currentMinutes;
        diligenceFocusScore += 100 - 5 * currentBreakTimes;

        ILDTaskModel *taskModel = [[ILDTaskDataCenter sharedInstance] taskConfigurationById:diligenceDict[kDiligenceTableTaskId]];
        ILDPieChartDataModel *pieChartDataModel = [[ILDPieChartDataModel alloc] init];
        pieChartDataModel.taskName = taskModel.name;
        pieChartDataModel.taskColor = taskModel.color;
        pieChartDataModel.diligenceMinutes = [NSNumber numberWithInteger:currentMinutes];
        [diligenceArray addObject:pieChartDataModel];
    }];
    
    ILDStatisticsTodayModel *statisticsTodayModel = [[ILDStatisticsTodayModel alloc] init];
    statisticsTodayModel.diligenceTimes = [NSNumber numberWithInteger:diligenceTimes];
    statisticsTodayModel.diligenceHours = [NSNumber numberWithFloat:diligenceMinutes/60.0f];
    if (diligenceTimes != 0) {
        statisticsTodayModel.diligenceFocusPercentage = [NSNumber numberWithFloat:((float)diligenceFocusScore)/diligenceTimes];
    } else {
        statisticsTodayModel.diligenceFocusPercentage = [NSNumber numberWithFloat:0];
    }
    statisticsTodayModel.diligenceDataArray = diligenceArray;
    
    return statisticsTodayModel;
}

- (ILDStatisticsHistoryModel *)prepareStatisticsHistory {
    
    NSInteger diligenceTimesInTotal = [self.tableDictionary count];
    NSInteger diligenceMinutesInTotal = [self calculateDiligenceMinutes:[self.tableDictionary allKeys]];
    NSInteger diligenceDaysInTotal = [self.dayIndexDictionary count];
    NSInteger diligenceEverageMinutes = 0;
    if (diligenceDaysInTotal > 0) {
        diligenceEverageMinutes = diligenceMinutesInTotal/diligenceDaysInTotal;
    }
    
    __block NSString *bestTaskName = @"-";
    NSMutableArray *dataForPieChartArray = [[NSMutableArray alloc] init];
    
    if ([self.taskIndexDictionary count] > 0) {
        
        __block NSInteger bestTaskMinutes = 0;
        
        [self.taskIndexDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *taskKeyString, NSArray *diligenceKeyArray, BOOL * _Nonnull stop) {
            ILDTaskModel *taskModel = [[ILDTaskDataCenter sharedInstance] taskConfigurationById:taskKeyString];
            NSInteger currentTaskMinutes = [self calculateDiligenceMinutes:diligenceKeyArray];
            
            ILDPieChartDataModel *pieChartModel = [[ILDPieChartDataModel alloc] init];
            pieChartModel.taskName = taskModel.name;
            pieChartModel.taskColor = taskModel.color;
            pieChartModel.diligenceMinutes = [NSNumber numberWithInteger:currentTaskMinutes];
            [dataForPieChartArray addObject:pieChartModel];

            if (bestTaskMinutes < currentTaskMinutes) {
                bestTaskMinutes = currentTaskMinutes;
                bestTaskName = taskModel.name;
            }
        }];
    }
    
    __block NSString *bestWeekday = @"-";
    NSInteger bestWeekdayPlus = 0;
    
    if ([self.weekdayIndexDictionary count] > 0) {
        __block NSInteger bestWeekdayMinutes = 0;
        __block NSInteger weekdayMinutesInTotal = 0;
        [self.weekdayIndexDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *weekdayKeyString, NSArray *diligenceKeyArray, BOOL * _Nonnull stop) {
            
            NSInteger currentWeekdayMinutes = [self calculateDiligenceMinutes:diligenceKeyArray];
            weekdayMinutesInTotal += currentWeekdayMinutes;
            
            if (bestWeekdayMinutes < currentWeekdayMinutes) {
                bestWeekdayMinutes = currentWeekdayMinutes;
                bestWeekday = weekdayKeyString;
            }
        }];
        
        NSInteger everageMinutesByWeekday = weekdayMinutesInTotal / [self.weekdayIndexDictionary count];
        bestWeekdayPlus = (bestWeekdayMinutes - everageMinutesByWeekday) * 100 / everageMinutesByWeekday;
    }
    
    __block NSString *bestHour = @"-";
    NSInteger bestHourPlus = 0;
    
    if ([self.hourIndexDictionary count] > 0) {
        __block NSInteger bestHourMinutes = 0;
        __block NSInteger hourMinutesInTotal = 0;
        [self.hourIndexDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *hourKeyString, NSArray *diligenceKeyArray, BOOL * _Nonnull stop) {
            
            NSInteger currentHourMinutes = [self calculateDiligenceMinutes:diligenceKeyArray];
            hourMinutesInTotal += currentHourMinutes;
            
            if (bestHourMinutes < currentHourMinutes) {
                bestHourMinutes = currentHourMinutes;
                bestHour = hourKeyString;
            }
        }];
        
        NSInteger everageMinutesByHour = hourMinutesInTotal / [self.hourIndexDictionary count];
        bestHourPlus = (bestHourMinutes - everageMinutesByHour) * 100 / everageMinutesByHour;
    }

    NSMutableArray *dataForBarChartArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= 30; i++) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-(i * 3600 * 24)];
        NSString *stringOfDay = [ILDDateHelper stringOfDay:date];
        NSArray *diligenceKeyArray = self.dayIndexDictionary[stringOfDay];
        if (diligenceKeyArray) {
            NSInteger diligenceTime = [self calculateDiligenceMinutes:diligenceKeyArray];
            [dataForBarChartArray addObject:[NSNumber numberWithInteger:diligenceTime]];
        } else {
            [dataForBarChartArray addObject:@0];
        }
    }
    
    ILDStatisticsHistoryModel *statisticsHistoryModel = [[ILDStatisticsHistoryModel alloc] init];
    statisticsHistoryModel.diligenceTimesInTotal = [NSNumber numberWithInteger:diligenceTimesInTotal];
    statisticsHistoryModel.diligenceHoursInTotal = [NSNumber numberWithFloat:diligenceMinutesInTotal/60.0f];
    statisticsHistoryModel.diligenceDaysInTotal = [NSNumber numberWithInteger:diligenceDaysInTotal];
    statisticsHistoryModel.bestWeekday = bestWeekday;
    statisticsHistoryModel.bestHour = bestHour;
    statisticsHistoryModel.bestTask = bestTaskName;
    statisticsHistoryModel.bestWeekdayPlus = [NSNumber numberWithInteger:bestWeekdayPlus];
    statisticsHistoryModel.bestHourPlus = [NSNumber numberWithInteger:bestWeekdayPlus];
    statisticsHistoryModel.everageMinutes = [NSNumber numberWithInteger:diligenceEverageMinutes];
    statisticsHistoryModel.dataForPieChartArray = dataForPieChartArray;
    statisticsHistoryModel.dataForBarChartArray = dataForBarChartArray;

    return statisticsHistoryModel;
}

- (NSInteger) calculateDiligenceMinutes:(NSArray *)diligenceKeyArray {
    __block NSInteger totalTime = 0;
    
    [diligenceKeyArray enumerateObjectsUsingBlock:^(NSDictionary *diligenceDictionary, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger currentTime = [diligenceDictionary[kDiligenceTableDiligenceMinutes] integerValue];
        totalTime += currentTime;
    }];
    
    return totalTime;
}

#pragma mark - Private Method

- (void)saveDiligenceData {
    // update diligence data
    self.diligenceDataDictionary[kDiligenceConfiguration] = self.configurationDictionary;
    self.diligenceDataDictionary[kDiligenceTable] = self.tableDictionary;
    self.diligenceDataDictionary[kDiligenceTaskIndex] = self.taskIndexDictionary;
    self.diligenceDataDictionary[kDiligenceHourIndex] = self.hourIndexDictionary;
    self.diligenceDataDictionary[kDiligenceDayIndex] = self.dayIndexDictionary;
    self.diligenceDataDictionary[kDiligenceWeekdayIndex] = self.weekdayIndexDictionary;
    
    [ILDDiligenceDataPersistence saveDiligenceData:self.diligenceDataDictionary];
}

#pragma mark - Getter and Setter

- (NSMutableDictionary *)diligenceDataDictionary {
    if (!_diligenceDataDictionary) {
        _diligenceDataDictionary = [[ILDDiligenceDataPersistence readDiligenceData] mutableCopy];
        _configurationDictionary = [_diligenceDataDictionary[kDiligenceConfiguration] mutableCopy];
        _tableDictionary = [_diligenceDataDictionary[kDiligenceTable] mutableCopy];
        _taskIndexDictionary = [_diligenceDataDictionary[kDiligenceTaskIndex] mutableCopy];
        _hourIndexDictionary = [_diligenceDataDictionary[kDiligenceHourIndex] mutableCopy];
        _dayIndexDictionary = [_diligenceDataDictionary[kDiligenceDayIndex] mutableCopy];
        _weekdayIndexDictionary = [_diligenceDataDictionary[kDiligenceWeekdayIndex] copy];
    }
    
    return _diligenceDataDictionary;
}

@end
