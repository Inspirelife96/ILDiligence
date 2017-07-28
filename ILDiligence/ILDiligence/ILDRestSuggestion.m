//
//  ILDRestSuggestion.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/15.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "ILDRestSuggestion.h"

@implementation ILDRestSuggestion

+ (NSString *)randomRestSuggestion {
    NSArray *restSuggestion = @[
                                @"喝杯水",
                                @"眼保健操",
                                @"站起来走走",
                                @"晒个太阳",
                                @"吃个水果",
                                @"看看窗外",
                                @"聊聊天"
                                ];
    
    return restSuggestion[arc4random()%6];
}


@end
