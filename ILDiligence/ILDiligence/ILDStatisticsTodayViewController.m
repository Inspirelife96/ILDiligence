//
//  ILDStatisticsTodayViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/25.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsTodayViewController.h"
#import "ILDStatisticsTodayDataView.h"
#import "ILDStatisticsHistoryViewController.h"
#import "ILDStatisticsTodayModel+IL_OperationsForViewData.h"
#import "ILDPieChartDataModel+IL_OperationsForViewData.h"

@interface ILDStatisticsTodayViewController () <ChartViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *closeBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *historyBarButtonItem;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) ILDStatisticsTodayDataView *diligenceTimesView;
@property (nonatomic, strong) ILDStatisticsTodayDataView *diligenceHoursView;
@property (nonatomic, strong) ILDStatisticsTodayDataView *diligenceFocusView;
@property (nonatomic, strong) PieChartView *pieChartView;

@property (nonatomic, strong) ILDStatisticsTodayModel *statisticsTodayModel;

@end

@implementation ILDStatisticsTodayViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.diligenceTimesView];
    [self.view addSubview:self.diligenceHoursView];
    [self.view addSubview:self.diligenceFocusView];
    [self.view addSubview:self.pieChartView];
    
    self.navigationItem.leftBarButtonItem = self.closeBarButtonItem;
    self.navigationItem.rightBarButtonItem = self.historyBarButtonItem;
    self.navigationItem.title = @"今日统计";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat pieChartYPos = 64;
    CGFloat pieChartHeight = (ScreenHeight - 64 - 64)/2;
    if (pieChartHeight > ScreenWidth) {
        pieChartHeight = ScreenWidth;
    }
    
    CGFloat descriptionLabelYPos = 64 + pieChartHeight + pieChartHeight/4 - 4 - 21;
    CGFloat statisticsViewYPos = 64 + pieChartHeight + pieChartHeight/2 + pieChartHeight/4 - 40;
    
    
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).with.offset(pieChartYPos);
        make.width.mas_equalTo(pieChartHeight);
        make.height.mas_equalTo(pieChartHeight);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).with.offset(descriptionLabelYPos);
        make.width.mas_equalTo(ScreenWidth - 16.0f);
        make.height.mas_equalTo(21);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.descriptionLabel.mas_bottom).with.offset(8);
        make.width.mas_equalTo(ScreenWidth - 16.0f);
        make.height.mas_equalTo(21);
    }];
    
    [self.diligenceTimesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(statisticsViewYPos);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth/3);
        make.height.mas_equalTo(80);
    }];
    
    [self.diligenceHoursView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(statisticsViewYPos);
        make.left.mas_equalTo(ScreenWidth/3);
        make.width.mas_equalTo(ScreenWidth/3);
        make.height.mas_equalTo(80);
    }];
    
    [self.diligenceFocusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(statisticsViewYPos);
        make.left.mas_equalTo(2*ScreenWidth/3);
        make.width.mas_equalTo(ScreenWidth/3);
        make.height.mas_equalTo(80);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event
- (void)clickHistoryButton:(id)sender {
    ILDStatisticsHistoryViewController *statisticsHistoryVC = [[ILDStatisticsHistoryViewController alloc] init];
    [self.navigationController pushViewController:statisticsHistoryVC animated:YES];
}

- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Method

- (void)setData {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"勤之时"];
    
    if ([self.statisticsTodayModel.diligenceDataArray count] > 0) {
        for (int i = 0; i < [self.statisticsTodayModel.diligenceDataArray count]; i++) {
            ILDPieChartDataModel *pieChartDataModel = self.statisticsTodayModel.diligenceDataArray[i];
            
            [values addObject:[[PieChartDataEntry alloc] initWithValue:[pieChartDataModel il_diligenceMinutes]
                                                                 label:[pieChartDataModel il_diligenceTaskName]]];
            [colors addObject:[pieChartDataModel il_diligenceTaskColor]];
        }
    } else {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:10 label:@""]];
        [colors addObject:FlatSand];
        centerText = [[NSMutableAttributedString alloc] initWithString:@"无数据"];
    }
    
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"-" size:16.f],
                                NSForegroundColorAttributeName: FlatBlueDark
                                } range:NSMakeRange(0, centerText.length)];
    self.pieChartView.centerAttributedText = centerText;
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@"Election Results"];
    dataSet.sliceSpace = 2.0;
    dataSet.colors = colors;
    if ([self.statisticsTodayModel.diligenceDataArray count] > 0) {
        dataSet.drawValuesEnabled = YES;
    } else {
        dataSet.drawValuesEnabled = NO;
    }
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" 分钟";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    self.pieChartView.data = data;
    [self.pieChartView highlightValues:nil];
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight {
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView {
    NSLog(@"chartValueNothingSelected");
}

#pragma mark - Getter and Setter

- (UIBarButtonItem *)historyBarButtonItem {
    if (!_historyBarButtonItem) {
        _historyBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_barchart_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickHistoryButton:)];
    }
    
    return _historyBarButtonItem;
}

- (UIBarButtonItem *)closeBarButtonItem {
    if (!_closeBarButtonItem) {
        _closeBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_close_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton:)];
    }
    
    return _closeBarButtonItem;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.text = @"今日专注";
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.textColor = FlatWhite;
        _descriptionLabel.font = [UIFont fontWithName:@"-" size:18];
        
    }
    
    return _descriptionLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.text = [ILDDateHelper stringOfDay:[NSDate date]];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = FlatWhiteDark;
        _dateLabel.font = [UIFont fontWithName:@"-" size:14];
        
    }
    
    return _dateLabel;
}

- (ILDStatisticsTodayDataView *)diligenceTimesView {
    if (!_diligenceTimesView) {
        _diligenceTimesView = [[ILDStatisticsTodayDataView alloc] initWithDataValue:[self.statisticsTodayModel il_diligenceTimesValue]
                                                                              title:[self.statisticsTodayModel il_diligenceTimesTitle]
                                                                               icon:[self.statisticsTodayModel il_diligenceTimesIcon]];
    }
    
    return _diligenceTimesView;
}

- (ILDStatisticsTodayDataView *)diligenceHoursView {
    if (!_diligenceHoursView) {
        _diligenceHoursView = [[ILDStatisticsTodayDataView alloc] initWithDataValue:[self.statisticsTodayModel il_diligenceHoursValue]
                                                                              title:[self.statisticsTodayModel il_diligenceHoursTitle]
                                                                               icon:[self.statisticsTodayModel il_diligenceHoursIcon]];
    }
    
    return _diligenceHoursView;
}

- (ILDStatisticsTodayDataView *)diligenceFocusView {
    if (!_diligenceFocusView) {
        _diligenceFocusView = [[ILDStatisticsTodayDataView alloc] initWithDataValue:[self.statisticsTodayModel il_diligenceFocusValue]
                                                                              title:[self.statisticsTodayModel il_diligenceFocusTitle]
                                                                               icon:[self.statisticsTodayModel il_diligenceFocusIcon]];
    }
    
    return _diligenceFocusView;
}

- (PieChartView *)pieChartView {
    if (!_pieChartView) {
        _pieChartView = [[PieChartView alloc] init];
        _pieChartView.delegate = self;
        _pieChartView.legend.enabled = NO;
        _pieChartView.drawCenterTextEnabled = YES;
        _pieChartView.chartDescription.enabled = NO;
        [_pieChartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    }
    
    return _pieChartView;
}

- (ILDStatisticsTodayModel *)statisticsTodayModel {
    if (!_statisticsTodayModel) {
        _statisticsTodayModel = [[ILDDiligenceDataCenter sharedInstance] prepareStatisticsToday];
    }
    
    return _statisticsTodayModel;
}

@end
