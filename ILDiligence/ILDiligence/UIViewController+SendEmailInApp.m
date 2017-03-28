//
//  UIViewController+SendEmailInApp.m
//  IOSSkillTree
//
//  Created by Chen XueFeng on 16/5/31.
//  Copyright © 2016年 Chen XueFeng. All rights reserved.
//

#import "UIViewController+SendEmailInApp.h"
#import "UIViewController+Alert.h"

@implementation UIViewController (SendEmailInApp)

- (void)sendMailInApp:(NSDictionary *)emailContent {
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        [self presentAlertTitle:@"不能发送邮件" message:@"您的系统版本不支持应用内发送邮件功能"];
        return;
    }
    
    if (![mailClass canSendMail]) {
        [self presentAlertTitle:@"不能发送邮件" message:@"您没有设置邮件账户"];
        return;
    }
    
    [self displayMailPicker:emailContent];
}

//调出邮件发送窗口
- (void)displayMailPicker:(NSDictionary *)emailContent
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    //[mailPicker.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置主题
    [mailPicker setSubject: [emailContent objectForKey:@"subject"]];
    //添加收件人
    [mailPicker setToRecipients: [emailContent objectForKey:@"recipients"]];
    [mailPicker setMessageBody:[emailContent objectForKey:@"body"] isHTML:YES];
    
    [self presentViewController:mailPicker animated:YES completion:nil];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            [self presentAlertTitle:@"发送中..." message:@"邮件已放在放到队列中，正在发送..."];
            break;
        case MFMailComposeResultFailed:
            [self presentAlertTitle:@"邮件发送失败" message:@"保存或者发送邮件失败"];
            break;
        default:
            break;
    }
}

@end
