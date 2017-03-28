//
//  ILDAboutViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDAboutViewController.h"
#import "UILabel+StringFrame.h"

@interface ILDAboutViewController ()

@property(nonatomic, strong) UILabel *storyLabel;
@property(nonatomic, strong) UIButton *payButton;
@property(nonatomic, strong) UILabel *productInfoLabel;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation ILDAboutViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.storyLabel];
    [self.view addSubview:self.productInfoLabel];
    [self.view addSubview:self.payButton];
    [self.view addSubview:self.closeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-21);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
    
    [self.productInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(ScreenHeight - 50 - 20 - 42);
        make.width.mas_equalTo(ScreenWidth - 24);
        make.height.mas_equalTo(42);
    }];
    
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(ScreenHeight - 50 - 20 - 42 - 60);
        make.width.mas_equalTo(ScreenWidth/4);
        make.height.mas_equalTo(40);
    }];
    
    [self.storyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [self.storyLabel boundingRectWithSize:CGSizeMake(ScreenWidth - 16.0f, 0.0f) attributes:[self.storyLabel attributes:6]];
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo((ScreenHeight - size.height - 200)/2 + 20);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
    }];
}

#pragma mark - Event

- (void)clickPayButton:(id)sender {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kPayURL] options:@{} completionHandler:^(BOOL success) {
        }];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kPayURL]];
    }
}

- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter and Setter

- (UILabel *)storyLabel {
    if (!_storyLabel) {
        _storyLabel = [[UILabel alloc] init];
        _storyLabel.numberOfLines = -1;
        _storyLabel.textAlignment = NSTextAlignmentCenter;
        _storyLabel.textColor = FlatWhite;
        _storyLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
        NSString *text = @"我知道，我还不够勤奋\n没有尽情燃烧\n我如火如荼的青春\n在这片肥沃的土地上\n我应该全心全意打拼\n各种各样的感情\n剪裁得当，认认真真\n\n我知道，我应该勤奋\n用劳动为自己壮骨强筋\n我要向着成功\n大踏步前进\n不在乎风吹雨淋\n每一次前进\n都是幸福花开的声音";
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text attributes:[_storyLabel attributes:6]];
        _storyLabel.attributedText = attributedString;
    }
    
    return _storyLabel;
}

- (UILabel *)productInfoLabel {
    if (!_productInfoLabel) {
        _productInfoLabel = [[UILabel alloc] init];
        _productInfoLabel.numberOfLines = -1;
        _productInfoLabel.textAlignment = NSTextAlignmentCenter;
        _productInfoLabel.textColor = FlatWhite;
        _productInfoLabel.text = @"勤之时 1.0\n启发光明 出品";
        _productInfoLabel.alpha = 0.5;
        _productInfoLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
    }
    
    return _productInfoLabel;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton addTarget:self action:@selector(clickPayButton:) forControlEvents:UIControlEventTouchUpInside];
        [_payButton.layer setMasksToBounds:YES];
        [_payButton.layer setCornerRadius:15];
        [_payButton.layer setBorderWidth:2.0f];
        [_payButton.layer setBorderColor:FlatWhiteDark.CGColor];
        [_payButton setTitle:@"赞赏" forState:UIControlStateNormal];
        [_payButton setImage:[UIImage imageNamed:@"menu_heart_24x24_"] forState:UIControlStateNormal];
        [_payButton.titleLabel setFont:[UIFont fontWithName:@"-" size:20]];
        [_payButton setTitleColor:FlatWhiteDark forState:UIControlStateNormal];
    }
    
    return _payButton;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"global_close_icon_28x28_"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

@end
