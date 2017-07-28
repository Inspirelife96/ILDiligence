//
//  ILDBaseViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDBaseViewController.h"
#import "ILDScreenshotImageManager.h"

@interface ILDBaseViewController ()

@property(strong, nonatomic) UIImageView *backgroundImageView;

@end

@implementation ILDBaseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundImageView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Getter and Setter

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [ILDScreenshotImageManager sharedInstance].screenshotImage;
    }
    
    return _backgroundImageView;
}

@end
