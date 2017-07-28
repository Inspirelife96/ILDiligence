//
//  ILDTaskConfigurationViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskConfigurationViewController.h"
#import "ILDTaskConfigurationDefaultCell.h"
#import "ILDTaskConfigurationSwitchCell.h"
#import "ILDTaskNameViewController.h"
#import "ILDColorPickerViewController.h"
#import "ILDDiligenceTimeViewController.h"
#import "ILDRestViewController.h"
#import "ILDMusicViewController.h"
#import "ILDAlertViewController.h"

@interface ILDTaskConfigurationViewController ()

@property (strong, nonatomic) ILDTaskModel *taskConfiguration;
@property (strong, nonatomic) UIBarButtonItem *rightBarButtonItem;

@end

@implementation ILDTaskConfigurationViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"任务设置";
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    
    if (self.configurationType == TaskConfigurationTypeAdd) {
        [self.backBarButtonItem setImage:[UIImage imageNamed:@"global_close_icon_28x28_"]];
        self.navigationItem.title = @"添加任务";
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updataDataAndTableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 3;
    } else if (section == 2){
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ILDTaskConfigurationDefaultCell *defaultCell = [[ILDTaskConfigurationDefaultCell alloc] init];
    ILDTaskConfigurationSwitchCell *switchCell = [[ILDTaskConfigurationSwitchCell alloc] init];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            defaultCell.textLabel.text = @"任务名字";
            defaultCell.detailTextLabel.text = self.taskConfiguration.name;
        } else {
            defaultCell.textLabel.text = @"任务配色";
            defaultCell.detailTextLabel.text = self.taskConfiguration.color;
        }
        
        return defaultCell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSNumber *diligenceTime = self.taskConfiguration.diligenceTime;
            defaultCell.textLabel.text = @"专注时长";
            defaultCell.detailTextLabel.text = [NSString stringWithFormat:@"%ld分钟", (long)[diligenceTime integerValue]];
            return defaultCell;
        } else if (indexPath.row == 1) {
            defaultCell.textLabel.text = @"休息";
            return defaultCell;
        } else {
            switchCell.textLabel.text = @"沉浸模式";
            switchCell.detailTextLabel.text = @"退出应用会导致专注失败且不允许暂停";
            [switchCell.configurationSwitch addTarget:self action:@selector(changeFocusMode:) forControlEvents:UIControlEventValueChanged];
            [switchCell.configurationSwitch setOn:self.taskConfiguration.isFocusModeEnabled];
            return switchCell;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            defaultCell.textLabel.text = @"背景音乐";
            defaultCell.detailTextLabel.text = self.taskConfiguration.musicName;
            return defaultCell;
        } else {
            switchCell.textLabel.text = @"白噪音";
            [switchCell.configurationSwitch addTarget:self action:@selector(changeMusicEnabled:) forControlEvents:UIControlEventValueChanged];
            [switchCell.configurationSwitch setOn:self.taskConfiguration.isMusicEnabled];
            return switchCell;
        }
    } else {
        defaultCell.textLabel.text = @"专注提醒";
        return defaultCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ILDTaskNameViewController *taskNameVC = [[ILDTaskNameViewController alloc] init];
            taskNameVC.taskConfiguration = self.taskConfiguration;
            [self presentViewController:taskNameVC animated:YES completion:nil];
        } else {
            ILDColorPickerViewController *colorPickerVC = [[ILDColorPickerViewController alloc] init];
            colorPickerVC.taskConfiguration = self.taskConfiguration;
            [self presentViewController:colorPickerVC animated:YES completion:nil];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ILDDiligenceTimeViewController *diligenceTimeVC = [[ILDDiligenceTimeViewController alloc] init];
            diligenceTimeVC.taskConfiguration = self.taskConfiguration;
            [self presentViewController:diligenceTimeVC animated:YES completion:nil];
        } else if (indexPath.row == 1) {
            ILDRestViewController *restVC = [[ILDRestViewController alloc] init];
            restVC.taskConfiguration = self.taskConfiguration;
            [self.navigationController pushViewController:restVC animated:YES];
        } else {
            // do nothing
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ILDMusicViewController *musicConfigurationVC = [[ILDMusicViewController alloc] init];
            musicConfigurationVC.taskConfiguration = self.taskConfiguration;
            [self presentViewController:musicConfigurationVC animated:YES completion:nil];
        } else {
            // do nothing
        }
    } else {
        ILDAlertViewController *tomatoAlertVC = [[ILDAlertViewController alloc] init];
        tomatoAlertVC.taskConfiguration = self.taskConfiguration;
        [self.navigationController pushViewController:tomatoAlertVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(12, 2, self.view.frame.size.width - 24, 44)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 22, self.view.frame.size.width - 24, 21)];
    headerLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    if (section == 0) {
        headerLabel.text = @"任务设置";
    } else if (section == 1) {
        headerLabel.text = @"专注设置";
    } else if (section == 2) {
        headerLabel.text = @"白噪音设置";
    } else {
        headerLabel.text = @"高级设置";
    }
    
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

- (void)changeFocusMode:(id)sender {
    self.taskConfiguration.isFocusModeEnabled = [(UISwitch *)sender isOn];
}

- (void)changeMusicEnabled:(id)sender {
    self.taskConfiguration.isMusicEnabled = [(UISwitch *)sender isOn];
}

- (void)clickBackBarButtonItem:(id)sender {
    if (self.configurationType == TaskConfigurationTypeModify) {
        if ([self.taskConfiguration.name isEqualToString:@""]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"警告" message:@"任务名称不能为空，请设置" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //
            }];
            
            [alertVC addAction:cancelAction];
            
            [self presentViewController:alertVC animated:YES completion:nil];
        } else {
            [[ILDTaskDataCenter sharedInstance] updateTask:self.taskId taskConfiguration:self.taskConfiguration];
            [super clickBackBarButtonItem:sender];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)clickRightButtonItem:(id)sender {
    if (self.configurationType == TaskConfigurationTypeAdd) {
        [[ILDTaskDataCenter sharedInstance] addTask:self.taskConfiguration];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        if ( [[[ILDTaskDataCenter sharedInstance] taskIds] count] <= 1) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"通知" message:@"这是最后一个任务，无法被删除" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //
            }];
            
            [alertVC addAction:cancelAction];
            
            [self presentViewController:alertVC animated:YES completion:nil];
        } else {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"警告" message:@"该操作会删除当前任务以及所有的和任务相关的统计记录，确认删除吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [[ILDTaskDataCenter sharedInstance] removeTask:self.taskId];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //
            }];
            
            [alertVC addAction:cancelAction];
            [alertVC addAction:okAction];
            
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }
}

#pragma mark - Private Method

- (void)updataDataAndTableView {
    [self.templateTableView reloadData];
    
    if (self.configurationType == TaskConfigurationTypeAdd) {
        if ([self.taskConfiguration.name isEqualToString:@""]) {
            [self.rightBarButtonItem setEnabled:NO];
        }
        else {
            [self.rightBarButtonItem setEnabled:YES];
        }
    }
}

#pragma mark - Getter and Setter

- (ILDTaskModel *)taskConfiguration {
    if (!_taskConfiguration) {
        if (self.taskId == nil) {
            _taskConfiguration = [[ILDTaskModel alloc] init];
        } else {
            _taskConfiguration = [[ILDTaskDataCenter sharedInstance] taskConfigurationById:self.taskId];
        }
    }
    
    return _taskConfiguration;
}

- (UIBarButtonItem *)rightBarButtonItem {
    if (!_rightBarButtonItem) {
        if (self.configurationType == TaskConfigurationTypeAdd) {
            _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButtonItem:)];
        } else {
            _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButtonItem:)];
            _rightBarButtonItem.tintColor = FlatRed;
        }
    }
    
    return _rightBarButtonItem;
}

@end
