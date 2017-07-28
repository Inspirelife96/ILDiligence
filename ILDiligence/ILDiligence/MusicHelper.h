//
//  MusicHelper.h
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/2/21.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicHelper : NSObject

+ (NSURL *)musicUrlByName:(NSString *)musicName;
+ (NSArray *)musicNameList;

@end
