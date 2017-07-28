//
//  ILDTaskListViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/25.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskListViewController.h"
#import "ILDTaskListCell.h"
#import "ILDTaskModel+IL_OperationsForViewData.h"
#import "ILDTaskConfigurationViewController.h"
#import "ILDLogoView.h"

@interface ILDTaskListViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *taskListTableView;
@property(nonatomic, strong) UIBarButtonItem *closeBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem *addBarButtonItem;

@property(nonatomic, strong) NSArray *taskIds;

@end

@implementation ILDTaskListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self taskIds];
    
    [self.view addSubview:self.taskListTableView];
    self.navigationItem.leftBarButtonItem = self.closeBarButtonItem;
    self.navigationItem.rightBarButtonItem = self.addBarButtonItem;
    self.navigationItem.title = @"任务一览";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateDataAndTableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.taskListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.taskIds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ILDTaskListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ILDTaskListCell"];
    if (!cell) {
        cell = [[ILDTaskListCell alloc] init];
    }
    
    NSString *taskId = self.taskIds[indexPath.row];
    ILDTaskModel *taskConfiguration = [[ILDTaskDataCenter sharedInstance] taskConfigurationById:taskId];
    
    [cell ConfigureCellWithImage:[taskConfiguration il_taskImage]
                            Text:[taskConfiguration il_taskName]
                      DetailText:[taskConfiguration il_taskDetail]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ILDTaskConfigurationViewController *configurationVC = [[ILDTaskConfigurationViewController alloc] init];
    configurationVC.configurationType = TaskConfigurationTypeModify;
    configurationVC.taskId = self.taskIds[indexPath.row];
    
    [self.navigationController pushViewController:configurationVC animated:YES];
}

#pragma mark - Event

- (void)clickAddButton:(id)sender {
    ILDTaskConfigurationViewController *taskConfigurationVC = [[ILDTaskConfigurationViewController alloc] init];
    taskConfigurationVC.configurationType = TaskConfigurationTypeAdd;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:taskConfigurationVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Method

- (void)updateDataAndTableView {
    self.taskIds = [[ILDTaskDataCenter sharedInstance] taskIds];
    
    [self.taskListTableView reloadData];
}

#pragma mark - Getter and Setter

- (UITableView *)taskListTableView {
    if (!_taskListTableView) {
        _taskListTableView = [[UITableView alloc] init];
        _taskListTableView.delegate = self;
        _taskListTableView.dataSource = self;
        _taskListTableView.tableFooterView = [[UIView alloc] init];
        _taskListTableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _taskListTableView.tableHeaderView = [[ILDLogoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 225)];
        [_taskListTableView setBackgroundColor:ClearColor];
    }
    
    return _taskListTableView;
}

- (NSArray *)taskIds {
    if (!_taskIds) {
        _taskIds = [[ILDTaskDataCenter sharedInstance] taskIds];
    }
    
    return _taskIds;
}

- (UIBarButtonItem *)closeBarButtonItem {
    if (!_closeBarButtonItem) {
        _closeBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_close_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton:)];
    }
    
    return _closeBarButtonItem;
}

- (UIBarButtonItem *)addBarButtonItem {
    if (!_addBarButtonItem) {
        _addBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(clickAddButton:)];
    }
    
    return _addBarButtonItem;
}

@end
