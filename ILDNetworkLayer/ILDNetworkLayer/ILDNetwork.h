//
//  ILDNetwork.h
//  ILDNetworkLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILDNetworkDelegate <NSObject>

- (void)fetchStoryDataSuccess:(NSDictionary *)storyDataDictionary;
- (void)fetchStoryDataFail:(NSError * _Nonnull)error;

@end

@interface ILDNetwork : NSObject

@property (nonatomic,weak) id<ILDNetworkDelegate> delegate;

- (void)downloadStoryData;

@end
