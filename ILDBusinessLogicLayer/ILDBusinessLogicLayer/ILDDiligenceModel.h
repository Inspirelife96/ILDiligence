//
//  ILDDiligenceModel.h
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILDDiligenceModel : NSObject

@property (nonatomic, copy) NSString *taskId;
@property (nonatomic, copy) NSDate *startDate;
@property (nonatomic, copy) NSDate *endDate;
@property (nonatomic, strong) NSNumber *breakTimes;
@property (nonatomic, strong) NSNumber *diligenceTime;

- (instancetype)initTaskId:(NSString *)taskId
                 startDate:(NSDate *)startDate
                   endDate:(NSDate *)endDate
                breakTimes:(NSNumber *)breakTimes
             diligenceTime:(NSNumber *)deligenceTime;

- (instancetype)initWithDiligenceDictionary:(NSDictionary *)diligenceDictionary;

- (NSDictionary *)convertToDictionary;

@end
