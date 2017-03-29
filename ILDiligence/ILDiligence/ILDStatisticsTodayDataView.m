//
//  ILDStatisticsTodayDataView.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStatisticsTodayDataView.h"

@interface ILDStatisticsTodayDataView()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation ILDStatisticsTodayDataView

- (instancetype) initWithDataValue:(NSString *)value title:(NSString *)title icon:(UIImage *)icon {
    if (self = [super init]) {
        self.iconImageView.image = icon;
        self.titleLabel.text = title;
        self.valueLabel.text = value;
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.valueLabel];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom);
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(21);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(21);
    }];
    
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        
    }
    
    return _iconImageView;
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
        _valueLabel.textColor = FlatWhiteDark;
        _valueLabel.font = [UIFont fontWithName:@"Avenir Next" size:24];
    }
    
    return _valueLabel;
}

@end
