//
//  ILDShareSDKHelper.m
//  ILDiligence
//
//  Created by XueFeng Chen on 2017/3/28.
//  Copyright © 2017年 XueFeng Chen. All rights reserved.
//

#import "ILDShareSDKHelper.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

#import "UIViewController+Alert.h"
#import "UIView+IL_CurrentController.h"

@implementation ILDShareSDKHelper

+ (void)initShareSDK {
    [ShareSDK registerApp:kShareSDKApplicationId
          activePlatforms:@[
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType)
              {
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:kWXApplicationId
                                            appSecret:kWXApplicationSecret];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:kQQApplicationId
                                           appKey:kQQApplicationSecret
                                         authType:SSDKAuthTypeBoth];
                  default:
                      break;
              }
          }];
}

+ (void)shareMessage:(NSString *)message image:(UIImage *)image onView:(UIView *)view {
    
    UIViewController *currentController = [view getCurrentViewController];
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[image];
    [shareParams SSDKSetupShareParamsByText:message
                                     images:imageArray
                                        url:[NSURL URLWithString:kAppURL]
                                      title:@"勤之时"
                                       type:SSDKContentTypeAuto];
    
    [shareParams SSDKSetupWeChatParamsByText:message title:@"勤之时" url:[NSURL URLWithString:kAppURL] thumbImage:[UIImage imageNamed:@"Icon-share.png"] image:image musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
    
    [shareParams SSDKSetupWeChatParamsByText:message title:@"勤之时" url:[NSURL URLWithString:kAppURL] thumbImage:[UIImage imageNamed:@"Icon-share.png"] image:image musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    
    [shareParams SSDKSetupQQParamsByText:message title:@"勤之时" url:[NSURL URLWithString:kAppURL] thumbImage:[UIImage imageNamed:@"Icon-share.png"] image:image type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeQZone];
    
    [shareParams SSDKSetupQQParamsByText:message title:@"勤之时" url:[NSURL URLWithString:kAppURL] thumbImage:[UIImage imageNamed:@"Icon-share.png"] image:image type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    
    //2、分享
    [ShareSDK showShareActionSheet:view
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateBegin:
                       {
                           [MBProgressHUD showHUDAddedTo:currentController.view animated:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //
                       }
                       case SSDKResponseStateFail:
                       {
                           if (!error) {
                               break;
                           }
                           
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201) {
                               [currentController presentAlertTitle:@"分享失败" message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"];
                               break;
                           } else if(platformType == SSDKPlatformTypeMail && [error code] == 201) {
                               [currentController presentAlertTitle:@"分享失败" message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"];
                               break;
                           } else {
                               [currentController presentAlertTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error]];
                               break;
                           }
                       }
                       case SSDKResponseStateCancel:
                       {
                           break;
                       }
                       default:
                           break;
                   }
                   
                   if (state != SSDKResponseStateBegin) {
                       [MBProgressHUD hideHUDForView:currentController.view animated:YES];
                   }
               }];
}

@end
