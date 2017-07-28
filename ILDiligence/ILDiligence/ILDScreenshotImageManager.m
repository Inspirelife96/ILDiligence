//
//  ILDScreenshotImageManager.m
//  ILDiligence
//
//  Created by Chen XueFeng on 2017/2/1.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "ILDScreenshotImageManager.h"
#import "UIImageEffects.h"

@implementation ILDScreenshotImageManager

@synthesize screenshotImage = _screenshotImage;

static ILDScreenshotImageManager *screenshotImageManager = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        screenshotImageManager = [[super allocWithZone:NULL] init];
    });
    
    return screenshotImageManager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [ILDScreenshotImageManager sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [ILDScreenshotImageManager sharedInstance] ;
}

- (ILDScreenshotImageManager *)init {
    self = [super init];
    
    if (self) {
        _screenshotImage = [UIImageEffects imageByApplyingDarkEffectToImage:[UIImage imageNamed:@"default_background_1080x1920"]];
    }
    
    return self;
}

- (UIImage *)screenshotImage {
    return _screenshotImage;
}

- (void)setScreenshotImage:(UIImage *)screenshotImage {
    _screenshotImage = [UIImageEffects imageByApplyingDarkEffectToImage:screenshotImage];
}

@end
