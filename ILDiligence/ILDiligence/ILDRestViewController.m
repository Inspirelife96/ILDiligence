//
//  ILDRestViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/2/12.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "ILDRestViewController.h"
#import "ILDTaskConfigurationDefaultCell.h"
#import "ILDTaskConfigurationSwitchCell.h"
#import "ILDRestTimeViewController.h"

@interface ILDRestViewController()

@end

@implementation ILDRestViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"休息";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updataDataAndTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ILDTaskConfigurationDefaultCell *defaultCell = [[ILDTaskConfigurationDefaultCell alloc] init];
    ILDTaskConfigurationSwitchCell *switchCell = [[ILDTaskConfigurationSwitchCell alloc] init];

    if (indexPath.row == 0) {
        switchCell.textLabel.text = @"休息模式";
        switchCell.detailTextLabel.text = @"每次专注完成后，会进行一次休息计时";
        [switchCell.configurationSwitch addTarget:self action:@selector(changeRestMode:) forControlEvents:UIControlEventValueChanged];
        [switchCell.configurationSwitch setOn:self.taskConfiguration.isRestModeEnabled];
        return switchCell;
    } else {
        defaultCell.textLabel.text = @"休息时长";
        defaultCell.detailTextLabel.text = [NSString stringWithFormat:@"%@分钟", self.taskConfiguration.restTime];
        return defaultCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //
    } else {
        ILDRestTimeViewController *restTimeVC = [[ILDRestTimeViewController alloc] init];
        restTimeVC.taskConfiguration = self.taskConfiguration;
        [self presentViewController:restTimeVC animated:YES completion:nil];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(12, 2, self.view.frame.size.width - 24, 44)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 22, self.view.frame.size.width - 24, 21)];
    headerLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    headerLabel.text = @"休息设置";

    headerLabel.textColor = FlatGray;

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(12, 43.5, self.view.frame.size.width - 24, 0.5)];
    lineView.backgroundColor = FlatWhiteDark;

    [headerView addSubview:lineView];
    [headerView addSubview:headerLabel];

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - Event

- (void)changeRestMode:(id)sender {
    self.taskConfiguration.isRestModeEnabled = [(UISwitch *)sender isOn];
}

#pragma mark - Private Method

- (void)updataDataAndTableView {
    [self.templateTableView reloadData];
}

@end
