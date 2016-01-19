//
//  UIColor+Theme.h
//  CLClass
//
//  Created by caine on 1/6/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#define CLThemeBluelight   0x54c7fc
#define CLThemeBluedeep    0x0076ff
#define CLThemeYellowlight 0xffcd00
#define CLThemeYellowdeep  0xff9600
#define CLThemeRedlight    0xff2851
#define CLThemeReddeep     0xff3824
#define CLThemeGreen       0x44db5e
#define CLThemeGray        0x8e8e93

#import <UIKit/UIKit.h>

@interface UIColor (Theme)

+ (UIColor *)colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha;

@end
