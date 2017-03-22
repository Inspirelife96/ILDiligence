//
//  ILDDiligenceModel.m
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDDiligenceModel.h"
#import <ILDPersistenceLayer/ILDPersistenceLayer.h>

@implementation ILDDiligenceModel

- (instancetype)initTaskId:(NSString *)taskId
                 startDate:(NSDate *)startDate
                   endDate:(NSDate *)endDate
                breakTimes:(NSNumber *)breakTimes
             diligenceTime:(NSNumber *)diligenceTime {
    if (self = [super init]) {
        self.taskId = taskId;
        self.startDate = startDate;
        self.endDate = endDate;
        self.breakTimes = breakTimes;
        self.diligenceTime = diligenceTime;
    }
    
    return self;
}

- (instancetype)initWithDiligenceDictionary:(NSDictionary *)diligenceDictionary {
    if (self = [super init]) {
        self.taskId = diligenceDictionary[kDiligenceTableTaskId];
        self.startDate = diligenceDictionary[kDiligenceTableStartDate];
        self.endDate = diligenceDictionary[kDiligenceTableEndDate];
        self.breakTimes = diligenceDictionary[kDiligenceTableBreakTimes];
        self.diligenceTime = diligenceDictionary[kDiligenceTableDiligenceMinutes];
    }
    
    return self;
}

- (NSDictionary *)convertToDictionary {
    NSDictionary *diligenceDictionary = @{
                                          kDiligenceTableTaskId: self.taskId,
                                          kDiligenceTableStartDate: self.startDate,
                                          kDiligenceTableEndDate: self.endDate,
                                          kDiligenceTableBreakTimes: self.breakTimes,
                                          kDiligenceTableDiligenceMinutes: self.diligenceTime
                                          };
    
    return diligenceDictionary;
}

@end
