//
//  ILDDiligenceClockView.h
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/25.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ILDDiligenceClockViewDelegate

- (void)taskCompleted;

@end

@interface ILDDiligenceClockView : UIView

@property(nonatomic, assign) NSInteger diligenceSeconds;
@property(nonatomic, strong) NSString *taskName;
@property(nonatomic, assign) BOOL isRestMode;

@property (nonatomic, weak) id<ILDDiligenceClockViewDelegate> delegate;

- (void)startTimer;
- (void)pauseTimer;
- (void)resumeTimer;
- (void)stopTimer;

@end
