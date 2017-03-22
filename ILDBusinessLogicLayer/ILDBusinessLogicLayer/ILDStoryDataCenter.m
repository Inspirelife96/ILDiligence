//
//  ILDStoryDataCenter.m
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/22.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDStoryDataCenter.h"
#import "ILDDateHelper.h"
#import "ILDStoryModel.h"
#import <ILDPersistenceLayer/ILDPersistenceLayer.h>
#import <ILDNetworkLayer/ILDNetworkLayer.h>

@interface ILDStoryDataCenter () <ILDNetworkDelegate>

@property (strong, nonatomic) NSDictionary *storyDataDictionary;
@property (strong, nonatomic) ILDNetwork *network;

@end

static ILDStoryDataCenter *sharedInstance = nil;

@implementation ILDStoryDataCenter

#pragma mark - singleton init

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:nil] init];
    });
    
    return sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [ILDStoryDataCenter sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [ILDStoryDataCenter sharedInstance] ;
}

- (instancetype)init {
    if (self = [super init]) {
        NSDate *storyDate = self.storyDataDictionary[kStoryDataDate];
        if (![ILDDateHelper isSameDay:storyDate date2:[NSDate date]]) {
            [self.network downloadStoryData];
        }
    }
    
    return self;
}

#pragma mark - public method

- (ILDStoryModel *)prepareStoryModel {
    ILDStoryModel *storyModel = [[ILDStoryModel alloc] init];
    storyModel.todaysTitle = self.storyDataDictionary[kStoryDataTitle];
    storyModel.todaysAttribute = self.storyDataDictionary[kStoryDataAttribute];
    storyModel.todaysPara1 = self.storyDataDictionary[kStoryDataPara1];
    storyModel.imageData = self.storyDataDictionary[kStoryDataImageData];
    
    return storyModel;
}

#pragma mark - ILDNetworkDelegate

- (void)fetchStoryDataSuccess:(NSDictionary  * _Nonnull)storyDataDictionary {
    self.storyDataDictionary = storyDataDictionary;
    [ILDStoryDataPersistence saveStoryData:self.storyDataDictionary];
}

- (void)fetchStoryDataFail:(NSError * _Nonnull)error {
    //
}

#pragma mark - Getter and Setter

- (NSDictionary *)storyDataDictionary {
    if (!_storyDataDictionary) {
        _storyDataDictionary = [ILDStoryDataPersistence readStoryData];
    }
    
    return _storyDataDictionary;
}

- (ILDNetwork *)network {
    if (!_network) {
        _network = [[ILDNetwork alloc] init];
        _network.delegate = self;
    }
    
    return _network;
}

@end
