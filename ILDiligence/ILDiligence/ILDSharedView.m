//
//  ILDSharedView.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/13.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "ILDSharedView.h"
#import "UILabel+StringFrame.h"

@interface ILDSharedView()

@property (nonatomic, strong) UIImageView *storyImageView;
@property (nonatomic, strong) UIImageView *codeImage;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *storyTitleLabel;
@property (nonatomic, strong) UILabel *storyDetailLabel;

@end

@implementation ILDSharedView

- (instancetype)initWithStoryImage:(UIImage *)image storyTitle:(NSString *)storyTitle storyDetail:(NSString *)storyDetail {
    if (self = [super init]) {
        self.storyImageView.image = image;
        self.storyTitleLabel.text = storyTitle;
        self.storyDetailLabel.text = storyDetail;
        
        [self addSubview:self.storyImageView];
        [self addSubview:self.codeImage];
        [self addSubview:self.dateLabel];
        [self addSubview:self.storyTitleLabel];
        [self addSubview:self.storyDetailLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.storyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight);
    }];
    
    [self.codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(ScreenHeight - 64);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(68);
        make.top.mas_equalTo(ScreenHeight - 64);
        make.width.mas_equalTo(ScreenWidth - 68);
        make.height.mas_equalTo(26);
    }];
    
    [self.storyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(68);
        make.top.mas_equalTo(ScreenHeight - 36);
        make.width.mas_equalTo(ScreenWidth - 68);
        make.height.mas_equalTo(21);
    }];
    
    [self.storyDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [self.storyDetailLabel boundingRectWithSize:CGSizeMake(ScreenWidth - 16.0f, 0.0f) attributes:nil];
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height + 21);
        make.left.mas_equalTo(8);
        make.top.mas_equalTo(ScreenHeight - 70 - size.height - 21);
    }];
}

- (UIImageView *)storyImageView {
    if (!_storyImageView) {
        _storyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _storyImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _storyImageView;
}

- (UIImageView *)codeImage {
    if (!_codeImage) {
        _codeImage = [[UIImageView alloc] init ];
        _codeImage.image = [UIImage imageNamed:@"daycard_qrcode_50x50_"];
    }
    
    return _codeImage;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        NSString *todaysString = [ILDDateHelper stringOfDayWithWeekDay:[NSDate date]] ;

        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = FlatWhite;
        _dateLabel.font = [UIFont fontWithName:@"-" size:16];
        _dateLabel.text = todaysString;

    }
    
    return _dateLabel;
}

- (UILabel *)storyTitleLabel {
    if (!_storyTitleLabel) {
        _storyTitleLabel = [[UILabel alloc] init];
        _storyTitleLabel.textAlignment = NSTextAlignmentCenter;
        _storyTitleLabel.textColor = FlatWhite;
        _storyTitleLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    return _storyTitleLabel;
}

- (UILabel *)storyDetailLabel {
    if (!_storyDetailLabel) {
        _storyDetailLabel = [[UILabel alloc] init];
        _storyDetailLabel.numberOfLines = -1;
        _storyDetailLabel.textAlignment = NSTextAlignmentLeft;
        _storyDetailLabel.textColor = FlatWhite;
        _storyDetailLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
    }
    
    return _storyDetailLabel;
}

@end
