//
//  ILDPersistenceFilePathHelper.m
//  ILDPersistenceLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDPersistenceFilePathHelper.h"

@implementation ILDPersistenceFilePathHelper

+ (NSString *)persistenceFilePath:(NSString *)persistenceFileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    return [documentPath stringByAppendingPathComponent:persistenceFileName];
}

@end
