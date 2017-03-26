//
//  ILDNetwork.m
//  ILDNetworkLayer
//
//  Created by XueFeng Chen on 2017/3/19.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDNetwork.h"
#import "ILDNetworkConstants.h"
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

@interface ILDNetwork()

@property (nonatomic, strong) dispatch_group_t requestGroup;

@property (nonatomic, strong) NSString *storyTitle;
@property (nonatomic, strong) NSString *storyAttribute;
@property (nonatomic, strong) NSString *storyPara1;
@property (nonatomic, strong) UIImage *storyImage;
@property (nonatomic, strong) NSError *error;

@end


@implementation ILDNetwork

- (void)downloadStoryData {
    [self downloadImageData];
    [self downloadOtherData];
    
    dispatch_group_notify(self.requestGroup, dispatch_get_main_queue(), ^{
        if (self.error) {
            [self.delegate fetchStoryDataFail:self.error];
        } else {
            NSDictionary *storyDataDictionary = @{
                                                  kBingStoryURLDate:[NSDate date],
                                                  kBingStoryURLTitle:self.storyTitle,
                                                  kBingStoryURLAttribute:self.storyAttribute,
                                                  kBingStoryURLPara1:self.storyPara1,
                                                  kBingImageURLImageData:UIImageJPEGRepresentation(self.storyImage, 0.5)
                                                  };
            [self.delegate fetchStoryDataSuccess:storyDataDictionary];
        }
    });
}

- (void)downloadImageData {
    dispatch_group_enter(self.requestGroup);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:kBingImageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            self.error = error;
        } else {
            NSDictionary *responseDict = (NSDictionary *)responseObject[kBingImageURLImages][0];
            NSString *imageURLString = [NSString stringWithFormat:kBingImageFullPathFormat, responseDict[kBingImageURLUrlBase], kImageTypes];
            [self downloadImageData:imageURLString];
        }
        dispatch_group_leave(self.requestGroup);
    }];
    
    [dataTask resume];
}

- (void)downloadImageData:(NSString *)imageUrlString {
    dispatch_group_enter(self.requestGroup);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    NSURL *URL = [NSURL URLWithString:imageUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            self.error = error;
        } else {
            self.storyImage = responseObject;
        }
        dispatch_group_leave(self.requestGroup);
    }];
    
    [dataTask resume];
}

- (void)downloadOtherData {
    dispatch_group_enter(self.requestGroup);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:kBingStoryURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            self.error = error;
        } else {
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            self.storyTitle = responseDict[kBingStoryURLTitle];
            self.storyAttribute = responseDict[kBingStoryURLAttribute];
            self.storyPara1 = responseDict[kBingStoryURLPara1];
        }
        dispatch_group_leave(self.requestGroup);
    }];
    
    [dataTask resume];
}

- (dispatch_group_t)requestGroup {
    if (!_requestGroup) {
        _requestGroup = dispatch_group_create();
    }
    
    return _requestGroup;
}

@end
