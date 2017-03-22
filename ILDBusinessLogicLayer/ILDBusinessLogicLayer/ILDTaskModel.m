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

- (instancetype)initWithTaskDict:(NSDictionary *)taskDict {
    if (self = [super init]) {
        self.name = taskDict[kTaskDataName];
        self.color = taskDict[kTaskDataColor];
        self.musicName = taskDict[kTaskDataMusicName];
        self.diligenceTime = taskDict[kTaskDataDiligenceTime];
        self.restTime = taskDict[kTaskDataRestTime];
        self.isFocusModeEnabled = [taskDict[kTaskDataIsFocusModeEnabled] boolValue];
        self.isRestModeEnabled = [taskDict[kTaskDataIsRestModeEnabled] boolValue];
        self.isMusicEnabled = [taskDict[kTaskDataIsMusicModeEnabled] boolValue];
        self.isAlertEnabled = [taskDict[kTaskDataIsAlertModeEnabled] boolValue];
        self.alertTime = taskDict[kTaskDataAlertTime];
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
                                        kTaskDataIsFocusModeEnabled: [NSNumber numberWithBool:self.isRestModeEnabled],
                                        kTaskDataIsRestModeEnabled: [NSNumber numberWithBool:self.isFocusModeEnabled],
                                        kTaskDataIsMusicModeEnabled: [NSNumber numberWithBool:self.isMusicEnabled],
                                        kTaskDataIsAlertModeEnabled: [NSNumber numberWithBool:self.isAlertEnabled],
                                        kTaskDataAlertTime: self.alertTime
                                        };
    
    return taskDictionary;
}

@end
