//
//  CRVisualFloatingButton.m
//  CRNote
//
//  Created by caine on 12/30/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRVisualFloatingButton.h"
#import "UIView+CRView.h"

@interface CRVisualFloatingButton()

@property( nonatomic, strong ) UILabel *titleLabel;

@end

@implementation CRVisualFloatingButton

- (instancetype)initFromFont:(UIFont *)font title:(NSString *)title blurEffectStyle:(UIBlurEffectStyle)effectStyle{
    self = [super init];
    
    [self initClass:effectStyle];
    [self.titleLabel setFont:font];
    [self.titleLabel setText:title];
    
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (void)initClass:(UIBlurEffectStyle)style{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.widthAnchor constraintEqualToConstant:56].active = YES;
    [self.heightAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [self letShadowWithSize:CGSizeMake(0, 0.7f) opacity:0.4f radius:1.0f];
    
    CGRect selfRect = CGRectMake(0, 0, 56, 56);
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:style];
    
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc] initWithEffect:blur];
    visualEffect.frame = selfRect;
    visualEffect.userInteractionEnabled = NO;
    visualEffect.layer.cornerRadius = 56 / 2;
    visualEffect.clipsToBounds = YES;
    [self addSubview:visualEffect];
    
    UIVisualEffectView *visualVibrancy = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:blur]];
    visualVibrancy.frame = selfRect;
    visualVibrancy.userInteractionEnabled = NO;
    [visualEffect.contentView addSubview:visualVibrancy];
    
    self.titleLabel = ({
        UILabel *tl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 56)];
        tl.userInteractionEnabled = NO;
        tl.textAlignment = NSTextAlignmentCenter;
        tl.textColor = style == UIBlurEffectStyleDark ? [UIColor whiteColor] : [UIColor colorWithWhite:89 / 255.0 alpha:1];
        tl;
    });
    
    [self addSubview:self.titleLabel];
}

@end
