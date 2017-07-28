//
//  ILDTaskConfigurationPresentModeViewController.h
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILDBaseViewController.h"

@interface ILDTaskConfigurationPresentModeViewController : ILDBaseViewController

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) ILDTaskModel *taskConfiguration;

- (void)clickCloseButton:(id)sender;

@end
