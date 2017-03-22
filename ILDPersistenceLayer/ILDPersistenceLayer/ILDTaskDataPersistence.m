//
//  ILDTaskDataPersistence.m
//  ILDPersistenceLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskDataPersistence.h"
#import "ILDPersistenceFilePathHelper.h"

NSString *const kTaskDataPersistanceFile = @"taskData.plist";

@implementation ILDTaskDataPersistence

+ (NSDictionary *)readTaskData {
    NSString *taskDataFilePath = [ILDPersistenceFilePathHelper persistenceFilePath:kTaskDataPersistanceFile];
    NSDictionary *taskDataDictionary = [NSDictionary dictionaryWithContentsOfFile:taskDataFilePath];
    if (!taskDataDictionary) {
        NSString *defaultTaskDataFilePath = [[NSBundle mainBundle] pathForResource:kTaskDataPersistanceFile ofType:nil];
        taskDataDictionary = [NSDictionary dictionaryWithContentsOfFile:defaultTaskDataFilePath];
        [ILDTaskDataPersistence saveTaskData:taskDataDictionary];
    }
    
    return taskDataDictionary;
}

+ (void)saveTaskData:(NSDictionary *)taskDataDictionary {
    NSString *taskDataFilePath = [ILDPersistenceFilePathHelper persistenceFilePath:kTaskDataPersistanceFile];
    [taskDataDictionary writeToFile:taskDataFilePath atomically:YES];
}

@end
