//
//  ILDBarChartDataValueFormatter.m
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//


#import "ILDBarChartDataValueFormatter.h"

@interface ILDBarChartDataValueFormatter ()
{
    NSDateFormatter *_dateFormatter;
}
@end

@implementation ILDBarChartDataValueFormatter

- (id)init
{
    self = [super init];
    if (self)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"MM-dd";
    }
    return self;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-(value * 3600 * 24)];
    return [_dateFormatter stringFromDate:date];
}

@end
