//
//  UIViewController+Alert.m
//  
//
//  Created by Chen XueFeng on 16/6/17.
//
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)presentAlertTitle:(NSString*)title message:(NSString*)message {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                               }];
    
    [alertController addAction:okAction];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
        popPresenter.sourceView = self.view;
        popPresenter.sourceRect = self.view.bounds;
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
