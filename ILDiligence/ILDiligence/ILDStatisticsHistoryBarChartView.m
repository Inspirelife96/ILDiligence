//
//  ILDStatisticsHistoryBarChartView.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsHistoryBarChartView.h"
#import "ILDStatisticsHistoryDataGroupView.h"
#import "ILDStatisticsHistoryBarChartGroupView.h"
#import "ILDStatisticsHistoryBestDiligenceGroupView.h"

@interface ILDStatisticsHistoryBarChartView()

@property (nonatomic, strong) ILDStatisticsHistoryDataGroupView *dataGroupView;
@property (nonatomic, strong) ILDStatisticsHistoryBarChartGroupView *barChartGroupView;
@property (nonatomic, strong) ILDStatisticsHistoryBestDiligenceGroupView *bestDiligenceGroupView;

@property (nonatomic, strong) ILDStatisticsHistoryModel *statisticsHistoryModel;

@end

@implementation ILDStatisticsHistoryBarChartView

- (instancetype) initWithStatisticsHistoryModel:(ILDStatisticsHistoryModel *)statisticsHistoryModel {
    if (self = [super init]) {
        self.statisticsHistoryModel = statisticsHistoryModel;

        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.dataGroupView];
    [self addSubview:self.barChartGroupView];
    [self addSubview:self.bestDiligenceGroupView];
    
    [self.dataGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(64 + (ScreenHeight - 128)/6 - 30);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(3*ScreenWidth/5);
        make.height.mas_equalTo(61);
    }];
    
    [self.barChartGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(64 + (ScreenHeight - 128)/3);
        make.left.equalTo(self.mas_left).with.offset(12);
        make.width.mas_equalTo(ScreenWidth - 24);
        make.height.mas_equalTo((ScreenHeight - 128)/3);
    }];
    
    [self.bestDiligenceGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(64 + 2*(ScreenHeight - 128)/3 + 20);
        make.left.equalTo(self.mas_left).with.offset(12);
        make.width.mas_equalTo(ScreenWidth - 24);
        make.height.mas_equalTo((ScreenHeight - 128)/3);
    }];
    
}

- (ILDStatisticsHistoryDataGroupView *)dataGroupView {
    if (!_dataGroupView) {
        _dataGroupView = [[ILDStatisticsHistoryDataGroupView alloc] initWithStatisticsHistoryModel:self.statisticsHistoryModel];
    }
    
    return _dataGroupView;
}

- (ILDStatisticsHistoryBarChartGroupView *)barChartGroupView {
    if (!_barChartGroupView) {
        _barChartGroupView = [[ILDStatisticsHistoryBarChartGroupView alloc] initWithBarChartData:self.statisticsHistoryModel.dataForBarChartArray];
    }
    
    return _barChartGroupView;
}

- (ILDStatisticsHistoryBestDiligenceGroupView *)bestDiligenceGroupView {
    if (!_bestDiligenceGroupView) {
        _bestDiligenceGroupView = [[ILDStatisticsHistoryBestDiligenceGroupView alloc] initWithStatisticsHistoryModel:self.statisticsHistoryModel];
    }
    
    return _bestDiligenceGroupView;
}


@end
