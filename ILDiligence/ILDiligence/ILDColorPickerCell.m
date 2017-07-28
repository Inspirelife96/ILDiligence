//
//  ILDColorPickerCell.m
//  energy
//
//  Created by XueFeng Chen on 2017/2/9.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "ILDColorPickerCell.h"
#import "UIImage+IL_ContentWithColor.h"

@interface ILDColorPickerCell()

@property (nonatomic, strong) UILabel *colorNameLabel;
@property (nonatomic, strong) UIImageView *colorImageView;

@end

@implementation ILDColorPickerCell

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.colorNameLabel];
        [self addSubview:self.colorImageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.colorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).with.offset(-32);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [self.colorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(self.frame.size.width/2);
        make.height.mas_equalTo(21);
    }];
}

#pragma mark - Getter and Setter

- (UILabel *)colorNameLabel {
    if (!_colorNameLabel) {
        _colorNameLabel = [[UILabel alloc] init];
        _colorNameLabel.textAlignment = NSTextAlignmentCenter;
        _colorNameLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
        _colorNameLabel.textColor = FlatWhite;
    }
    
    return _colorNameLabel;
}

- (UIImageView *)colorImageView {
    if (!_colorImageView) {
        _colorImageView = [[UIImageView alloc] init];
    }
    
    return _colorImageView;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    UIImage *iconImage = [UIImage imageNamed:@"menu_slider_thumb_16x16_"];
    self.colorImageView.image = [iconImage il_imageContentWithColor:_color];
}

- (void)setColorName:(NSString *)colorName {
    _colorName = colorName;
    self.colorNameLabel.text = _colorName;
}

@end
