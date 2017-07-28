//
//  ILDTaskConfigurationSwitchCell.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskConfigurationSwitchCell.h"

@implementation ILDTaskConfigurationSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ConfigurationSwitchCell"];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = ClearColor;
        self.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
        self.textLabel.textColor = FlatWhite;
        self.detailTextLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
        self.detailTextLabel.textColor = FlatWhiteDark;
        
        [self.contentView addSubview:self.configurationSwitch];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.configurationSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-24);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(32);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Getter and Setter

- (UISwitch *)configurationSwitch {
    if (!_configurationSwitch) {
        _configurationSwitch = [[UISwitch alloc] init];
        _configurationSwitch.onTintColor = FlatGreen;
        _configurationSwitch.transform = CGAffineTransformMakeScale(0.85, 0.85);
    }
    
    return _configurationSwitch;
}

@end
