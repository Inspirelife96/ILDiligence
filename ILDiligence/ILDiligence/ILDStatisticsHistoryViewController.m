//
//  ILDStatisticsHistoryViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsHistoryViewController.h"
#import "ILDStatisticsHistoryBarChartView.h"
#import "ILDStatisticsHistoryPieChartView.h"

typedef NS_ENUM(NSInteger, ILDChartMode) {
    ILDChartModeBar,
    ILDChartModePie
};

@interface ILDStatisticsHistoryViewController () <ChartViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *chartModeButtonItem;
@property (nonatomic, strong) ILDStatisticsHistoryBarChartView *historyBarChartView;
@property (nonatomic, strong) ILDStatisticsHistoryPieChartView *historyPieChartView;

@property (nonatomic, strong) ILDStatisticsHistoryModel *statisticsHistoryModel;
@property (nonatomic, assign) ILDChartMode chartMode;

@end

@implementation ILDStatisticsHistoryViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.historyBarChartView];
    [self.view addSubview:self.historyPieChartView];
    
    [self.historyBarChartView setHidden:NO];
    [self.historyPieChartView setHidden:YES];
    
    self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    self.navigationItem.rightBarButtonItem = self.chartModeButtonItem;
    self.navigationItem.title = @"历史数据";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Do data fetch if needed.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.historyBarChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.historyPieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event

- (void)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickChartModeButton:(id)sender {
    [UIView beginAnimations:@"doflip" context:nil];
    //设置时常
    [UIView setAnimationDuration:2];
    //设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置翻转方向
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromLeft  forView:self.view cache:YES];
    [self.historyBarChartView setHidden:![self.historyBarChartView isHidden]];
    [self.historyPieChartView setHidden:![self.historyPieChartView isHidden]];
    //动画结束
    [UIView commitAnimations];
    
    if (self.chartMode == ILDChartModeBar) {
        self.chartMode = ILDChartModePie;
        [self.chartModeButtonItem setImage:[UIImage imageNamed:@"global_barchart_icon_28x28_"]];
    } else {
        self.chartMode = ILDChartModePie;
        [self.chartModeButtonItem setImage:[UIImage imageNamed:@"global_piechart_icon_28x28_"]];
    }
}

#pragma mark - Getter and Setter

- (UIBarButtonItem *)backBarButtonItem {
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_back_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackButton:)];
    }
    
    return _backBarButtonItem;
}

- (UIBarButtonItem *)chartModeButtonItem {
    if (!_chartModeButtonItem) {
        _chartModeButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_piechart_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickChartModeButton:)];
        _chartMode = ILDChartModeBar;
    }
    
    return _chartModeButtonItem;
}

- (ILDStatisticsHistoryBarChartView *)historyBarChartView {
    if (!_historyBarChartView) {
        _historyBarChartView = [[ILDStatisticsHistoryBarChartView alloc] initWithStatisticsHistoryModel:self.statisticsHistoryModel];
    }
    
    return _historyBarChartView;
}

- (ILDStatisticsHistoryPieChartView *)historyPieChartView {
    if (!_historyPieChartView) {
        _historyPieChartView = [[ILDStatisticsHistoryPieChartView alloc] initWithStatisticsHistoryModel:self.statisticsHistoryModel];
    }
    
    return _historyPieChartView;
}


- (ILDStatisticsHistoryModel *)statisticsHistoryModel {
    if (!_statisticsHistoryModel) {
        _statisticsHistoryModel = [[ILDDiligenceDataCenter sharedInstance] prepareStatisticsHistory];
    }
    
    return _statisticsHistoryModel;
}
@end
