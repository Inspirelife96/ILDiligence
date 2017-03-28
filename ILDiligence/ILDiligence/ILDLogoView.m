//
//  ILDLogoView.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDLogoView.h"

@interface ILDLogoView()

@property(nonatomic, strong) UIImageView *appIconImageView;
@property(nonatomic, strong) UILabel *appNameLabel;
@property(nonatomic, strong) UILabel *appDescriptionLabel;

@end

@implementation ILDLogoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.appIconImageView];
        [self addSubview:self.appNameLabel];
        [self addSubview:self.appDescriptionLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewWidth = self.frame.size.width;
    
    [self.appIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    [self.appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.appIconImageView.mas_bottom).with.offset(12);
        make.width.mas_equalTo(viewWidth - 16);
        make.height.mas_equalTo(21);
    }];
    
    [self.appDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.appNameLabel.mas_bottom).with.offset(8);
        make.width.mas_equalTo(viewWidth - 16);
        make.height.mas_equalTo(42);
    }];
}

#pragma mark - Getter and Setter

- (UIImageView *)appIconImageView {
    if (!_appIconImageView) {
        _appIconImageView = [[UIImageView alloc] init];
        _appIconImageView.layer.masksToBounds = YES;
        _appIconImageView.layer.cornerRadius = 20;
        _appIconImageView.image = [UIImage imageNamed:@"iphone app 60"];
    }
    
    return _appIconImageView;
}

- (UILabel *)appNameLabel {
    if (!_appNameLabel) {
        _appNameLabel = [[UILabel alloc] init];
        _appNameLabel.text = @"勤之时";
        _appNameLabel.textAlignment = NSTextAlignmentCenter;
        _appNameLabel.textColor = FlatWhite;
        _appNameLabel.font = [UIFont fontWithName:@"-" size:20];
    }
    
    return _appNameLabel;
}

- (UILabel *)appDescriptionLabel {
    if (!_appDescriptionLabel) {
        _appDescriptionLabel = [[UILabel alloc] init];
        _appDescriptionLabel.text = @"美好的励志时光";
        _appDescriptionLabel.textAlignment = NSTextAlignmentCenter;
        _appDescriptionLabel.textColor = FlatWhiteDark;
        _appDescriptionLabel.font = [UIFont fontWithName:@"-" size:18];
        _appDescriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _appDescriptionLabel.numberOfLines = 0;
    }
    
    return _appDescriptionLabel;
}

@end
