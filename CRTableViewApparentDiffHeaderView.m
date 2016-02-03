//
//  CRTableViewApparentDiffHeaderView.m
//  CLClass
//
//  Created by caine on 1/22/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRTableViewApparentDiffHeaderView.h"
#import "CATextLabel.h"

@interface CRTableViewApparentDiffHeaderView()

@end

@implementation CRTableViewApparentDiffHeaderView

- (instancetype)initWithTitle:(NSString *)title photo:(UIImage *)photo{
    self = [super initWithReuseIdentifier:REUSE_TABLEVIEW_APPARENTDIFF_ID];
    if( self ){
        
        [self initClass:title photo:photo];

    }
    return self;
}

- (void)initClass:(NSString *)title photo:(UIImage *)photo{
    self.contentView.clipsToBounds = YES;
    
    self.photowall = ({
        UIImageView *pw = [[UIImageView alloc] initWithImage:photo];
        pw.contentMode = UIViewContentModeScaleAspectFill;
        pw.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:pw];
        [pw.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [pw.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
        [pw.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
        [pw.heightAnchor constraintEqualToAnchor:pw.widthAnchor].active = YES;
        self.photowallLayoutGuide = [pw.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:21];
        self.photowallLayoutGuide.active = YES;
        pw;
    });
    
    self.titleLabel = ({
        CATextLayer *tl = [CATextLabel labelFromRect:CGRectMake(56, 32, 200, 56)
                                              string:title
                                                font:[UIFont systemFontOfSize:27
                                                                       weight:UIFontWeightRegular]];
        [self.contentView.layer addSublayer:tl];
        tl;
    });
    
    self.button = ({
        UIControl *button = [[UIControl alloc] init];
        button.backgroundColor = [UIColor clearColor];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:button];
        [button.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [button.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        [button.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [button.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
        button;
    });
}

- (void)prepareForReuse{
    [super prepareForReuse];
}

@end
