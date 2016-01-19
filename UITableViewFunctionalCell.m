//
//  UITableViewCellWithPicker.m
//  CRTestingProject
//
//  Created by caine on 1/13/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "UITableViewFunctionalCell.h"
#import "UIFont+MaterialDesignIcons.h"
#import "UIColor+Theme.h"
#import "Craig.h"

@interface UITableViewFunctionalCell()

@end

@implementation UITableViewFunctionalCell

- (instancetype)initWithReuseString:(NSString *)RString{
    
    UITableViewCellStyle style =
    ([RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_DEFAULT] | [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_COLOR]) ?
    UITableViewCellStyleValue1 : UITableViewCellStyleDefault;
    
    self = [super initWithStyle:style reuseIdentifier:RString];
    if( self ){
        
        [self initClass];
        
        if( [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_PICKER] )
            [self initPicker];
        
        else if( [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_TEXT] )
            [self initText];
        
        else if( [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_BUTTON] )
            [self initButton];
        
        else if( [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_DEFAULT] )
            [self initDefault];
        
        else if( [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_COLOR] )
            [self initColor];
        
    }
    return self;
}

- (void)initClass{
    self.backgroundColor = [UIColor clearColor];
}

- (void)initText{
    self.textView = ({
        UITextView *tv = [[UITextView alloc] init];
        tv.backgroundColor = [UIColor clearColor];
        tv.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        tv.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:tv];
        [tv.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0].active = YES;
        [tv.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:12].active = YES;
        [tv.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-12].active = YES;
        [tv.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-0].active = YES;
        tv;
    });
}

- (void)initPicker{
    self.picker = ({
        UIPickerView *p = [[UIPickerView alloc] init];
        [p setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:p];
        [p.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [p.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:16].active = YES;
        [p.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16].active = YES;
        [p.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        p;
    });
}

- (void)initButton{
    self.selectedBackgroundView = [Craig tableViewSelectedBackgroundEffectView:UIBlurEffectStyleDark];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
}

- (void)initDefault{
    self.selectedBackgroundView = [Craig tableViewSelectedBackgroundEffectView:UIBlurEffectStyleDark];
    self.textLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightLight];
    self.textLabel.textColor = [UIColor colorWithHex:CLThemeGray alpha:1];
    self.detailTextLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
    self.detailTextLabel.textColor = [UIColor colorWithHex:CLThemeBluelight alpha:1];
}

- (void)initColor{
    [self initDefault];
    
    self.detailTextLabel.font = [UIFont MaterialDesignIconsWithSize:12];
    self.detailTextLabel.text = [UIFont mdiCheckboxBlankCircle];
}

- (void)prepareForReuse{
    if( self.picker != nil ){
        [self.picker selectRow:(int)([self.picker numberOfRowsInComponent:0] / 2) inComponent:0 animated:NO];
        [self.picker selectRow:(int)([self.picker numberOfRowsInComponent:1] / 2) inComponent:1 animated:NO];
    }
}

@end
