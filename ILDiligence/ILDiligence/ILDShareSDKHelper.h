//
//  ILDShareSDKHelper.h
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILDShareSDKHelper : NSObject

+ (void)initShareSDK;
+ (void)shareMessage:(NSString *)message image:(UIImage *)image onView:(UIView *)view;

@end
