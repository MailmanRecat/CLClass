//
//  CLTabBar.m
//  CLClass
//
//  Created by caine on 1/5/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CLTabBar.h"
#import "UIFont+MaterialDesignIcons.h"

#import "UIColor+Theme.h"

@interface CLTabBar()

@end

@implementation CLTabBar

- (instancetype)init{
    self = [super init];
    if( self ){
        [self initClass];
    }
    return self;
}

- (void)initClass{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.heightAnchor constraintEqualToConstant:49].active = YES;
    
    self.letClassCount = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"12 classes";
        label.textColor = [UIColor colorWithHex:CLThemeBluelight alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightLight];
        label.userInteractionEnabled = NO;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        [label.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [label.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [label.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        [label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        label;
    });
    
    self.letClass = ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont MaterialDesignIconsWithSize:21];
        [btn setTitleColor:[UIColor colorWithHex:CLThemeBluelight alpha:1] forState:UIControlStateNormal];
        [btn setTitle:[UIFont mdiPlus] forState:UIControlStateNormal];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:btn];
        [btn.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        [btn.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [btn.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
        [btn.widthAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
        btn;
    });
    
    self.letAccount = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(8, 0, 49, 49)];
        btn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        [btn setTitleColor:[UIColor colorWithHex:CLThemeBluelight alpha:1] forState:UIControlStateNormal];
        [btn setTitle:@"craig" forState:UIControlStateNormal];
        [self addSubview:btn];
        btn;
    });
}

@end
