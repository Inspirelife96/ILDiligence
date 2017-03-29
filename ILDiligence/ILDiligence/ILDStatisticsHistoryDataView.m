//
//  ILDStatisticsHistoryDataView.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/29.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsHistoryDataView.h"

@interface ILDStatisticsHistoryDataView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation ILDStatisticsHistoryDataView

- (instancetype) initWithDataValue:(NSString *)value title:(NSString *)title {
    if (self = [super init]) {
        self.valueLabel.text = value;
        self.titleLabel.text = title;
        
        [self addSubview:self.valueLabel];
        [self addSubview:self.titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(ScreenWidth/3);
        make.height.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.valueLabel.mas_bottom);
        make.width.mas_equalTo(ScreenWidth/3);
        make.height.mas_equalTo(21);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = FlatWhiteDark;
        _titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:8];
    }
    
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.textColor = FlatWhite;
        _valueLabel.font = [UIFont fontWithName:@"Avenir Next" size:28];
    }
    
    return _valueLabel;
}

@end
