//
//  ILDStatisticsHistoryBarChartGroupView.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/29.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsHistoryBarChartGroupView.h"
#import "ILDBarChartDataValueFormatter.h"

@interface ILDStatisticsHistoryBarChartGroupView() <ChartViewDelegate, IChartValueFormatter>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *daysLabel;
@property (nonatomic, strong) UILabel *diligenceTimesLabel;
@property (nonatomic, strong) UIButton *weekButton;
@property (nonatomic, strong) UIButton *monthButton;
@property (nonatomic, strong) BarChartView *barChartView;

@property (nonatomic, strong) NSArray *barChartDataArray;

@end

@implementation ILDStatisticsHistoryBarChartGroupView

- (instancetype) initWithBarChartData:(NSArray *)barChartDataArray {
    if (self = [super init]) {
        self.barChartDataArray = barChartDataArray;
        
        [self setData:7];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.daysLabel];
    [self addSubview:self.diligenceTimesLabel];
    [self addSubview:self.weekButton];
    [self addSubview:self.monthButton];
    [self addSubview:self.barChartView];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.daysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(12);
        make.top.equalTo(self.mas_top).with.offset(12);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(21);
    }];
    
    [self.diligenceTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(12);
        make.top.equalTo(self.daysLabel.mas_bottom);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(18);
    }];
    
    [self.monthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-12);
        make.top.equalTo(self.mas_top).with.offset(18);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.weekButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.monthButton.mas_left).with.offset(-12);
        make.top.equalTo(self.mas_top).with.offset(18);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.mas_equalTo(68);
        make.width.mas_equalTo(self.frame.size.width - 40);
        make.height.mas_equalTo(self.frame.size.height - 75);
    }];
}

- (void)clickWeekButton:(id)sender {
    [self.weekButton setSelected:YES];
    [self.monthButton setSelected:NO];
    
    [self setData:7];
}

- (void)clickMonthButton:(id)sender {
    [self.weekButton setSelected:NO];
    [self.monthButton setSelected:YES];
    
    [self setData:30];
}

- (UILabel *)daysLabel {
    if (!_daysLabel) {
        _daysLabel = [[UILabel alloc] init];
        _daysLabel.textAlignment = NSTextAlignmentLeft;
        _daysLabel.textColor = FlatWhite;
        _daysLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    return _daysLabel;
}

- (UILabel *)diligenceTimesLabel {
    if (!_diligenceTimesLabel) {
        _diligenceTimesLabel = [[UILabel alloc] init];
        _diligenceTimesLabel.textAlignment = NSTextAlignmentLeft;
        _diligenceTimesLabel.textColor = FlatWhiteDark;
        _diligenceTimesLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
        
    }
    
    return _diligenceTimesLabel;
}

- (UIButton *)weekButton {
    if (!_weekButton) {
        _weekButton = [[UIButton alloc] init];
        [_weekButton setTitle:@"周" forState:UIControlStateNormal];
        [_weekButton.titleLabel setFont:[UIFont fontWithName:@"Avenir Next" size:10]];
        [_weekButton setTitleColor:FlatWhite forState:UIControlStateSelected];
        [_weekButton setTitleColor:FlatWhiteDark forState:UIControlStateNormal];
        [_weekButton addTarget:self action:@selector(clickWeekButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _weekButton;
}

- (UIButton *)monthButton {
    if (!_monthButton) {
        _monthButton = [[UIButton alloc] init];
        [_monthButton setTitle:@"月" forState:UIControlStateNormal];
        [_monthButton.titleLabel setFont:[UIFont fontWithName:@"Avenir Next" size:10]];
        [_monthButton setTitleColor:FlatWhite forState:UIControlStateSelected];
        [_monthButton setTitleColor:FlatWhiteDark forState:UIControlStateNormal];
        [_monthButton addTarget:self action:@selector(clickMonthButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _monthButton;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        [_backgroundView setBackgroundColor:FlatWhite];
        [_backgroundView setAlpha:0.1];
        _backgroundView.layer.cornerRadius = 20;
        _backgroundView.layer.masksToBounds = YES;
    }
    
    return _backgroundView;
}

- (BarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [[BarChartView alloc] init];
        _barChartView.delegate = self;
        _barChartView.backgroundColor = ClearColor;
        _barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
        _barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
        _barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
        _barChartView.scaleYEnabled = NO;//取消Y轴缩放
        _barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _barChartView.dragEnabled = YES;//启用拖拽图表
        _barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        _barChartView.fitBars = NO;
        _barChartView.chartDescription.enabled = NO;
        _barChartView.legend.enabled = NO;
        
        
        ChartXAxis *xAxis = _barChartView.xAxis;
        xAxis.axisLineWidth = 2;//设置X轴线宽
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = NO;//不绘制网格线
        xAxis.labelTextColor = FlatWhite;//label文字颜色
        xAxis.valueFormatter = [[ILDBarChartDataValueFormatter alloc] init];
        _barChartView.rightAxis.enabled = NO;
        _barChartView.leftAxis.enabled = NO;
        _barChartView.descriptionText = @"";
    }
    
    return _barChartView;
}


- (void)setData:(NSInteger)showDays {
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    NSInteger totalCount = 0;
    
    for (int i = 0; i <= showDays; i++) {
        NSInteger diligenceTimes = [self.barChartDataArray[i] integerValue];
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:(double)i y:(double)diligenceTimes]];
        totalCount += diligenceTimes;
    }
    
    BarChartDataSet *set1 = nil;
    set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@""];
    [set1 setColor:FlatWhiteDark];
    [set1 setValueTextColor:FlatWhiteDark];
    set1.valueFormatter = self;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    data.barWidth = 0.1f * showDays / 7;

    self.barChartView.data = data;
    [self.barChartView animateWithYAxisDuration:1.0f];
    
    self.daysLabel.text = [NSString stringWithFormat:@"过去 %ld 天", (long)showDays];
    self.diligenceTimesLabel.text = [NSString stringWithFormat:@"累计 %ld 次专注", (long)totalCount];
}

- (NSString * _Nonnull)stringForValue:(double)value entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler; {
    if ((NSInteger)value == 0) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%ld", (long)value];
    }
}

@end
