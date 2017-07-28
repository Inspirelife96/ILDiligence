//
//  ILDColorPickerViewController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/2/9.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "ILDColorPickerViewController.h"
#import "ILDColorPickerCell.h"

@interface ILDColorPickerViewController ()

@property (nonatomic, strong) NSArray *colorNameArray;

@end

#pragma mark - Life Cycle

@implementation ILDColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSInteger selectedIndex = [self.colorNameArray indexOfObject:self.taskConfiguration.color];
    [self.pickerView selectRow:selectedIndex inComponent:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.colorNameArray count];
}

#pragma Mark -- UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width - 24;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.colorNameArray[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
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
    
    ILDColorPickerCell* pickerCell = (ILDColorPickerCell *)view;
    if (!pickerCell){
        pickerCell = [[ILDColorPickerCell alloc] init];
    }

    pickerCell.colorName = self.colorNameArray[row];
    pickerCell.color = [ILDColorHelper colorByName:self.colorNameArray[row]];
    return pickerCell;
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    NSInteger selectedIndex = [self.pickerView selectedRowInComponent:0];
    self.taskConfiguration.color = self.colorNameArray[selectedIndex];
    
    [super clickCloseButton:sender];
}

#pragma mark - Getter and Setter

- (NSArray *)colorNameArray {
    if (!_colorNameArray) {
        _colorNameArray = [ILDColorHelper colorNameList];
    }
    
    return _colorNameArray;
}

@end
