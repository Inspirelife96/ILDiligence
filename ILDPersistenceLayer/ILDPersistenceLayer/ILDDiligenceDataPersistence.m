//
//  ILDDiligenceDataPersistence.m
//  ILDPersistenceLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDDiligenceDataPersistence.h"
#import "ILDPersistenceFilePathHelper.h"

NSString *const kDiligenceDataPersistanceFile = @"diligenceData.plist";

@implementation ILDDiligenceDataPersistence

+ (NSDictionary *)readDiligenceData {
    NSString *diligenceDataFilePath = [ILDPersistenceFilePathHelper persistenceFilePath:kDiligenceDataPersistanceFile];
    NSDictionary *diligenceDataDictionary = [NSDictionary dictionaryWithContentsOfFile:diligenceDataFilePath];
    if (!diligenceDataDictionary) {
        diligenceDataDictionary = [[NSMutableDictionary alloc] init];
        [ILDDiligenceDataPersistence saveDiligenceData:diligenceDataDictionary];
    }
    
    return diligenceDataDictionary;
}

+ (void)saveDiligenceData:(NSDictionary *)diligenceDataDictionary {
    NSString *diligenceDataFilePath = [ILDPersistenceFilePathHelper persistenceFilePath:kDiligenceDataPersistanceFile];
    [diligenceDataDictionary writeToFile:diligenceDataFilePath atomically:YES];
}

@end
