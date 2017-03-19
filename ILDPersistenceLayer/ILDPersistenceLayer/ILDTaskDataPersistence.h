//
//  ILDTaskDataPersistence.h
//  ILDPersistenceLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILDTaskDataPersistence : NSObject

+ (NSDictionary *)readTaskData;
+ (void)saveTaskData:(NSDictionary *)taskDataNSDictionary;

@end
