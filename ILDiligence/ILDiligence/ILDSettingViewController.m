//
//  ILDSettingViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/25.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDSettingViewController.h"
#import "ILDLogoView.h"
#import "ILDSettingDefaultCell.h"
#import "UIViewController+SendEmailInApp.h"
#import "ILDAboutViewController.h"

@interface ILDSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *settingListTableView;
@property(nonatomic, strong) UIBarButtonItem *closeBarButtonItem;
@property(nonatomic, strong) UILabel *signLabel;

@end

#pragma mark - Life Cycle

@implementation ILDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.settingListTableView];
    [self.view addSubview:self.signLabel];
    self.navigationItem.leftBarButtonItem = self.closeBarButtonItem;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.settingListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-21);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(21);
    }];
}

#pragma mark - tableview datasoure and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ILDSettingDefaultCell *defaultCell = [[ILDSettingDefaultCell alloc] init];
    
    if (indexPath.row == 0) {
        defaultCell.textLabel.text = @"意见与反馈";
        defaultCell.imageView.image = [UIImage imageNamed:@"menu_feedback_26x26_"];
        return defaultCell;
    } else if (indexPath.row == 1) {
        defaultCell.textLabel.text = @"给我打分";
        defaultCell.imageView.image = [UIImage imageNamed:@"menu_rate_26x26_"];
        return defaultCell;
    } else {
        defaultCell.textLabel.text = @"关于";
        defaultCell.imageView.image = [UIImage imageNamed:@"menu_about_26x26_"];
        return defaultCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *subject = @"勤之时 用户反馈";
        NSArray *recipientArray = [NSArray arrayWithObject: @"inspirelife@hotmail.com"];
        NSString *body = @"";
        
        NSDictionary *emaidContentDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                          subject, @"subject",
                                          recipientArray, @"recipients",
                                          body, @"body",
                                          nil];
        
        [self sendMailInApp:emaidContentDict];
    } else if (indexPath.row == 1){
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppReviewURL] options:@{} completionHandler:^(BOOL success) {
            }];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppReviewURL]];
        }
    } else {
        ILDAboutViewController *aboutVC = [[ILDAboutViewController alloc] init];
        [self presentViewController:aboutVC animated:YES completion:nil];
    }
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter and Setter

- (UITableView *)settingListTableView {
    if (!_settingListTableView) {
        _settingListTableView = [[UITableView alloc] init];;
        _settingListTableView.delegate = self;
        _settingListTableView.dataSource = self;
        _settingListTableView.tableFooterView = [[UIView alloc] init];
        _settingListTableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        _settingListTableView.tableHeaderView = [[ILDLogoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ScreenHeight - 128 - 4 * 44)];
        [_settingListTableView setBackgroundColor:ClearColor];
    }
    
    return _settingListTableView;
}

- (UIBarButtonItem *)closeBarButtonItem {
    if (!_closeBarButtonItem) {
        _closeBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_close_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton:)];
    }
    
    return _closeBarButtonItem;
}

- (UILabel *)signLabel {
    if(!_signLabel) {
        _signLabel = [[UILabel alloc] init];
        _signLabel.textAlignment = NSTextAlignmentCenter;
        _signLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
        _signLabel.textColor = FlatWhiteDark;
        _signLabel.text = @"启发光明 出品";
        _signLabel.alpha = 0.75;
    }
    
    return _signLabel;
}

@end
