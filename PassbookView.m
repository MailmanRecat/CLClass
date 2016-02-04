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

- (void)setAsset:(CRClassAsset *)asset{
    _asset = asset;
    
    NSArray *weekdays = @[ @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday" ];
    
    NSString *status = [NSString stringWithFormat:@"%@ %@", [UIFont mdiCheckboxBlankCircle], [asset.alert isEqualToString:@"1"] ? [UIFont mdiBellOutline] : @""];
    
    NSMutableAttributedString *attributeStatus = [[NSMutableAttributedString alloc] initWithString:status];
    [attributeStatus setAttributes:@{
                       NSFontAttributeName: [UIFont MaterialDesignIconsWithSize:12],
                       NSForegroundColorAttributeName: [UIColor colorWithIndex:[asset.color intValue]]
                       }
               range:NSMakeRange(0, 1)];
    [attributeStatus setAttributes:@{
                       NSFontAttributeName: [UIFont systemFontOfSize:17 weight:UIFontWeightRegular],
                       NSForegroundColorAttributeName: [UIColor whiteColor]
                       }
               range:NSMakeRange(1, 1)];
    
    self.status.detailTextLabel.attributedText = attributeStatus;
    
    NSUInteger weekday = [asset.weekday intValue];
    
    self.weekdayLocation.textLabel.text = weekday < 7 ? weekdays[weekday] : weekdays.firstObject;
    self.weekdayLocation.detailTextLabel.text = asset.location;
    self.name.text = asset.name;
    self.startEnd.detailTextLabel.text = [NSString stringWithFormat:@"From %@ to %@", asset.start, asset.end];
    self.teacher.detailTextLabel.text = asset.teacher;
    self.note.text = asset.notes;
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
    
    self.teacher.textLabel.text = @"Teacher";
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
        [tv.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-57 - 24].active = YES;
        tv;
    });
    
    UIButton *(^actionButton)(void) = ^{
        UIButton *action = [[UIButton alloc] init];
        action.translatesAutoresizingMaskIntoConstraints = NO;
        action.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:action];
        [action.heightAnchor constraintEqualToConstant:57].active = YES;
        [action.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.5 constant:-16].active = YES;
        [action.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-16].active = YES;
        
        return action;
    };
    
    self.action1 = ({
        UIButton *action = actionButton();
        action.titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightRegular];
        
        [action.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
        [action setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
        [action setTitleColor:[UIColor colorWithWhite:1 alpha:0.4] forState:UIControlStateHighlighted];
        [action setTitle:@"Edit Class" forState:UIControlStateNormal];
        
        action;
    });
}

@end
