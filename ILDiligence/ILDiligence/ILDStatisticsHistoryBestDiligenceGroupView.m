//
//  ILDStatisticsHistoryBestDiligenceGroupView.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/29.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsHistoryBestDiligenceGroupView.h"
#import "ILDStatisticsHistoryModel+IL_OperationsForViewData.h"

@interface ILDStatisticsHistoryBestDiligenceGroupView()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *everageDiligenceLabel;
@property (nonatomic, strong) UILabel *bestTaskLabel;
@property (nonatomic, strong) UILabel *bestWeekdayLabel;
@property (nonatomic, strong) UILabel *bestWeekdayPlusLabel;
@property (nonatomic, strong) UILabel *bestHourLabel;
@property (nonatomic, strong) UILabel *bestHourPlusLabel;

@property (nonatomic, strong) ILDStatisticsHistoryModel *statisticsHistoryModel;

@end

@implementation ILDStatisticsHistoryBestDiligenceGroupView

- (instancetype) initWithStatisticsHistoryModel:(ILDStatisticsHistoryModel *)statisticsHistoryModel {
    if (self = [super init]) {
        self.statisticsHistoryModel = statisticsHistoryModel;
        self.everageDiligenceLabel.text = [self.statisticsHistoryModel il_everageMinutesString];
        self.bestTaskLabel.text = self.statisticsHistoryModel.bestTask;
        self.bestWeekdayLabel.text = self.statisticsHistoryModel.bestWeekday;
        self.bestWeekdayPlusLabel.text = [self.statisticsHistoryModel il_bestWeekdayPlusString];
        self.bestHourLabel.text = self.statisticsHistoryModel.bestHour;
        self.bestHourPlusLabel.text = [self.statisticsHistoryModel il_bestHourPlusString];
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.everageDiligenceLabel];
        [self addSubview:self.bestTaskLabel];
        [self addSubview:self.bestWeekdayLabel];
        [self addSubview:self.bestWeekdayPlusLabel];
        [self addSubview:self.bestHourLabel];
        [self addSubview:self.bestHourPlusLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHeight = self.frame.size.height;
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(12);
        make.top.equalTo(self.mas_top).with.offset(12);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(21);
    }];
    
    [self.everageDiligenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(12);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(18);
    }];
    
    [self.bestWeekdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(viewWidth/2 + 48);
        make.top.mas_equalTo(viewHeight/2 - 30);
        make.width.mas_equalTo(viewWidth/2 - 48);
        make.height.mas_equalTo(21);
    }];
    
    [self.bestWeekdayPlusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(viewWidth/2 + 48);
        make.top.equalTo(self.bestWeekdayLabel.mas_bottom);
        make.width.mas_equalTo(viewWidth/2 - 48);
        make.height.mas_equalTo(21);
    }];
    
    [self.bestHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(viewWidth/2 + 48);
        make.top.equalTo(self.bestWeekdayPlusLabel.mas_bottom).with.offset(20);
        make.width.mas_equalTo(viewWidth/2 - 48);
        make.height.mas_equalTo(21);
    }];
    
    [self.bestHourPlusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(viewWidth/2 + 48);
        make.top.equalTo(self.bestHourLabel.mas_bottom);
        make.width.mas_equalTo(viewWidth/2 - 48);
        make.height.mas_equalTo(21);
    }];
    
    [self.bestTaskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(63 + (viewHeight - 63)/2 - 36);
        make.width.mas_equalTo(viewWidth/2 + 24);
        make.height.mas_equalTo(72);
    }];
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"最佳专注";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = FlatWhite;
        _titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    return _titleLabel;
}

- (UILabel *)everageDiligenceLabel {
    if (!_everageDiligenceLabel) {
        _everageDiligenceLabel = [[UILabel alloc] init];
        _everageDiligenceLabel.textAlignment = NSTextAlignmentLeft;
        _everageDiligenceLabel.textColor = FlatWhiteDark;
        _everageDiligenceLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
        
    }
    
    return _everageDiligenceLabel;
}

- (UILabel *)bestTaskLabel {
    if (!_bestTaskLabel) {
        _bestTaskLabel = [[UILabel alloc] init];
        _bestTaskLabel.textAlignment = NSTextAlignmentCenter;
        _bestTaskLabel.textColor = FlatWhiteDark;
        _bestTaskLabel.font = [UIFont fontWithName:@"-" size:48];
    }
    
    return _bestTaskLabel;
}

- (UILabel *)bestWeekdayLabel {
    if (!_bestWeekdayLabel) {
        _bestWeekdayLabel = [[UILabel alloc] init];
        _bestWeekdayLabel.textAlignment = NSTextAlignmentLeft;
        _bestWeekdayLabel.textColor = FlatWhite;
        _bestWeekdayLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    return _bestWeekdayLabel;
}

- (UILabel *)bestWeekdayPlusLabel {
    if (!_bestWeekdayPlusLabel) {
        _bestWeekdayPlusLabel = [[UILabel alloc] init];
        _bestWeekdayPlusLabel.textAlignment = NSTextAlignmentLeft;
        _bestWeekdayPlusLabel.textColor = FlatWhiteDark;
        _bestWeekdayPlusLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
    }
    
    return _bestWeekdayPlusLabel;
}

- (UILabel *)bestHourLabel {
    if (!_bestHourLabel) {
        _bestHourLabel = [[UILabel alloc] init];
        _bestHourLabel.textAlignment = NSTextAlignmentLeft;
        _bestHourLabel.textColor = FlatWhite;
        _bestHourLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    return _bestHourLabel;
}

- (UILabel *)bestHourPlusLabel {
    if (!_bestHourPlusLabel) {
        _bestHourPlusLabel = [[UILabel alloc] init];
        _bestHourPlusLabel.textAlignment = NSTextAlignmentLeft;
        _bestHourPlusLabel.textColor = FlatWhiteDark;
        _bestHourPlusLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
    }
    
    return _bestHourPlusLabel;
}

@end
