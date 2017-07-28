//
//  ILDAlertViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/2/10.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "ILDAlertViewController.h"
#import "ILDTaskConfigurationDefaultCell.h"
#import "ILDTaskConfigurationSwitchCell.h"
#import "ILDAlertTimeViewController.h"

@interface ILDAlertViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;

@end

#pragma mark - Life Cycle

@implementation ILDAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"专注提醒";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updataDataAndTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        switchCell.textLabel.text = @"专注提醒";
        switchCell.detailTextLabel.text = @"在你设定的时间提醒你进行专注";
        [switchCell.configurationSwitch setOn:self.taskConfiguration.isAlertEnabled];
        [switchCell.configurationSwitch addTarget:self action:@selector(changeAlertMode:) forControlEvents:UIControlEventValueChanged];
        return switchCell;
    } else {
        defaultCell.textLabel.text = @"提醒时间";
        defaultCell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@", self.hour, self.minute];
        return defaultCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
    } else  {
        ILDAlertTimeViewController *alertTimeVC = [[ILDAlertTimeViewController alloc] init];
        alertTimeVC.taskConfiguration = self.taskConfiguration;
        [self presentViewController:alertTimeVC animated:YES completion:nil];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(12, 2, self.view.frame.size.width - 24, 44)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 22, self.view.frame.size.width - 24, 21)];
    headerLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    headerLabel.text = @"专注提醒";
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

- (void)changeAlertMode:(id)sender {
    self.taskConfiguration.isAlertEnabled = [(UISwitch *)sender isOn];    
}

- (void)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Method

- (void)updataDataAndTableView {
    NSDate *date = self.taskConfiguration.alertTime;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    _hour = [NSString stringWithFormat:@"%02ld", (long)[components hour]];
    _minute = [NSString stringWithFormat:@"%02ld", (long)[components minute]];
    
    [self.templateTableView reloadData];
}

- (void)setTaskConfiguration:(ILDTaskModel *)taskConfiguration {
    _taskConfiguration = taskConfiguration;
    
    NSDate *date = _taskConfiguration.alertTime;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    _hour = [NSString stringWithFormat:@"%02ld", (long)[components hour]];
    _minute = [NSString stringWithFormat:@"%02ld", (long)[components minute]];
}

@end
