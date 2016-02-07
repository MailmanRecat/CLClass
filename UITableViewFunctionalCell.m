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
        
        else if( [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_TEXTFIELD] )
            [self initTextField];
        
        else if( [RString isEqualToString:REUSE_FUNCTIONAL_CELL_ID_SWITCH] )
            [self initSwitch];
        
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
        UIDatePicker *p = [[UIDatePicker alloc] init];
        p.datePickerMode = UIDatePickerModeTime;
        [p setValue:[UIColor whiteColor] forKey:@"textColor"];
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
    self.textLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    self.textLabel.textColor = [UIColor whiteColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
    self.detailTextLabel.textColor = [UIColor colorWithHex:CLThemeBluelight alpha:1];
}

- (void)initColor{
    [self initDefault];
    
    self.detailTextLabel.font = [UIFont MaterialDesignIconsWithSize:12];
    self.detailTextLabel.text = [UIFont mdiCheckboxBlankCircle];
}

- (void)initTextField{
    self.textField = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:textField];
        [textField.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:16].active = YES;
        [textField.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [textField.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
        [textField.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        
        textField;
    });
}

- (void)initSwitch{
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.textColor = [UIColor whiteColor];
    
    self.switchControl = ({
        UISwitch *sc   = [[UISwitch alloc] init];
        sc.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:sc];
        [sc.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-32].active = YES;
        [sc.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
        sc;
    });
}

- (void)prepareForReuse{
}

@end
