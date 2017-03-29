//
//  ILDPieChartDataModel+IL_OperationsForViewData.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDPieChartDataModel+IL_OperationsForViewData.h"

@implementation ILDPieChartDataModel (IL_OperationsForViewData)

- (double)il_diligenceMinutes {
    return [self.diligenceMinutes doubleValue];
}

- (NSString *)il_diligenceTaskName {
    return self.taskName;
}

- (UIColor *)il_diligenceTaskColor {
    return [ILDColorHelper colorByName:self.taskColor];
}

@end
