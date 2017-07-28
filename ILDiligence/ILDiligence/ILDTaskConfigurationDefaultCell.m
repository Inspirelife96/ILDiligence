//
//  ILDTaskConfigurationDefaultCell.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskConfigurationDefaultCell.h"

@implementation ILDTaskConfigurationDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TaskListCell"];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = ClearColor;
        self.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
        self.textLabel.textColor = FlatWhite;
        self.detailTextLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
        self.detailTextLabel.textColor = FlatWhiteDark;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
