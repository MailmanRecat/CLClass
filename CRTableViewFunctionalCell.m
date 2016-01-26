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
        
        else if( [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_NOCLASS] )
            [self initNoClass];
        
    }
    return self;
}

- (void)initClass{
    
    CGFloat height = 36;
    
    self.contaniner = ({
        UIView *c = [[UIView alloc] init];
        c.layer.cornerRadius = 8.0f;
        c.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:c];
        [c.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:86].active = YES;
        [c.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8].active = YES;
        [c.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16].active = YES;
        [c.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8].active = YES;
        c;
    });
    
    self.contaniner.backgroundColor = [UIColor colorWithIndex:CLThemeBluedeep];
    
    self.classtime = ({
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 86, height)];
        l.font = [UIFont systemFontOfSize:12.5 weight:UIFontWeightRegular];
        l.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:l];
        l;
    });
    
    self.classname = ({
        UILabel *l = [[UILabel alloc] init];
        l.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        l.textColor = [UIColor whiteColor];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contaniner addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.contaniner.topAnchor constant:0].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.contaniner.leftAnchor constant:8].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.contaniner.rightAnchor constant:-8].active = YES;
        [l.heightAnchor constraintEqualToConstant:height].active = YES;
        l;
    });
    
    self.classlocation = ({
        UILabel *l = [[UILabel alloc] init];
        l.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        l.textColor = [UIColor whiteColor];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contaniner addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.classname.bottomAnchor constant:-16].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.contaniner.leftAnchor constant:8].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.contaniner.rightAnchor constant:-8].active = YES;
        [l.bottomAnchor constraintEqualToAnchor:self.contaniner.bottomAnchor constant:0].active = YES;
        l;
    });
}

- (void)initNoClass{
    self.contaniner = ({
        UIView *c = [[UIView alloc] init];
        c.layer.cornerRadius = 8.0f;
        c.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:c];
        [c.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:86].active = YES;
        [c.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:16].active = YES;
        [c.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16].active = YES;
        [c.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-16].active = YES;
        c;
    });
    
    UILabel *l = [[UILabel alloc] init];
    l.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contaniner addSubview:l];
    [l.topAnchor constraintEqualToAnchor:self.contaniner.topAnchor].active = YES;
    [l.leftAnchor constraintEqualToAnchor:self.contaniner.leftAnchor constant:8].active = YES;
    [l.rightAnchor constraintEqualToAnchor:self.contaniner.rightAnchor constant:-8].active = YES;
    [l.bottomAnchor constraintEqualToAnchor:self.contaniner.bottomAnchor].active = YES;
    
    l.textColor = [UIColor whiteColor];
    l.font      = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    
    l.text      = @"No class today, Tap to add.";
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
