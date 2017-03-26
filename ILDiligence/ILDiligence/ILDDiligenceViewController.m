//
//  ILDDiligenceViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/25.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDDiligenceViewController.h"
#import "ILDDiligenceClockViewController.h"
#import "ILDTaskListViewController.h"
#import "ILDStatisticsTodayViewController.h"
#import "ILDStoryViewController.h"
#import "ILDSettingViewController.h"
#import "ILDScreenshotImageManager.h"

#import <AVFoundation/AVFoundation.h>

@interface ILDDiligenceViewController () <UIScrollViewDelegate, ILDDiligenceClockViewDelegate, AVAudioPlayerDelegate>

@property(nonatomic, strong) UIImageView *backgroundImageView;

@property(nonatomic, strong) UIScrollView *clockScrollView;
@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic, strong) UIButton *taskButton;
@property(nonatomic, strong) UIButton *statisticsButton;
@property(nonatomic, strong) UIButton *storyButton;
@property(nonatomic, strong) UIButton *settingButton;

@property(nonatomic, strong) UIButton *startButton;
@property(nonatomic, strong) UIButton *pauseButton;
@property(nonatomic, strong) UIButton *cancelButton;
@property(nonatomic, strong) UIButton *resumeButton;
@property(nonatomic, strong) UIButton *skipButton;

@property(nonatomic, strong) NSMutableArray *viewControllers;

@property(nonatomic, strong) NSArray *taskIds;
@property(nonatomic, strong) ILDTaskModel *currentTaskModel;
@property(nonatomic, strong) ILDStoryModel *storyModel;

@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, assign) NSInteger breakTimes;

@property(nonatomic, strong) AVAudioPlayer *musicPlayer;

@end

@implementation ILDDiligenceViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.backgroundImageView];
    
    [self.view addSubview:self.clockScrollView];
    [self.view addSubview:self.pageControl];
    
    [self.view addSubview:self.taskButton];
    [self.view addSubview:self.statisticsButton];
    [self.view addSubview:self.storyButton];
    [self.view addSubview:self.settingButton];
    
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.pauseButton];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.resumeButton];
    [self.view addSubview:self.skipButton];
    
    self.breakTimes = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterBackground:)name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[ILDStoryDataCenter sharedInstance] addObserver:self forKeyPath:@"storyDataDictionary" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[ILDStoryDataCenter sharedInstance] removeObserver:self forKeyPath:@"storyDataDictionary"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.clockScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        [self.clockScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.clockScrollView.frame) * self.taskIds.count, CGRectGetHeight(self.clockScrollView.frame))];
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(ScreenWidth - 42 * 2);
    }];
    
    [self.taskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(12);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [self.statisticsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-12);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [self.storyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).with.offset(-50);
        make.left.equalTo(self.view.mas_left).with.offset(12);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).with.offset(-50);
        make.right.equalTo(self.view.mas_right).with.offset(-12);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, -20, 0, -20));
    }];
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, ScreenHeight/5));
        make.width.mas_equalTo(2*ScreenWidth/5);
        make.height.mas_equalTo(40);
    }];
    
    [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, ScreenHeight/5));
        make.width.mas_equalTo(ScreenWidth/4);
        make.height.mas_equalTo(40);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(ScreenWidth/10 + 5, ScreenHeight/5));
        make.width.mas_equalTo(ScreenWidth/5);
        make.height.mas_equalTo(40);
    }];
    
    [self.resumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(-ScreenWidth/10 - 5, ScreenHeight/5));
        make.width.mas_equalTo(ScreenWidth/5);
        make.height.mas_equalTo(40);
    }];
    
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.startButton.mas_bottom).with.offset(10);
        make.width.mas_equalTo(2*ScreenWidth/5);
        make.height.mas_equalTo(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)loadScrollViewWithPage:(NSUInteger)page {
    if (page >= self.taskIds.count) {
        return;
    }
    
    // replace the placeholder if necessary
    ILDDiligenceClockViewController *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[ILDDiligenceClockViewController alloc] init];
        controller.taskId = self.taskIds[page];
        controller.diligenceClockView.delegate = self;
        controller.isRestMode = NO;
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil) {
        CGRect frame = self.clockScrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        [self addChildViewController:controller];
        [self.clockScrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
    }
}

// at the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.clockScrollView.frame);
    NSUInteger page = floor((self.clockScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // a possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)gotoPage:(BOOL)animated {
    NSInteger page = self.pageControl.currentPage;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // update the scroll view to the appropriate page
    CGRect bounds = self.clockScrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.clockScrollView scrollRectToVisible:bounds animated:animated];
}

#pragma mark - Custom Delegate

- (void)taskCompleted {
    NSInteger page = self.pageControl.currentPage;
    ILDDiligenceClockViewController *controller = [self.viewControllers objectAtIndex:page];
    
    [self stopMusic];
    [self playSystemSound];
    
    if (controller.isRestMode) {
        [self setToDiligenceStartStatus];
    } else {
        ILDDiligenceModel *diligencModel = [[ILDDiligenceModel alloc] init];
        diligencModel.taskId = self.taskIds[page];
        diligencModel.startDate = self.startDate;
        diligencModel.endDate = [NSDate date];
        diligencModel.breakTimes = [NSNumber numberWithInteger:self.breakTimes];
        diligencModel.diligenceTime = self.currentTaskModel.diligenceTime;
        
        [[ILDDiligenceDataCenter sharedInstance] addDiligence:diligencModel];
        if (self.currentTaskModel.isRestModeEnabled) {
            [self setToRestStartStatus];
        } else {
            [self setToDiligenceStartStatus];
        }
    }
}

#pragma mark - Notifications / KVOs

- (void)applicationWillEnterBackground:(NSNotification *)notification {
    if (self.currentTaskModel.isFocusModeEnabled) {
        [self clickPauseButton:self.pauseButton];
        [self clickCancelButton:self.cancelButton];
        [self setToDiligenceStartStatus];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    ILDStoryModel *storyModel = [[ILDStoryDataCenter sharedInstance] prepareStoryModel];
    self.backgroundImageView.image = [UIImage imageWithData:storyModel.imageData];
}

#pragma mark - Event

- (void)clickTaskButton:(id)sender {
    [self copyScreen];
    
    ILDTaskListViewController *taskListVC = [[ILDTaskListViewController alloc] init];
    UINavigationController *taskListNC = [[UINavigationController alloc] initWithRootViewController:taskListVC];
    [self presentViewController:taskListNC animated:YES completion:nil];
}

- (void)clickStatisticsButton:(id)sender {
    [self copyScreen];
    
    ILDStatisticsTodayViewController *statisticsTodayVC = [[ILDStatisticsTodayViewController alloc] init];
    UINavigationController *settingNC = [[UINavigationController alloc] initWithRootViewController:statisticsTodayVC];
    [self presentViewController:settingNC animated:YES completion:nil];
}

- (void)clickStoryButton:(id)sender {
    ILDStoryViewController *storyVC = [[ILDStoryViewController alloc] init];
    [self presentViewController:storyVC animated:YES completion:nil];
}

- (void)clickSettingButton:(id)sender {
    [self copyScreen];
    
    ILDSettingViewController *settingVC = [[ILDSettingViewController alloc] init];
    UINavigationController *settingNC = [[UINavigationController alloc] initWithRootViewController:settingVC];
    [self presentViewController:settingNC animated:YES completion:nil];
}

- (void)clickStartButton:(id)sender {
    [self.startButton setHidden:YES];
    
    if (!self.currentTaskModel.isFocusModeEnabled) {
        [self.pauseButton setHidden:NO];
    }
    
    [self.cancelButton setHidden:YES];
    [self.resumeButton setHidden:YES];
    [self.skipButton setHidden:YES];
    
    [self.taskButton setHidden:YES];
    [self.statisticsButton setHidden:YES];
    [self.storyButton setHidden:YES];
    [self.settingButton setHidden:YES];
    
    [self.pageControl setHidden:YES];
    [self.clockScrollView setScrollEnabled:NO];
    
    ILDDiligenceClockViewController *controller = [self.viewControllers objectAtIndex:self.pageControl.currentPage];
    [controller startDiligenceClock];
    
    if (self.currentTaskModel.isMusicEnabled) {
        [self playMusic];
    }
    
    self.breakTimes = 0;
    self.startDate = [NSDate date];
}

- (void)clickPauseButton:(id)sender {
    [self.startButton setHidden:YES];
    [self.pauseButton setHidden:YES];
    [self.cancelButton setHidden:NO];
    [self.resumeButton setHidden:NO];
    [self.skipButton setHidden:YES];
    
    ILDDiligenceClockViewController *controller = [self.viewControllers objectAtIndex:self.pageControl.currentPage];
    [controller pauseDiligenceClock];
    
    if (self.currentTaskModel.isMusicEnabled) {
        [self pauseMusic];
    }

    self.breakTimes++;
}

- (void)clickCancelButton:(id)sender {
    if (self.currentTaskModel.isMusicEnabled) {
        [self stopMusic];
    }
    
    ILDDiligenceClockViewController *controller = [self.viewControllers objectAtIndex:self.pageControl.currentPage];
    [controller stopDiligenceClock];

    [self setToDiligenceStartStatus];
}

- (void)clickResumeButton:(id)sender {
    [self.startButton setHidden:YES];
    [self.pauseButton setHidden:NO];
    [self.cancelButton setHidden:YES];
    [self.resumeButton setHidden:YES];
    [self.skipButton setHidden:YES];
    
    ILDDiligenceClockViewController *controller = [self.viewControllers objectAtIndex:self.pageControl.currentPage];
    [controller resumeDiligenceClock];
    
    if (self.currentTaskModel.isMusicEnabled) {
        [self resumeMusic];
    }
}

- (void)clickSkipButton:(id)sender {
    [self setToDiligenceStartStatus];
}

#pragma mark - Music Related

- (void)playMusic {
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[MusicHelper musicUrlByName:self.currentTaskModel.musicName] error:nil];
    self.musicPlayer.delegate = self;
    self.musicPlayer.numberOfLoops = -1;
    self.musicPlayer.volume = 1;
    [self.musicPlayer prepareToPlay];
    self.musicPlayer.meteringEnabled = YES;
    [self.musicPlayer play];
}

- (void)pauseMusic {
    [self.musicPlayer pause];
}

- (void)stopMusic {
    [self.musicPlayer stop];
}

- (void)resumeMusic {
    [self.musicPlayer play];
}

- (void)playSystemSound {
    SystemSoundID sound = kSystemSoundID_Vibrate;
    
    //这里使用在上面那个网址找到的铃声，注意格式
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"new-mail",@"caf"];
    if (path) {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
        if (error != kAudioServicesNoError) {
            sound = 0;
        }
    }
    
    AudioServicesPlaySystemSound(sound);//播放声音
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//静音模式下震动
}

#pragma mark - Private Method

- (void)setToDiligenceStartStatus {
    [self.startButton setHidden:NO];
    [self.pauseButton setHidden:YES];
    [self.cancelButton setHidden:YES];
    [self.resumeButton setHidden:YES];
    [self.skipButton setHidden:YES];
    
    [self.taskButton setHidden:NO];
    [self.statisticsButton setHidden:NO];
    [self.storyButton setHidden:NO];
    [self.settingButton setHidden:NO];
    
    [self.pageControl setHidden:NO];
    
    [self.startButton setTitle:@"勤·开始" forState:UIControlStateNormal];
    [self.startButton setBackgroundColor:FlatRed];
    [self.startButton setTitleColor:FlatWhite forState:UIControlStateNormal];
    
    [self.clockScrollView setScrollEnabled:YES];
    
    ILDDiligenceClockViewController *controller = [self.viewControllers objectAtIndex:self.pageControl.currentPage];
    controller.isRestMode = NO;
    
    self.breakTimes = 0;
}

- (void)setToRestStartStatus {
    [self.startButton setHidden:NO];
    [self.pauseButton setHidden:YES];
    [self.cancelButton setHidden:YES];
    [self.resumeButton setHidden:YES];
    [self.skipButton setHidden:NO];
    
    [self.startButton setTitle:@"勤·休息" forState:UIControlStateNormal];
    [self.startButton setBackgroundColor:FlatWhite];
    [self.startButton setTitleColor:FlatBlue forState:UIControlStateNormal];
    
    ILDDiligenceClockViewController *controller = [self.viewControllers objectAtIndex:self.pageControl.currentPage];
    controller.isRestMode = YES;
}

- (void)updateScrollView {
    self.clockScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.clockScrollView.frame) * self.taskIds.count, CGRectGetHeight(self.clockScrollView.frame));
    
    for (UIView *subView in self.clockScrollView.subviews) {
        [subView removeFromSuperview];
    }
}

- (void)updateTaskControllers {
    [self.viewControllers removeAllObjects];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < self.taskIds.count; i++) {
        [controllers addObject:[NSNull null]];
    }
    
    self.viewControllers = controllers;
}

- (void)updateUI {
    NSInteger page = self.pageControl.currentPage;
    
    self.taskIds = [[ILDTaskDataCenter sharedInstance] taskIds];
    self.pageControl.numberOfPages = self.taskIds.count;
    self.pageControl.currentPage = (page < self.taskIds.count) ? page : self.taskIds.count;
    
    [self updateScrollView];
    [self updateTaskControllers];
    [self gotoPage:YES];
    
    [self setToDiligenceStartStatus];
}

- (void)copyScreen {
    CGRect rect = self.view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *screenview = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    ILDScreenshotImageManager *screenshotImageManager = [ILDScreenshotImageManager sharedInstance];
    screenshotImageManager.screenshotImage = screenview;
}

#pragma mark - Getter and Setter

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        ILDStoryModel *storyModel = [[ILDStoryDataCenter sharedInstance] prepareStoryModel];
        _backgroundImageView.image = [UIImage imageWithData:storyModel.imageData];
    }
    
    return _backgroundImageView;
}

- (UIScrollView *)clockScrollView {
    if (!_clockScrollView) {
        _clockScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _clockScrollView.pagingEnabled = YES;
        _clockScrollView.contentSize = CGSizeMake(CGRectGetWidth(_clockScrollView.frame) * self.taskIds.count, CGRectGetHeight(_clockScrollView.frame));
        _clockScrollView.showsHorizontalScrollIndicator = NO;
        _clockScrollView.showsVerticalScrollIndicator = NO;
        _clockScrollView.scrollsToTop = NO;
        _clockScrollView.delegate = self;
    }
    
    return _clockScrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = self.taskIds.count;
        _pageControl.currentPage = 0;
    }
    
    return _pageControl;
}

- (UIButton *)taskButton {
    if (!_taskButton) {
        _taskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_taskButton setImage:[UIImage imageNamed:@"menu_task_28x28_"] forState:UIControlStateNormal];
        [_taskButton addTarget:self action:@selector(clickTaskButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _taskButton;
}

- (UIButton *)statisticsButton {
    if (!_statisticsButton) {
        _statisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_statisticsButton setBackgroundImage:[UIImage imageNamed:@"menu_statistics_28x28_"] forState:UIControlStateNormal];
        [_statisticsButton addTarget:self action:@selector(clickStatisticsButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _statisticsButton;
}

- (UIButton *)storyButton {
    if (!_storyButton) {
        _storyButton = [[UIButton alloc] init];
        [_storyButton setBackgroundImage:[UIImage imageNamed:@"menu_story_28x28_"] forState:UIControlStateNormal];
        [_storyButton addTarget:self action:@selector(clickStoryButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _storyButton;
}

- (UIButton *)settingButton {
    if (!_settingButton) {
        _settingButton = [[UIButton alloc] init];
        [_settingButton setBackgroundImage:[UIImage imageNamed:@"menu_settings_26x26_"] forState:UIControlStateNormal];
        [_settingButton addTarget:self action:@selector(clickSettingButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _settingButton;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startButton addTarget:self action:@selector(clickStartButton:) forControlEvents:UIControlEventTouchUpInside];
        [_startButton setBackgroundColor:FlatRed];
        [_startButton.layer setMasksToBounds:YES];
        [_startButton.layer setCornerRadius:20];
        [_startButton setTitle:@"勤·开始" forState:UIControlStateNormal];
        [_startButton.titleLabel setFont:[UIFont fontWithName:@"-" size:24]];
        [_startButton setTitleColor:FlatWhite forState:UIControlStateNormal];
    }
    
    return _startButton;
}

- (UIButton *)pauseButton {
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pauseButton addTarget:self action:@selector(clickPauseButton:) forControlEvents:UIControlEventTouchUpInside];
        [_pauseButton.layer setMasksToBounds:YES];
        [_pauseButton.layer setCornerRadius:15];
        [_pauseButton.layer setBorderWidth:2.0f];
        [_pauseButton.layer setBorderColor:FlatWhiteDark.CGColor];
        [_pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
        [_pauseButton.titleLabel setFont:[UIFont fontWithName:@"-" size:24]];
        [_pauseButton setTitleColor:FlatWhiteDark forState:UIControlStateNormal];
    }
    
    return _pauseButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton.layer setMasksToBounds:YES];
        [_cancelButton.layer setCornerRadius:15];
        [_cancelButton.layer setBorderWidth:2.0f];
        [_cancelButton.layer setBorderColor:FlatWhiteDark.CGColor];
        [_cancelButton setTitle:@"放弃" forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont fontWithName:@"-" size:24]];
        [_cancelButton setTitleColor:FlatWhiteDark forState:UIControlStateNormal];
    }
    
    return _cancelButton;
}

- (UIButton *)resumeButton {
    if (!_resumeButton) {
        _resumeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resumeButton addTarget:self action:@selector(clickResumeButton:) forControlEvents:UIControlEventTouchUpInside];
        [_resumeButton setBackgroundColor:FlatGreen];
        [_resumeButton.layer setMasksToBounds:YES];
        [_resumeButton.layer setCornerRadius:15];
        [_resumeButton setTitle:@"继续" forState:UIControlStateNormal];
        [_resumeButton.titleLabel setFont:[UIFont fontWithName:@"-" size:24]];
        [_resumeButton setTitleColor:FlatWhite forState:UIControlStateNormal];
    }
    
    return _resumeButton;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skipButton addTarget:self action:@selector(clickSkipButton:) forControlEvents:UIControlEventTouchUpInside];
        [_skipButton setBackgroundColor:ClearColor];
        [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        [_skipButton.titleLabel setFont:[UIFont fontWithName:@"-" size:24]];
        [_skipButton setTitleColor:FlatWhite forState:UIControlStateNormal];
    }
    
    return _skipButton;
}

- (NSMutableArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < self.taskIds.count; i++) {
            [_viewControllers addObject:[NSNull null]];
        }
    }
    
    return _viewControllers;
}

- (NSArray *)taskIds {
    if (!_taskIds) {
        _taskIds = [[ILDTaskDataCenter sharedInstance] taskIds];
    }
    
    return _taskIds;
}

- (ILDTaskModel *)currentTaskModel {
    NSInteger page = self.pageControl.currentPage;
    NSString *taskId = self.taskIds[page];
    _currentTaskModel = [[ILDTaskDataCenter sharedInstance] taskConfigurationById:taskId];
    return _currentTaskModel;
}

@end
