//
//  UILabel+StringFrame.m
//  wowradio
//
//  Created by Chen XueFeng on 16/3/22.
//  Copyright © 2016年 Chen XueFeng. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)

- (CGSize)boundingRectWithSize:(CGSize)size attributes:(nullable NSDictionary *) attributes
{
    if (attributes == nil) {
        attributes = @{NSFontAttributeName: self.font} ;
    }
    CGSize actualSize = [self.text boundingRectWithSize:size
                                                options:\
                         NSStringDrawingTruncatesLastVisibleLine |
                         NSStringDrawingUsesLineFragmentOrigin |
                         NSStringDrawingUsesFontLeading
                                             attributes:attributes
                                                context:nil].size;
    
    return actualSize;
}

- (nullable NSDictionary *) attributes: (CGFloat)lineSpace {
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc]init] ;
    paragraph.alignment = NSTextAlignmentCenter;
    paragraph.lineSpacing = lineSpace;
    NSDictionary* attributes = @{NSParagraphStyleAttributeName: paragraph,NSFontAttributeName: self.font} ;
    return attributes ;
}

@end
