//
//  ILDTaskConfigurationNavigateModeViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskConfigurationNavigateModeViewController.h"

@interface ILDTaskConfigurationNavigateModeViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ILDTaskConfigurationNavigateModeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.templateTableView];
    self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.templateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - Event

- (void)clickBackBarButtonItem:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter and Setter

- (UITableView *)templateTableView {
    if (!_templateTableView) {
        _templateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _templateTableView.delegate = self;
        _templateTableView.dataSource = self;
        _templateTableView.tableFooterView = [[UIView alloc] init];
        _templateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _templateTableView.backgroundColor = ClearColor;
    }
    
    return _templateTableView;
}

- (UIBarButtonItem *)backBarButtonItem {
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_back_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBarButtonItem:)];
    }
    
    return _backBarButtonItem;
}

@end
