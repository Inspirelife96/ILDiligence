//
//  ILDTaskDataCenter.m
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskDataCenter.h"
#import "ILDDiligenceDataCenter.h"
#import <ILDPersistenceLayer/ILDPersistenceLayer.h>

@interface ILDTaskDataCenter ()

@property (strong, nonatomic) NSMutableDictionary *taskDataDictionary;

@end

@implementation ILDTaskDataCenter

static ILDTaskDataCenter *sharedInstance = nil;

#pragma mark - singleton init

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    
    return sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [ILDTaskDataCenter sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [ILDTaskDataCenter sharedInstance] ;
}

- (ILDTaskDataCenter *)init {
    if (self = [super init]) {
        [self taskDataDictionary];
    }
    
    return self;
}

#pragma mark - Public Method

- (NSArray *)taskIds {
    return [[self.taskDataDictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSInteger taskId1 = [(NSString *)obj1 integerValue];
        NSInteger taskId2 = [(NSString *)obj2 integerValue];
        if (taskId1 < taskId2){
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
}

- (ILDTaskModel *)taskConfigurationById:(NSString *)taskId {
    return [[ILDTaskModel alloc] initWithTaskDictionary:self.taskDataDictionary[taskId]];
}

- (void)addTask:(ILDTaskModel *)taskConfiguration {
    NSString *taskId = [self generateNewKey];
    self.taskDataDictionary[taskId] = [taskConfiguration convertToDictionary];
    [self saveTask];
}

- (void)updateTask:(NSString *)taskId taskConfiguration:(ILDTaskModel *)taskConfiguration {
    self.taskDataDictionary[taskId] = [taskConfiguration convertToDictionary];
    [self saveTask];
}

- (void)removeTask:(NSString *)taskId {
    [self.taskDataDictionary removeObjectForKey:taskId];
    [self saveTask];
    [[ILDDiligenceDataCenter sharedInstance] removeDiligence:taskId];
}

#pragma mark - Private Method

- (NSString *)generateNewKey {
    NSArray *taskIds = [self taskIds];
    NSInteger maxNumber = [taskIds[taskIds.count - 1] integerValue];
    return [NSString stringWithFormat:@"%ld", (long)(maxNumber + 1)];
}


- (void)saveTask {
    [ILDTaskDataPersistence saveTaskData:self.taskDataDictionary];
}

#pragma mark - Getter and Setter

- (NSMutableDictionary *)taskDataDictionary {
    if (!_taskDataDictionary) {
        _taskDataDictionary = [[ILDTaskDataPersistence readTaskData] mutableCopy];
    }
    
    return _taskDataDictionary;
}


@end
