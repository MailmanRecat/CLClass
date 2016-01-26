//
//  APPADUITableViewCell.m
//  FontPreview
//
//  Created by caine on 1/24/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "APPADUITableViewCell.h"

@implementation APPADUITableViewCell

- (instancetype)initWithReuseString:(NSString *)RString{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RString];
    if( self ){
        [self initClass];
    }
    return self;
}

- (void)initClass{
    self.separatorInset = UIEdgeInsetsMake(0, 84, 0, 0);
    
    self.switchControl = ({
        UISwitch *sc   = [[UISwitch alloc] init];
        sc.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:sc];
        [sc.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16].active = YES;
        [sc.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
        sc;
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
