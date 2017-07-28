//
//  ILDTaskListCell.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskListCell.h"

@implementation ILDTaskListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ILDTaskListCell"];
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

- (void)ConfigureCellWithImage:(UIImage *)image Text:(NSString *)text DetailText:(NSString *)detailText {
    self.textLabel.text = text;
    self.detailTextLabel.text = detailText;
    self.imageView.image = image;
}

@end
