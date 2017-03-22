//
//  ILDTaskModel.h
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/20.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILDTaskModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *musicName;
@property (nonatomic, strong) NSNumber *diligenceTime;
@property (nonatomic, strong) NSNumber *restTime;
@property (nonatomic, assign) BOOL isRestModeEnabled;
@property (nonatomic, assign) BOOL isFocusModeEnabled;
@property (nonatomic, assign) BOOL isMusicEnabled;
@property (nonatomic, assign) BOOL isAlertEnabled;
@property (nonatomic, strong) NSDate *alertTime;

- (instancetype)init;
- (instancetype)initWithTaskDictionary:(NSDictionary *)taskNSDictionary;

- (NSDictionary *)convertToDictionary;

@end
