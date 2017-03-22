//
//  ILDStatisticsTodayModel.h
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILDStatisticsTodayModel : NSObject

@property (nonatomic, strong) NSNumber *diligenceTimes;
@property (nonatomic, strong) NSNumber *diligenceHours;
@property (nonatomic, strong) NSNumber *diligenceFocusPercentage;
@property (nonatomic, strong) NSArray  *diligenceDataArray;

@end
