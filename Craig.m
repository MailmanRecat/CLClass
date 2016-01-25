//
//  Craig.m
//  CRTestingProject
//
//  Created by caine on 1/13/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "Craig.h"
#import "UIColor+Theme.h"

@implementation Craig

+ (UIVisualEffectView *)tableViewSelectedBackgroundEffectView:(UIBlurEffectStyle)style{
    UIVisualEffectView *visual = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:style]]];
    
    return ({
        UIView *background = [[UIView alloc] init];
        [background setTranslatesAutoresizingMaskIntoConstraints:NO];
        [background setBackgroundColor:[UIColor whiteColor]];
        [visual.contentView addSubview:background];
        [background.topAnchor constraintEqualToAnchor:visual.contentView.topAnchor].active = YES;
        [background.rightAnchor constraintEqualToAnchor:visual.contentView.rightAnchor].active = YES;
        [background.leftAnchor constraintEqualToAnchor:visual.contentView.leftAnchor].active = YES;
        [background.bottomAnchor constraintEqualToAnchor:visual.contentView.bottomAnchor].active = YES;

        visual;
    });
}

+ (UIView *)tableHeaderContentViewWithTitle:(NSString *)title{
    UIView *content = [[UIView alloc] init];
    
    if( title != nil ){
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(16, 12, 256, 44)];
        l.textColor = [UIColor whiteColor];
        l.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        l.text = title;
        [content addSubview:l];
    }
    
    return content;
}

@end
