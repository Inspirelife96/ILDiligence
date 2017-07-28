//
//  ILDTaskConfigurationNavigateModeViewController.h
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILDBaseViewController.h"

@interface ILDTaskConfigurationNavigateModeViewController : ILDBaseViewController

@property (nonatomic, strong) UITableView *templateTableView;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;

- (void)clickBackBarButtonItem:(id)sender;

@end
