//
//  CATextLabel.h
//  CRClassSchedule
//
//  Created by caine on 1/5/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CATextLabel : NSObject

+ (CATextLayer *)labelFromRect:(CGRect)rect string:(NSString *)string font:(UIFont *)font;

+ (CATextLayer *)labelFromRect:(CGRect)rect font:(UIFont *)font;

@end
