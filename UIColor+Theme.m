//
//  UIColor+Theme.m
//  CLClass
//
//  Created by caine on 1/6/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *)colorWithIndex:(int)i alpha:(CGFloat)a{
    UIColor *color = [self colorWithIndex:i];
    
    return [color colorWithAlphaComponent:a];
}

+ (UIColor *)colorWithIndex:(int)i{
        
//    NSArray *colors = @[
                        //                        [UIColor colorWithRed:255 / 255.0 green:41  / 255.0 blue:104 / 255.0 alpha:1],
//                        [self colorWithHex:CLThemeRedlight alpha:1],
                        //                        [UIColor colorWithRed:255 / 255.0 green:149 / 255.0 blue:0   / 255.0 alpha:1],
//                        [self colorWithHex:CLThemeYellowdeep alpha:1],
                        //                        [UIColor colorWithRed:255 / 255.0 green:204 / 255.0 blue:1   / 255.0 alpha:1],
//                        [self colorWithHex:CLThemeYellowlight alpha:1],
                        //                        [UIColor colorWithRed:99  / 255.0 green:218 / 255.0 blue:56  / 255.0 alpha:1],
//                        [self colorWithHex:CLThemeGreen alpha:1],
                        //                        [UIColor colorWithRed:27  / 255.0 green:173 / 255.0 blue:248 / 255.0 alpha:1],
//                        [self colorWithHex:CLThemeBluelight alpha:1],
//                        [UIColor colorWithRed:204 / 255.0 green:115 / 255.0 blue:225 / 255.0 alpha:1],
//                        [UIColor colorWithRed:161 / 255.0 green:131 / 255.0 blue:93  / 255.0 alpha:1]
//                        ];
    
    NSArray *colors = @[
                        [self colorRGB:250 :17  :79  :1],
                        [self colorRGB:255 :59  :48  :1],
                        [self colorRGB:255 :149 :0   :1],
                        [self colorRGB:4   :222 :113 :1],
                        [self colorRGB:0   :245 :234 :1],
                        [self colorRGB:90  :200 :250 :1],
                        [self colorRGB:32  :148 :250 :1],
                        [self colorRGB:120 :122 :255 :1],
                        [self colorRGB:242 :244 :255 :1]
                        ];
    
    if( i < 0 || i > colors.count - 1 ) return colors.firstObject;
    
    return colors[i];
}

+ (NSArray *)colors{
    return @[
             [self colorWithIndex:0],
             [self colorWithIndex:1],
             [self colorWithIndex:2],
             [self colorWithIndex:3],
             [self colorWithIndex:4],
             [self colorWithIndex:5],
             [self colorWithIndex:6],
             [self colorWithIndex:7],
             [self colorWithIndex:8]
             ];
}

+ (UIColor *)colorRGB:(CGFloat)R :(CGFloat)G :(CGFloat)B :(CGFloat)A{
    return [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A];
}

+ (UIColor *)colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha{
    
    CGFloat red   = (CGFloat) ((hex & 0xff0000) >> 16) / 255.0f;
    CGFloat green = (CGFloat) ((hex & 0x00ff00) >>  8) / 255.0f;
    CGFloat blue  = (CGFloat) ( hex & 0x0000ff)        / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
