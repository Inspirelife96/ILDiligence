//
//  UIViewController+SendEmailInApp.h
//  IOSSkillTree
//
//  Created by Chen XueFeng on 16/5/31.
//  Copyright © 2016年 Chen XueFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface UIViewController (SendEmailInApp) <MFMailComposeViewControllerDelegate>

- (void)sendMailInApp:(NSDictionary *)emailContent;

@end
