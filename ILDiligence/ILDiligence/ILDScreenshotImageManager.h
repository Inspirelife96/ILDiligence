//
//  ILDScreenshotImageManager.h
//  ILDiligence
//
//  Created by Chen XueFeng on 2017/2/1.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ILDScreenshotImageManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) UIImage *screenshotImage;

@end
