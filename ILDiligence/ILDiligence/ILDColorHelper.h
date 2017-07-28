//
//  ILDColorHelper.h
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/2/21.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILDColorHelper : NSObject

+ (UIColor *)colorByName:(NSString *)colorString;
+ (NSArray *)colorNameList;

@end
