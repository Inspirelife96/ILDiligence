//
//  ILDStoryDataPersistence.m
//  ILDPersistenceLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStoryDataPersistence.h"
#import "ILDPersistenceFilePathHelper.h"
#import "ILDPersistanceConstants.h"
#import <UIKit/UIKit.h>

NSString *const kStoryDataPersistanceFile = @"storyData.plist";

@implementation ILDStoryDataPersistence

+ (NSDictionary *)readStoryData {
    NSString *storyDataFilePath = [ILDPersistenceFilePathHelper persistenceFilePath:kStoryDataPersistanceFile];
    NSDictionary *storyDataDictionary = [NSDictionary dictionaryWithContentsOfFile:storyDataFilePath];
    if (!storyDataDictionary) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:- (24 * 3600)];
        NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"default_background_1080x1920"], 0.5);
        
        storyDataDictionary = @{
                                kStoryDataDate:date,
                                kStoryDataTitle:@"随处可见的醉人景色",
                                kStoryDataAttribute:@"旧金山的兰兹角",
                                kStoryDataPara1:@"金门大桥和太平洋的美丽景色只是人们参观金门国家休闲区中兰兹角的原因之一，因为兰兹角本身就美到让人窒息。兰兹角位于旧金山市西北角的海岸公园，是金门国家休闲区里的一个公园，公园内有海岸小径可以眺望太平洋和金门大桥。",
                                kStoryDataImageData:imageData
                                };
        
        [ILDStoryDataPersistence saveStoryData:storyDataDictionary];
    }
    
    return storyDataDictionary;
}

+ (void)saveStoryData:(NSDictionary *)storyDataDictionary {
    NSString *storyDataFilePath = [ILDPersistenceFilePathHelper persistenceFilePath:kStoryDataPersistanceFile];
    [storyDataDictionary writeToFile:storyDataFilePath atomically:YES];
}

@end
