//
//  ILDStatisticsTodayModel+IL_OperationsForViewData.h
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <ILDBusinessLogicLayer/ILDBusinessLogicLayer.h>

@interface ILDStatisticsTodayModel (IL_OperationsForViewData)

- (NSString *)il_diligenceTimesValue;
- (NSString *)il_diligenceHoursValue;
- (NSString *)il_diligenceFocusValue;

- (NSString *)il_diligenceTimesTitle;
- (NSString *)il_diligenceHoursTitle;
- (NSString *)il_diligenceFocusTitle;

- (UIImage *)il_diligenceTimesIcon;
- (UIImage *)il_diligenceHoursIcon;
- (UIImage *)il_diligenceFocusIcon;

@end
