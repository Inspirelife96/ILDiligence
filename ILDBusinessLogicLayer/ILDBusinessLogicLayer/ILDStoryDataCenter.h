//
//  ILDStoryDataCenter.h
//  ILDBusinessLogicLayer
//
//  Created by XueFeng Chen on 2017/3/22.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ILDStoryModel.h"

@interface ILDStoryDataCenter : NSObject

+ (instancetype)sharedInstance;

- (ILDStoryModel *)prepareStoryModel;

@end
