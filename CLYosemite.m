//
//  CLYosemite.m
//  CLClass
//
//  Created by caine on 1/6/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#import "CLYosemite.h"
#import "UIFont+MaterialDesignIcons.h"

@interface CLYosemite()

@end

@implementation CLYosemite

- (instancetype)init{
    self = [super init];
    if( self ){
        [self initClass];
    }
    return self;
}

- (void)initClass{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.heightAnchor constraintEqualToConstant:56 + STATUS_BAR_HEIGHT].active = YES;
    
    self.titleLabel = ({
        UILabel *tit = [[UILabel alloc] init];
        tit.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        tit.textAlignment = NSTextAlignmentCenter;
        tit.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:tit];
        [tit.topAnchor constraintEqualToAnchor:self.topAnchor constant:STATUS_BAR_HEIGHT].active = YES;
        [tit.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
        [tit.heightAnchor constraintEqualToConstant:56].active = YES;
        [tit.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        tit;
    });
    
    self.dismiss = ({
        UIButton *dis = [[UIButton alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 56, 56)];
        [dis.titleLabel setFont:[UIFont MaterialDesignIconsWithSize:24]];
        [dis setTitle:[UIFont mdiArrowLeft] forState:UIControlStateNormal];
        [self addSubview:dis];
        dis;
    });
}

@end
