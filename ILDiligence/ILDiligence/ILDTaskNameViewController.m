//
//  ILDTaskNameViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDTaskNameViewController.h"

@interface ILDTaskNameViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *taskNameTextField;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation ILDTaskNameViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.taskNameTextField];
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.lineView];
    
    [self.taskNameTextField becomeFirstResponder];
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-self.view.frame.size.height/4);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(21);
    }];
    
    [self.taskNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.descriptionLabel.mas_bottom).with.offset(44);
        make.width.mas_equalTo(self.view.frame.size.width - 24);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.taskNameTextField.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.frame.size.width - 24);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-21);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Event

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

- (void)clickCloseButton:(id)sender {
    self.taskConfiguration.name = _taskNameTextField.text;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter and Setter

- (UITextField *)taskNameTextField {
    if (!_taskNameTextField) {
        _taskNameTextField = [[UITextField alloc] init];
        _taskNameTextField.delegate = self;
        _taskNameTextField.placeholder = @"请输入任务名字";
        _taskNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _taskNameTextField.textAlignment = NSTextAlignmentCenter;
        _taskNameTextField.font = [UIFont fontWithName:@"Avenir Next" size:16];
        _taskNameTextField.textColor = FlatWhite;
        _taskNameTextField.text = self.taskConfiguration.name;
        _taskNameTextField.returnKeyType = UIReturnKeyDone;
        [_taskNameTextField setValue:FlatGray forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    return _taskNameTextField;
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
        _descriptionLabel.text = @"任务名字，请尽量简短";
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.textColor = FlatWhiteDark;
        _descriptionLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
    }
    
    return _descriptionLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = FlatWhiteDark;
        _lineView.alpha = 0.5;
    }
    
    return _lineView;
}

@end
