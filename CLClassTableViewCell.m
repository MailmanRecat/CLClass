//
//  CLClassTableViewCell.m
//  CLClass
//
//  Created by caine on 1/6/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CLClassTableViewCell.h"

@interface CLClassTableViewCell()

@end

@implementation CLClassTableViewCell

- (instancetype)initFromClass{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCLClassCellID];
    if( self ){
        [self initClass];
    }
    return self;
}



- (void)initClass{
    self.backgroundColor = [UIColor clearColor];
    
    self.classname = ({
        UILabel *name = [[UILabel alloc] init];
        name.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        name.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:name];
        [name.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0].active = YES;
        [name.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:16].active = YES;
        [name.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16].active = YES;
        [name.heightAnchor constraintEqualToConstant:40].active = YES;
        name;
    });
    
    self.classtime = ({
        CATextLayer *tl = [CATextLabel labelFromRect:CGRectMake(16, 40, 272, 16) font:[UIFont systemFontOfSize:13 weight:UIFontWeightRegular]];
        [self.contentView.layer addSublayer:tl];
        tl;
    });
    
    self.classcontent = ({
        UILabel *content = [[UILabel alloc] init];
        content.font = [UIFont systemFontOfSize:17 weight:UIFontWeightLight];
        content.translatesAutoresizingMaskIntoConstraints = NO;
//        content.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:content];
        [content.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:56].active = YES;
        [content.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:16].active = YES;
        [content.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16].active = YES;
        [content.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-0].active = YES;
        content;
    });
}

@end
