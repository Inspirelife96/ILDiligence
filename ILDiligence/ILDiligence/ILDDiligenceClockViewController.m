//
//  ILDDiligenceClockViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/25.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDDiligenceClockViewController.h"

@interface ILDDiligenceClockViewController ()

@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) ILDTaskModel *taskModel;

@end

@implementation ILDDiligenceClockViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.diligenceClockView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateDataAndView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.diligenceClockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, -ScreenHeight/6));
        make.width.mas_equalTo(ScreenWidth * 3 / 5);
        make.height.mas_equalTo(ScreenWidth * 3 / 5);
    }];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public method

- (void)startDiligenceClock {
    if (self.isRestMode) {
        [self.diligenceClockView setDiligenceSeconds:[self.taskModel.restTime integerValue] * 60];
    } else {
        [self.diligenceClockView setDiligenceSeconds:[self.taskModel.diligenceTime integerValue] * 60];
    }
    
    self.diligenceClockView.isRestMode = self.isRestMode;
    [self.diligenceClockView startTimer];
}

- (void)pauseDiligenceClock {
    [self.diligenceClockView pauseTimer];
}

- (void)resumeDiligenceClock {
    [self.diligenceClockView resumeTimer];
}

- (void)stopDiligenceClock {
    [self.diligenceClockView stopTimer];
}

- (void)updateDataAndView {
    self.taskModel = [[ILDTaskDataCenter sharedInstance] taskConfigurationById:self.taskId];
    self.backgroundView.backgroundColor = [ColorHelper colorByName:self.taskModel.color];
}

#pragma mark - Getter and Setter

- (ILDDiligenceClockView *)diligenceClockView {
    if (!_diligenceClockView) {
        _diligenceClockView = [[ILDDiligenceClockView alloc] init];
        _diligenceClockView.taskName = self.taskModel.name;
    }
    
    return _diligenceClockView;
}

- (ILDTaskModel *)taskModel {
    if (!_taskModel) {
        _taskModel = [[ILDTaskDataCenter sharedInstance] taskConfigurationById:self.taskId];
    }
    
    return _taskModel;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.alpha = 0.5;
    }
    
    return _backgroundView;
}

- (void)setIsRestMode:(BOOL)isRestMode {
    _isRestMode = isRestMode;
}

@end
