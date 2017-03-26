//
//  MusicHelper.m
//  energy
//
//  Created by XueFeng Chen on 2017/2/21.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "MusicHelper.h"

@implementation MusicHelper

+ (NSURL *)musicUrlByName:(NSString *)musicName {
    NSDictionary *musicDict = @{
                                @"送别":@"送别",
                                @"月色思念":@"月色思念",
                                @"美丽的神话":@"美丽的神话",
                                @"梁祝":@"梁祝",
                                @"但愿相别不相忘":@"但愿相别不相忘",
                                @"茉莉花":@"茉莉花",
                                @"江南雨":@"江南雨",
                                };
    
    
    
    NSString *musicFileName = musicDict[musicName];
    NSString *musicFileType = @"m4a";
    
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:musicFileName ofType:musicFileType]];
}

+ (NSArray *)musicNameList {
    return  @[
              @"送别",
              @"月色思念",
              @"美丽的神话",
              @"梁祝",
              @"但愿相别不相忘",
              @"茉莉花",
              @"江南雨",
              ];
}

@end
