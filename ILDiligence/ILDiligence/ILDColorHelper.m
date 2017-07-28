//
//  ILDColorHelper.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/2/21.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "ILDColorHelper.h"

@implementation ILDColorHelper

+ (UIColor *)colorByName:(NSString *)colorString {
    NSDictionary *colorDict = @{
                                @"赤色":FlatRed,
                                @"橙色":FlatOrange,
                                @"黄色":FlatYellow,
                                @"绿色":FlatGreen,
                                @"青色":FlatSkyBlue,
                                @"蓝色":FlatBlue,
                                @"紫色":FlatPurple,
                                };
    
    return colorDict[colorString];
}

+ (NSArray *)colorNameList {
    return @[
             @"赤色",
             @"橙色",
             @"黄色",
             @"绿色",
             @"青色",
             @"蓝色",
             @"紫色",
             ];
}

@end
