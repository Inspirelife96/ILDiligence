//
//  ILDDiligenceClockViewController.h
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/25.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILDDiligenceClockView.h"

@interface ILDDiligenceClockViewController : UIViewController

@property(nonatomic, strong) ILDDiligenceClockView *diligenceClockView;

@property(nonatomic, strong) NSString *taskId;
@property(nonatomic, assign) BOOL isRestMode;

- (void)startDiligenceClock;
- (void)pauseDiligenceClock;
- (void)resumeDiligenceClock;
- (void)stopDiligenceClock;

@end
