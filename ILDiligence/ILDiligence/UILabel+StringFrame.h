//
//  UILabel+StringFrame.h
//  wowradio
//
//  Created by Chen XueFeng on 16/3/22.
//  Copyright © 2016年 Chen XueFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (StringFrame)

- (CGSize)boundingRectWithSize:(CGSize)size attributes:(nullable NSDictionary *) attributes;
- (nullable NSDictionary *) attributes: (CGFloat)lineSpace;

@end
