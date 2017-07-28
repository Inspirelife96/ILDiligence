//
//  ILDTaskModel+IL_OperationsForViewData.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskModel+IL_OperationsForViewData.h"
#import "UIImage+IL_ContentWithColor.h"

@implementation ILDTaskModel (IL_OperationsForViewData)

- (NSString *)il_taskName {
    return self.name;
}

- (NSString *)il_taskDetail {
    return [NSString stringWithFormat:@"%@分钟", self.diligenceTime];
}

- (UIImage *)il_taskImage {
    return [[UIImage imageNamed:@"menu_slider_thumb_16x16_"] il_imageContentWithColor:[ILDColorHelper colorByName:self.color]];
}

@end
