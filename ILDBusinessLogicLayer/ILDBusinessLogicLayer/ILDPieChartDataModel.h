//
//  ILDPieChartDataModel.h
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/22.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILDPieChartDataModel : NSObject

@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, strong) NSString *taskColor;
@property (nonatomic, strong) NSNumber *diligenceMinutes;

@end
