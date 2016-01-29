//
//  CRVisualBar.m
//  CLClass
//
//  Created by caine on 1/29/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRVisualBar.h"

@interface CRVisualBar()

@end

@implementation CRVisualBar

- (instancetype)initWithEffect:(UIVisualEffect *)effect{
    self = [super initWithEffect:effect];
    if( self ){
        [self UI];
    }
    return self;
}

- (void)UI{
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:label];
        [label.heightAnchor constraintEqualToConstant:44].active = YES;
        [label.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:16].active = YES;
        [label.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16].active = YES;
        [label.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        label;
    });
    
    UIButton *(^buttonItem)(void) = ^{
        UIButton *button = [[UIButton alloc] init];
        
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:button];
        [button.heightAnchor constraintEqualToConstant:44].active = YES;
        [button.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.5 constant:-16].active = YES;
        [button.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        
        return button;
    };
    
    self.leftItem = ({
        UIButton *b = buttonItem();
        [b.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:8].active = YES;
        
        b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        b;
    });
    
    self.rightItem = ({
        UIButton *b = buttonItem();
        [b.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-8].active = YES;
        
        b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        b;
    });
}

@end
