//
//  ILDTaskConfigurationViewController.h
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILDTaskConfigurationNavigateModeViewController.h"

typedef NS_ENUM(NSInteger, TaskConfigurationType) {
    TaskConfigurationTypeAdd,
    TaskConfigurationTypeModify
};

@interface ILDTaskConfigurationViewController : ILDTaskConfigurationNavigateModeViewController

@property(nonatomic, assign) TaskConfigurationType configurationType;
@property(nonatomic, assign) NSString *taskId;

@end
