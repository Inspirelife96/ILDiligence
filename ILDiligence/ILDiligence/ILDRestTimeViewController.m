//
//  ILDRestTimeViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/2/12.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "ILDRestTimeViewController.h"

@interface ILDRestTimeViewController ()

@property (nonatomic, strong) NSArray *restTimeArray;
@property (nonatomic, strong) NSArray *timeTypeArray;

@end

@implementation ILDRestTimeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.descriptionLabel.text = @"时长更改将从下次休息时生效";
    
    NSString *selectedTime = [NSString stringWithFormat:@"%@", self.taskConfiguration.restTime];
    NSInteger selectedIndex = [self.restTimeArray indexOfObject:selectedTime];
    [self.pickerView selectRow:selectedIndex inComponent:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Mark -- UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 6;
    } else {
        return 1;
    }
}

#pragma Mark -- UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.restTimeArray[row];
    } else {
        return self.timeTypeArray[row];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            CGFloat y = singleLine.frame.origin.y;
            CGFloat height = singleLine.frame.size.height;
            [singleLine setFrame:CGRectMake(12, y, self.view.frame.size.width - 24, height)];
            singleLine.backgroundColor = FlatWhiteDark;
            singleLine.alpha = 0.3;
        }
    }
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        
        if (component == 0) {
            [pickerLabel setTextColor:FlatWhite];
            [pickerLabel setTextAlignment:NSTextAlignmentRight];
            [pickerLabel setFont: [UIFont fontWithName:@"Avenir Next" size:16]];
        } else {
            [pickerLabel setTextColor:FlatWhiteDark];
            [pickerLabel setTextAlignment:NSTextAlignmentLeft];
            [pickerLabel setFont: [UIFont fontWithName:@"Avenir Next" size:16]];
        }
    }

    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    NSInteger selectedIndex =[self.pickerView selectedRowInComponent:0];
    NSInteger restTime = [self.restTimeArray[selectedIndex] integerValue];
    self.taskConfiguration.restTime = [NSNumber numberWithInteger:restTime];
    
    [super clickCloseButton:sender];
}

#pragma mark - Getter and Setter

- (NSArray *)restTimeArray {
    if (!_restTimeArray) {
        _restTimeArray = [ILDDateHelper restTimeList];
    }
    
    return _restTimeArray;
}

- (NSArray *)timeTypeArray {
    if (!_timeTypeArray) {
        _timeTypeArray = [ILDDateHelper restTimeType];
    }
    
    return _timeTypeArray;
}

@end
