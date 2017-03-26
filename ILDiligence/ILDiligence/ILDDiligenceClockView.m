//
//  ILDDiligenceClockView.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/25.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDDiligenceClockView.h"
#import "ILDRestSuggestion.h"

#define RADIUS 80
#define POINT_RADIUS 8
#define CIRCLE_WIDTH 4
#define PROGRESS_WIDTH 6
#define TEXT_NAME_SIZE 48
#define TEXT_DATE_SIZE 16
#define TIMER_INTERVAL 0.05

@interface ILDDiligenceClockView ()

@property(nonatomic, assign) BOOL isRunning;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) CGFloat timeLeft;
@property(nonatomic, assign) CGFloat startAngle;
@property(nonatomic, assign) CGFloat endAngle;
@property(nonatomic, strong) PulsingHaloLayer *halo;

@end

@implementation ILDDiligenceClockView

- (id)init {
    if (self = [super init]) {
        [self initData];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)initData {
    self.startAngle = -0.5 * M_PI;
    self.endAngle = self.startAngle;
    self.diligenceSeconds = 0;
    self.timeLeft = 0;    
    self.isRunning = NO;
}

- (void)drawRect:(CGRect)rect {
    // calculate angle for progress
    if (self.diligenceSeconds == 0) {
        self.endAngle = self.startAngle;
    } else {
        self.endAngle = (1 - self.timeLeft / self.diligenceSeconds) * 2 * M_PI + self.startAngle;
    }
    
    CGFloat radius = (rect.size.width - 20)/2;
    
    // draw circle
    UIBezierPath *circle = [UIBezierPath bezierPath];
    [circle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                      radius:radius
                  startAngle:0
                    endAngle:2 * M_PI
                   clockwise:YES];
    circle.lineWidth = CIRCLE_WIDTH;
    [FlatWhiteDark setStroke];
    [circle stroke];
    
    // draw progress
    UIBezierPath *progress = [UIBezierPath bezierPath];
    [progress addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                        radius:radius
                    startAngle:self.startAngle
                      endAngle:self.endAngle
                     clockwise:YES];
    progress.lineWidth = PROGRESS_WIDTH;
    [FlatWhite setStroke];
    [progress stroke];
    
    if (self.isRunning) {
        // if Timer is running, always show time left in the center of the circle
        NSString *textContent = [ILDDateHelper minutesFormatBySeconds:self.timeLeft];
        
        UIFont *textFont = [UIFont fontWithName: @"-" size: TEXT_NAME_SIZE];
        CGSize textSize = [textContent sizeWithAttributes:@{NSFontAttributeName:textFont}];
        CGRect textRect = CGRectMake(rect.size.width / 2 - textSize.width / 2,
                                     rect.size.height / 2 - textSize.height / 2,
                                     textSize.width , textSize.height);
        
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle.alignment = NSTextAlignmentCenter;
        
        [textContent drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont, NSForegroundColorAttributeName:FlatWhite, NSParagraphStyleAttributeName:textStyle}];
    } else {
        // show task Name or rest suggestion Name
        NSString *taskOrRestName = self.taskName;
        if (self.isRestMode) {
            taskOrRestName = [ILDRestSuggestion randomRestSuggestion];
        }
        
        NSInteger fontSize = TEXT_NAME_SIZE;
        
        UIFont *taskNameFont = [UIFont fontWithName: @"-" size: fontSize];
        CGSize taskNameSize = [taskOrRestName sizeWithAttributes:@{NSFontAttributeName:taskNameFont}];
        
        while (taskNameSize.width > (self.frame.size.width - 20)) {
            fontSize -= 2;
            taskNameFont = [UIFont fontWithName: @"-" size: fontSize];
            taskNameSize = [taskOrRestName sizeWithAttributes:@{NSFontAttributeName:taskNameFont}];
        }
        
        CGFloat taskNameX = 10;
        CGFloat taskNameY = (rect.size.height - taskNameSize.height)/2 - 10;
        CGFloat taskNameWidth = self.frame.size.width - 20;
        CGFloat taskNameHeight = taskNameSize.height;
        
        CGRect taskNameRect = CGRectMake(taskNameX, taskNameY, taskNameWidth, taskNameHeight);
        
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle.alignment = NSTextAlignmentCenter;
        
        [taskOrRestName drawInRect:taskNameRect withAttributes:@{NSFontAttributeName:taskNameFont, NSForegroundColorAttributeName:FlatWhite, NSParagraphStyleAttributeName:textStyle}];
        
        NSString *dateToday = [ILDDateHelper stringOfDayWithWeekDay:[NSDate date]];
        UIFont *dateFont = [UIFont fontWithName: @"-" size: TEXT_DATE_SIZE];
        CGSize dateSize = [dateToday sizeWithAttributes:@{NSFontAttributeName:dateFont}];
        
        CGFloat dateX = (rect.size.width - dateSize.width)/2;
        CGFloat dateY = taskNameY + taskNameHeight + 5;
        CGFloat dateWidth = dateSize.width;
        CGFloat dateHeight = dateSize.height;
        
        CGRect dateRect = CGRectMake(dateX, dateY, dateWidth, dateHeight);
        
        [dateToday drawInRect:dateRect withAttributes:@{NSFontAttributeName:dateFont, NSForegroundColorAttributeName:FlatWhite, NSParagraphStyleAttributeName:textStyle}];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [FlatWhite setStroke];
        CGContextMoveToPoint(context, dateX, dateY - 2);
        CGContextAddLineToPoint(context, dateX + dateWidth, dateY - 2);
        CGContextMoveToPoint(context, dateX, dateY + dateHeight + 2);
        CGContextAddLineToPoint(context, dateX + dateWidth, dateY + dateHeight + 2);
        CGContextStrokePath(context);
    }
}

- (void)startTimer {
    if (!self.isRunning) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        [self.superview.layer insertSublayer:self.halo below:self.layer];
        [self.halo start];
        self.isRunning = YES;
    }
}

- (void)pauseTimer {
    if (self.isRunning) {
        [self.timer setFireDate:[NSDate distantFuture]];
        [self.halo removeFromSuperlayer];
        self.isRunning = NO;
    }
}

- (void)resumeTimer {
    if (!self.isRunning) {
        [self.timer setFireDate:[NSDate distantPast]];
        [self.superview.layer insertSublayer:self.halo below:self.layer];
        [self.halo start];
        self.isRunning = YES;
    }
}

- (void)stopTimer {
    [self.timer invalidate];
    self.startAngle = -0.5 * M_PI;
    self.endAngle = self.startAngle;
    self.timeLeft = self.diligenceSeconds;
    [self.halo removeFromSuperlayer];
    self.isRunning = NO;
    [self setNeedsDisplay];
}

- (void)updateProgress {
    if (self.timeLeft > 0) {
        self.timeLeft -= TIMER_INTERVAL;
        [self setNeedsDisplay];
    } else {
        [self stopTimer];
        
        if (self.delegate) {
            [self.delegate taskCompleted];
        }
    }
}

#pragma mark - Getter and Setter

- (PulsingHaloLayer *)halo {
    if (!_halo) {
        _halo = [PulsingHaloLayer layer];
        _halo.haloLayerNumber   = 3;
        _halo.backgroundColor = FlatWhiteDark.CGColor;
        _halo.radius            = 160;
        _halo.animationDuration = 5;
        _halo.position = self.center;
    }
    
    return _halo;
}

- (void)setIsRestMode:(BOOL)isRestMode {
    _isRestMode = isRestMode;
    [self setNeedsDisplay];
}

- (void)setDiligenceSeconds:(NSInteger)diligenceSeconds {
    _diligenceSeconds = diligenceSeconds;
    _timeLeft = diligenceSeconds;
}

@end
