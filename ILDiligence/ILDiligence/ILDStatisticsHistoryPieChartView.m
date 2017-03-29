//
//  ILDStatisticsHistoryPieChartView.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsHistoryPieChartView.h"
#import "ILDStatisticsHistoryDataGroupView.h"
#import "ILDPieChartDataModel+IL_OperationsForViewData.h"

@interface ILDStatisticsHistoryPieChartView()

@property (nonatomic, strong) ILDStatisticsHistoryDataGroupView *dataGroupView;
@property (nonatomic, strong) PieChartView *pieChartView;
@property (nonatomic, strong) UILabel *bestTaskLabel;
@property (nonatomic, strong) UILabel *bestTaskNameLabel;

@property (nonatomic, strong) ILDStatisticsHistoryModel *statisticsHistoryModel;

@end

@implementation ILDStatisticsHistoryPieChartView

- (instancetype) initWithStatisticsHistoryModel:(ILDStatisticsHistoryModel *)statisticsHistoryModel {
    if (self = [super init]) {
        self.statisticsHistoryModel = statisticsHistoryModel;
        self.bestTaskNameLabel.text = self.statisticsHistoryModel.bestTask;

        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.dataGroupView];
    [self addSubview:self.pieChartView];
    [self addSubview:self.bestTaskLabel];
    [self addSubview:self.bestTaskNameLabel];
    
    [self.dataGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(64 + (ScreenHeight - 128)/6 - 30);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(3*ScreenWidth/5);
        make.height.mas_equalTo(61);
    }];
    
    CGFloat pieChartHeight = (ScreenHeight - 64 - 64)/2;
    if (pieChartHeight > ScreenWidth) {
        pieChartHeight = ScreenWidth;
    }
    
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(pieChartHeight);
        make.height.mas_equalTo(pieChartHeight);
    }];
    
    [self.bestTaskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.pieChartView.mas_bottom).with.offset(64);
        make.width.mas_equalTo(ScreenWidth - 16.0f);
        make.height.mas_equalTo(21);
    }];
    
    [self.bestTaskNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.bestTaskLabel.mas_bottom).with.offset(20);
        make.width.mas_equalTo(ScreenWidth - 16.0f);
        make.height.mas_equalTo(21);
    }];
    
    [self setData];
}

#pragma mark - Private Method

- (void)setData {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"勤之时"];
    
    if ([self.statisticsHistoryModel.dataForPieChartArray count] > 0) {
        for (int i = 0; i < [self.self.statisticsHistoryModel.dataForBarChartArray count]; i++) {
            ILDPieChartDataModel *pieChartDataModel = self.self.statisticsHistoryModel.dataForPieChartArray[i];
            
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
    if ([self.statisticsHistoryModel.dataForPieChartArray count] > 0) {
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

- (PieChartView *)pieChartView {
    if (!_pieChartView) {
        _pieChartView = [[PieChartView alloc] init];
        _pieChartView.legend.enabled = NO;
        _pieChartView.drawCenterTextEnabled = YES;
        _pieChartView.chartDescription.enabled = NO;
        [_pieChartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    }
    
    return _pieChartView;
}

- (UILabel *)bestTaskLabel {
    if (!_bestTaskLabel) {
        _bestTaskLabel = [[UILabel alloc] init];
        _bestTaskLabel.text = @"最佳任务";
        _bestTaskLabel.textAlignment = NSTextAlignmentCenter;
        _bestTaskLabel.textColor = FlatWhite;
        _bestTaskLabel.font = [UIFont fontWithName:@"-" size:24];
    }
    
    return _bestTaskLabel;
}

- (UILabel *)bestTaskNameLabel {
    if (!_bestTaskNameLabel) {
        _bestTaskNameLabel = [[UILabel alloc] init];
        _bestTaskNameLabel.textAlignment = NSTextAlignmentCenter;
        _bestTaskNameLabel.textColor = FlatWhiteDark;
        _bestTaskNameLabel.font = [UIFont fontWithName:@"-" size:32];
    }
    
    return _bestTaskNameLabel;
}

- (ILDStatisticsHistoryDataGroupView *)dataGroupView {
    if (!_dataGroupView) {
        _dataGroupView = [[ILDStatisticsHistoryDataGroupView alloc] initWithStatisticsHistoryModel:self.statisticsHistoryModel];
    }
    
    return _dataGroupView;
}

@end
