//
//  ILDStoryDataPersistence.h
//  ILDPersistenceLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILDStoryDataPersistence : NSObject

+ (NSDictionary *)readStoryData;
+ (void)saveStoryData:(NSDictionary *)storyDataDictionary;

@end
