//
//  ILDTaskModel.m
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskModel.h"
#import <ILDPersistenceLayer/ILDPersistenceLayer.h>

@implementation ILDTaskModel

- (instancetype)init {
    if (self = [super init]) {
        self.name = @"";
        self.color = @"蓝色";
        self.musicName = @"送别";
        self.diligenceTime = @25;
        self.restTime = @5;
        self.isFocusModeEnabled = NO;
        self.isRestModeEnabled = YES;
        self.isMusicEnabled = YES;
        self.isAlertEnabled = NO;
        self.alertTime = [NSDate dateWithTimeIntervalSince1970:10 * 3600];
    }
    
    return self;
}

- (instancetype)initWithTaskDictionary:(NSDictionary *)taskNSDictionary {
    if (self = [super init]) {
        self.name = taskNSDictionary[kTaskDataName];
        self.color = taskNSDictionary[kTaskDataColor];
        self.musicName = taskNSDictionary[kTaskDataMusicName];
        self.diligenceTime = taskNSDictionary[kTaskDataDiligenceTime];
        self.restTime = taskNSDictionary[kTaskDataRestTime];
        self.isFocusModeEnabled = [taskNSDictionary[kTaskDataIsFocusModeEnabled] boolValue];
        self.isRestModeEnabled = [taskNSDictionary[kTaskDataIsRestModeEnabled] boolValue];
        self.isMusicEnabled = [taskNSDictionary[kTaskDataIsMusicModeEnabled] boolValue];
        self.isAlertEnabled = [taskNSDictionary[kTaskDataIsAlertModeEnabled] boolValue];
        self.alertTime = taskNSDictionary[kTaskDataAlertTime];
    }
    
    return self;
}

- (NSDictionary *)convertToDictionary {
    NSDictionary *taskDictionary = @{
                                        kTaskDataName: self.name,
                                        kTaskDataColor: self.color,
                                        kTaskDataMusicName: self.musicName,
                                        kTaskDataDiligenceTime: self.diligenceTime,
                                        kTaskDataRestTime: self.restTime,
                                        kTaskDataIsRestModeEnabled: [NSNumber numberWithBool:self.isRestModeEnabled],
                                        kTaskDataIsFocusModeEnabled: [NSNumber numberWithBool:self.isFocusModeEnabled],
                                        kTaskDataIsMusicModeEnabled: [NSNumber numberWithBool:self.isMusicEnabled],
                                        kTaskDataIsAlertModeEnabled: [NSNumber numberWithBool:self.isAlertEnabled],
                                        kTaskDataAlertTime: self.alertTime
                                        };
    
    return taskDictionary;
}

@end
