//
//  ILDStoryViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/25.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStoryViewController.h"
#import "ILDSharedView.h"
#import "UIView+IL_ViewToImage.h"

@interface ILDStoryViewController ()

@property(nonatomic, strong) UIButton *closeButton;
@property(nonatomic, strong) UIButton *sharingButton;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) ILDSharedView *sharedView;

@property(nonatomic, strong) ILDStoryModel *storyModel;

@end

#pragma mark - Life Cycle

@implementation ILDStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.sharedView];
    self.sharedView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:3 animations: ^{
        self.sharedView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finish) {
        [UIView animateWithDuration:3 animations: ^{
            self.sharedView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finish) {
            //
        }];
    }];
    
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.sharingButton];
    [self.view addSubview:self.titleLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.sharedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(12);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [self.sharingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-12);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(28);
    }];
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickSharingButton:(id)sender {
    UIImage *sharedImage = [self.sharedView il_viewToImage];
    [ILDShareSDKHelper shareMessage:self.storyModel.todaysTitle image:sharedImage onView:self.sharingButton];
}

#pragma mark - Getter and Setter

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"global_close_icon_28x28_"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (UIButton *)sharingButton {
    if (!_sharingButton) {
        _sharingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sharingButton setBackgroundImage:[UIImage imageNamed:@"menu_share_26x26_"] forState:UIControlStateNormal];
        [_sharingButton addTarget:self action:@selector(clickSharingButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sharingButton;
}

- (ILDSharedView *)sharedView {
    if (!_sharedView) {
        NSString *storyTitle = [NSString stringWithFormat:@"%@ · %@", self.storyModel.todaysTitle  , self.storyModel.todaysAttribute];
        UIImage *storyImage = [UIImage imageWithData:self.storyModel.imageData];
        _sharedView = [[ILDSharedView alloc] initWithStoryImage:storyImage storyTitle:storyTitle storyDetail:self.storyModel.todaysPara1];
    }
    
    return _sharedView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = FlatWhite;
        _titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
        _titleLabel.text = @"今日故事";
    }
    
    return _titleLabel;
}

- (ILDStoryModel *)storyModel {
    if (!_storyModel) {
        _storyModel = [[ILDStoryDataCenter sharedInstance] prepareStoryModel];
    }
    
    return _storyModel;
}

@end
