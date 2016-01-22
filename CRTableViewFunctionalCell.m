//
//  CRTableViewFunctionalCell.m
//  CLClass
//
//  Created by caine on 1/22/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRTableViewFunctionalCell.h"
#import "UIColor+Theme.h"

@interface CRTableViewFunctionalCell()

@property( nonatomic, strong ) UILabel *accountIcon;
@property( nonatomic, strong ) UILabel *accountLabel;

@end

@implementation CRTableViewFunctionalCell

- (instancetype)initWithReuseString:(NSString *)RString{
    UITableViewCellStyle style = UITableViewCellStyleDefault;
    self = [super initWithStyle:style reuseIdentifier:RString];
    if( self ){
        
        if( [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_ACCOUNT] )
            [self initAccount];
        
        else if( [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_CLASS] )
            [self initClass];
        
    }
    return self;
}

- (void)initClass{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat height = 36;
    
    self.classtime = ({
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 72, height)];
        l.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        l.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:l];
        l;
    });
    
    self.classname = ({
        UILabel *l = [[UILabel alloc] init];
        l.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.classtime.rightAnchor constant:8].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:16].active = YES;
        [l.heightAnchor constraintEqualToConstant:height].active = YES;
        l;
    });
    
    self.classlocation = ({
        UILabel *l = [[UILabel alloc] init];
        l.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.classname.bottomAnchor].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.classtime.rightAnchor constant:8].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:16].active = YES;
        [l.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8].active = YES;
        l;
    });
}

- (void)initAccount{
    self.accountIcon = ({
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(16, 6, 44, 44)];
        l.backgroundColor = [UIColor colorWithHex:CLThemeGray alpha:1];
        l.textColor = [UIColor whiteColor];
        l.layer.cornerRadius = 22.0f;
        l.clipsToBounds = YES;
        l.textAlignment = NSTextAlignmentCenter;
        l.font = [UIFont systemFontOfSize:20 weight:UIFontWeightLight];
        
        [self.contentView addSubview:l];
        
        l;
    });
    
    self.accountLabel = ({
        UILabel *l = [[UILabel alloc] init];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView addSubview:l];
        [l.leftAnchor constraintEqualToAnchor:self.accountIcon.rightAnchor constant:16].active = YES;
        [l.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:56].active = YES;
        [l.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        
        l;
    });
}

- (void)setAccountName:(NSString *)accountName{
    _accountName = accountName;
    
    self.accountLabel.text = accountName;
    self.accountIcon.text  = accountName.length > 0 ? [[accountName substringToIndex:1] uppercaseString] : @"A";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
