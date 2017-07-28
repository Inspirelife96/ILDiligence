//
//  ILDTaskConfigurationPresentModeViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskConfigurationPresentModeViewController.h"

@interface ILDTaskConfigurationPresentModeViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *closeButton;


@end

@implementation ILDTaskConfigurationPresentModeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.closeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-76);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(216);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(self.view.frame.size.height/4);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(21);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-21);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter and Setter

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    
    return _pickerView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"global_close_icon_28x28_"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.textColor = FlatWhiteDark;
        _descriptionLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    return _descriptionLabel;
}

@end
