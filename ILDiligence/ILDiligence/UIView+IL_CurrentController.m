//
//  UIView+IL_CurrentController.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "UIView+IL_CurrentController.h"

@implementation UIView (IL_CurrentController)

-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = [next nextResponder];
    }
    
    return nil;
}

@end
