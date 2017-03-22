//
//  ILDTaskDataCenter.h
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILDTaskModel.h"

@interface ILDTaskDataCenter : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)taskIds;
- (ILDTaskModel *)taskConfigurationById:(NSString *)taskId;
- (void)addTask:(ILDTaskModel *)taskConfiguration;
- (void)updateTask:(NSString *)taskId taskConfiguration:(ILDTaskModel *)taskConfiguration;
- (void)removeTask:(NSString *)taskId;

@end
