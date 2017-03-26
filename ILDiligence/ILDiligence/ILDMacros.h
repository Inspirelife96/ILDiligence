//
//  ILDMacros.h
//  energy
//
//  Created by XueFeng Chen on 2017/3/13.
//  Copyright © 2017年 Chen XueFeng. All rights reserved.
//

#ifndef ILDMacros_h
#define ILDMacros_h

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define StatusBarHeight        (20.f)
#define TopBarHeight           (44.f)
#define BottomBarHeight        (49.f)
#define CellDefaultHeight      (44.f)
#define EnglishKeyboardHeight  (216.f)
#define ChineseKeyboardHeight  (252.f)

#define GetImage(Name, Ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(Name) ofType:(Ext)]]

#endif /* ILDMacros_h */
