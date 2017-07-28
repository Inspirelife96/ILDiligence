//
//  UIImage+IL_ContentWithColor.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/5/14.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "UIImage+IL_ContentWithColor.h"

@implementation UIImage (IL_ContentWithColor)

- (UIImage *)il_imageContentWithColor:(UIColor *)color {
    if (!color) {
        return nil;
    }
    
    UIImage *newImage = nil;
    
    CGRect imageRect = (CGRect){CGPointZero,self.size};
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -(imageRect.size.height));
    
    CGContextClipToMask(context, imageRect, self.CGImage);//选中选区 获取不透明区域路径
    CGContextSetFillColorWithColor(context, color.CGColor);//设置颜色
    CGContextFillRect(context, imageRect);//绘制
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();//提取图片
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
