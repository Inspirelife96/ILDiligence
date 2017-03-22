//
//  ILDDiligenceDataCenter.h
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILDDiligenceModel.h"
#import "ILDStatisticsTodayModel.h"
#import "ILDStatisticsHistoryModel.h"

@interface ILDDiligenceDataCenter : NSObject

+ (instancetype)sharedInstance;

- (void)addDiligence:(ILDDiligenceModel *)diligenceData;
- (void)removeDiligence:(NSString *)taskId;

- (ILDStatisticsTodayModel *)prepareStatisticsToday;
- (ILDStatisticsHistoryModel *)prepareStatisticsHistory;

@end
