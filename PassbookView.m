//
//  PassbookView.m
//  CLClass
//
//  Created by caine on 1/26/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "PassbookView.h"
#import "UIColor+Theme.h"
#import "CATextLabel.h"
#import "UIFont+MaterialDesignIcons.h"

@interface PassbookView()<UIScrollViewDelegate>

@property( nonatomic, strong ) UIVisualEffectView *book;
@property( nonatomic, strong ) UITableViewCell *weekdayLocation;
@property( nonatomic, strong ) UILabel         *name;
@property( nonatomic, strong ) UITableViewCell *startEnd;
@property( nonatomic, strong ) UITableViewCell *teacher;
@property( nonatomic, strong ) UITableViewCell *status;

@property( nonatomic, strong ) UITextView      *note;

@end

@implementation PassbookView

- (void)passbookOfClassAsset:(CRClassAsset *)asset{
    
}

- (instancetype)initWithEffect:(UIVisualEffect *)effect{
    self = [super initWithEffect:effect];
    if( self ){
        [self UI];
    }
    return self;
}

- (void)UI{
    self.weekdayLocation = ({
        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        l.textLabel.textColor = [UIColor whiteColor];
        l.detailTextLabel.textColor = [UIColor whiteColor];
        l.textLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        l.detailTextLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        l.userInteractionEnabled = NO;
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.contentView.topAnchor
                                    constant:[UIApplication sharedApplication].statusBarFrame.size.height].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [l.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
        [l.heightAnchor constraintEqualToConstant:44].active = YES;
        l;
    });
    
    self.weekdayLocation.textLabel.text = @"Monday";
    self.weekdayLocation.detailTextLabel.text = @"somtwhere see you";
    
    self.name = ({
        UILabel *l = [[UILabel alloc] init];
        l.textColor = [UIColor whiteColor];
        l.adjustsFontSizeToFitWidth = YES;
        l.numberOfLines = 0;
        l.font = [UIFont systemFontOfSize:64 weight:UIFontWeightThin];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.weekdayLocation.bottomAnchor].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:16].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16].active = YES;
        [l.heightAnchor constraintGreaterThanOrEqualToConstant:86].active = YES;
        [l.heightAnchor constraintLessThanOrEqualToConstant:72 + 56].active = YES;
        l;
    });
    
    self.name.text = @"History";
    
    self.startEnd = ({
        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        l.textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        l.detailTextLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        l.textLabel.textColor = [UIColor whiteColor];
        l.detailTextLabel.textColor = [UIColor whiteColor];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        l.userInteractionEnabled = NO;
        [self.contentView addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.name.bottomAnchor constant:8].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
        [l.heightAnchor constraintEqualToConstant:56].active = YES;
        l;
    });
    
    self.startEnd.textLabel.text = @"Time";
    self.startEnd.detailTextLabel.text = @"From 09:00 am to 12:00";
    
//    self.startEnd.backgroundColor = [UIColor redColor];
    
//    self.startEndTime.backgroundColor = [UIColor lightGrayColor];
    
    NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", [UIFont mdiCheckboxBlankCircle], @"From 09:08 to 17:08"]];
    [s setAttributes:@{
                       NSFontAttributeName: [UIFont MaterialDesignIconsWithSize:12],
                       NSForegroundColorAttributeName: [UIColor orangeColor]
                       }
               range:NSMakeRange(0, 1)];
    [s setAttributes:@{
                       NSFontAttributeName: [UIFont systemFontOfSize:17 weight:UIFontWeightRegular],
                       NSForegroundColorAttributeName: [UIColor whiteColor]
                       }
               range:NSMakeRange(1, s.length - 1)];
//    self.start.attributedText = self.end.attributedText = s;
//    self.startEnd.textLabel.attributedText = s;
    
//    self.startEnd.detailTextLabel.attributedText = s;
    
    self.teacher = ({
        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        l.textLabel.textColor = [UIColor whiteColor];
        l.detailTextLabel.textColor = [UIColor whiteColor];
        l.textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        l.detailTextLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        l.userInteractionEnabled = NO;
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.startEnd.bottomAnchor constant:4].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [l.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
        [l.heightAnchor constraintEqualToConstant:56].active = YES;
        l;
    });
    
//    self.teacher.backgroundColor = [UIColor purpleColor];
    
    self.teacher.textLabel.text = @"Teacher";
    self.teacher.detailTextLabel.text = @"Craig & steven";
    self.teacher.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    
    self.status = ({
        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        l.textLabel.textColor = [UIColor whiteColor];
        l.detailTextLabel.textColor = [UIColor whiteColor];
        l.textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        l.userInteractionEnabled = NO;
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.teacher.bottomAnchor constant:0].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [l.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
        [l.heightAnchor constraintEqualToConstant:56].active = YES;
        l;
    });
    
    self.status.textLabel.text = @"Status";
    self.status.detailTextLabel.font = [UIFont MaterialDesignIconsWithSize:20];
    
    self.status.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", [UIFont mdiCheckboxBlankCircle], [UIFont mdiBellOutline]];
    
    self.note = ({
        UITextView *tv = [[UITextView alloc] init];
        tv.backgroundColor = [UIColor clearColor];
        tv.textColor = [UIColor whiteColor];
        tv.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        tv.textContainerInset = UIEdgeInsetsZero;
        tv.textContainer.lineFragmentPadding = 0;
        tv.translatesAutoresizingMaskIntoConstraints = NO;
        tv.editable = NO;
        tv.showsHorizontalScrollIndicator = NO;
        tv.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:tv];
        [tv.topAnchor constraintEqualToAnchor:self.status.bottomAnchor constant:8].active = YES;
        [tv.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:16].active = YES;
        [tv.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16].active = YES;
        [tv.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-52].active = YES;
        tv;
    });
    
//    self.note.text = @"The new Chinese system font PingFang was designed specifically for digital displays, delivering unmatched legibility in both Simplified and Traditional Chinese.PingFang is available in six weights from ultralight to semibold. The different weights give you flexibility for headlines, captions, and more.";
    self.note.text = @"Notes";
    
    UIButton *(^actionButton)(void) = ^{
        UIButton *action = [[UIButton alloc] init];
        action.translatesAutoresizingMaskIntoConstraints = NO;
        action.backgroundColor = [UIColor clearColor];
        action.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        
        [self.contentView addSubview:action];
        [action.heightAnchor constraintEqualToConstant:44].active = YES;
        [action.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.5 constant:-16].active = YES;
        [action.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        
        return action;
    };
    
    self.action1 = ({
        UIButton *action = actionButton();
        [action.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:16].active = YES;
        [action setTitleColor:[UIColor colorWithHex:CLThemeRedlight alpha:1] forState:UIControlStateNormal];
        [action setTitleColor:[UIColor colorWithHex:CLThemeRedlight alpha:0.4] forState:UIControlStateHighlighted];
        [action setTitle:@"Delete" forState:UIControlStateNormal];
        
        action.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        action;
    });
    
    self.action2 = ({
        UIButton *action = actionButton();
        [action.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16].active = YES;
        [action setTitleColor:[UIColor colorWithHex:CLThemeRedlight alpha:1] forState:UIControlStateNormal];
        [action setTitleColor:[UIColor colorWithHex:CLThemeRedlight alpha:0.4] forState:UIControlStateHighlighted];
        [action setTitle:@"Edit" forState:UIControlStateNormal];
        
        action.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        action;
    });
}

@end
