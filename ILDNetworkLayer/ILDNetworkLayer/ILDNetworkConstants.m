//
//  ILDNetworkConstants.m
//  ILDNetworkLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - bing image/story url

NSString *const kBingImageURL = @"http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1";
NSString *const kBingStoryURL = @"http://www.jianshu.com/p/cab88362ced0";
NSString *const kBingImageFullPathFormat = @"http://www.bing.com%@%@";

#pragma mark - story keys need to be fetch from URL

NSString *const kBingStoryURLTitle = @"title";
NSString *const kBingStoryURLAttribute = @"attribute" ;
NSString *const kBingStoryURLPara1 = @"para1";

NSString *const kBingImageURLImages = @"images";
NSString *const kBingImageURLUrlBase = @"urlbase";
NSString *const kBingImageURLImageData = @"imageData";

#pragma mark - Image Type

NSString *const kImageTypes = @"_1080x1920.jpg";
