//
//  UIView+IL_ViewToImage.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/13.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import "UIView+IL_ViewToImage.h"

@implementation UIView (IL_ViewToImage)

- (UIImage *)il_viewToImage {
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef shareContext = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:shareContext];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenImage;
}

@end
