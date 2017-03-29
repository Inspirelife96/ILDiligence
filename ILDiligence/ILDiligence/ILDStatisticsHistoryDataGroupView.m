//
//  ILDStatisticsHistoryDataGroupView.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/29.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsHistoryDataGroupView.h"
#import "ILDStatisticsHistoryDataView.h"
#import "ILDStatisticsHistoryModel+IL_OperationsForViewData.h"

@interface ILDStatisticsHistoryDataGroupView()

@property (nonatomic, strong) ILDStatisticsHistoryModel *statisticsHistoryModel;
@property (nonatomic, strong) ILDStatisticsHistoryDataView *diligenceTimesView;
@property (nonatomic, strong) ILDStatisticsHistoryDataView *diligenceHoursView;
@property (nonatomic, strong) ILDStatisticsHistoryDataView *diligenceDaysView;

@end

@implementation ILDStatisticsHistoryDataGroupView

- (instancetype) initWithStatisticsHistoryModel:(ILDStatisticsHistoryModel *)statisticsHistoryModel {
    if (self = [super init]) {
        self.statisticsHistoryModel = statisticsHistoryModel;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.diligenceTimesView];
    [self addSubview:self.diligenceHoursView];
    [self addSubview:self.diligenceDaysView];
    
    [self.diligenceTimesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(self.frame.size.width/3);
        make.height.mas_equalTo(self.frame.size.height);
    }];
    
    [self.diligenceHoursView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(self.frame.size.width/3);
        make.top.equalTo(self);
        make.width.mas_equalTo(self.frame.size.width/3);
        make.height.mas_equalTo(self.frame.size.height);
    }];
    
    [self.diligenceDaysView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(2*self.frame.size.width/3);
        make.top.equalTo(self);
        make.width.mas_equalTo(self.frame.size.width/3);
        make.height.mas_equalTo(self.frame.size.height);
    }];
}

- (ILDStatisticsHistoryDataView *)diligenceTimesView {
    if (!_diligenceTimesView) {
        _diligenceTimesView = [[ILDStatisticsHistoryDataView alloc] initWithDataValue:[self.statisticsHistoryModel il_diligenceTimesValue]
                                                                                title:[self.statisticsHistoryModel il_diligenceTimesTitle]];
    }
    
    return _diligenceTimesView;
}

- (ILDStatisticsHistoryDataView *)diligenceHoursView {
    if (!_diligenceHoursView) {
        _diligenceHoursView = [[ILDStatisticsHistoryDataView alloc] initWithDataValue:[self.statisticsHistoryModel il_diligenceHoursValue]
                                                                                title:[self.statisticsHistoryModel il_diligenceHoursTitle]];
    }
    
    return _diligenceHoursView;
}

- (ILDStatisticsHistoryDataView *)diligenceDaysView {
    if (!_diligenceDaysView) {
        _diligenceDaysView = [[ILDStatisticsHistoryDataView alloc] initWithDataValue:[self.statisticsHistoryModel il_diligenceDaysValue]
                                                                               title:[self.statisticsHistoryModel il_diligenceDaysTitle]];
    }
    
    return _diligenceDaysView;
}

@end
