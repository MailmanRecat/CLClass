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

@interface PassbookView()<UIScrollViewDelegate>

@property( nonatomic, strong ) UIView *book;
@property( nonatomic, strong ) UITableViewCell *weekdayLocation;
@property( nonatomic, strong ) UILabel     *name;
@property( nonatomic, strong ) UITableViewCell *startEnd;
@property( nonatomic, strong ) UITableViewCell *startEndTime;
@property( nonatomic, strong ) UILabel *start;
@property( nonatomic, strong ) UILabel *end;
@property( nonatomic, strong ) UILabel *to;
@property( nonatomic, strong ) UITableViewCell *teacher;
@property( nonatomic, strong ) UITextView      *note;

@property( nonatomic, strong ) UIButton *action1;
@property( nonatomic, strong ) UIButton *action2;

@end

@implementation PassbookView

- (instancetype)init{
    self = [super init];
    if( self ){
        [self initClass];
    }
    return self;
}

- (void)initClass{
    self.delegate = self;
    self.clipsToBounds = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    
    CGFloat offset = ({
        CGFloat result;
        if( [UIScreen mainScreen].bounds.size.height == 480 )
            result = -44 * 2;
        else
            result = -88 * 2;
        
        result;
    });
    
    self.book = ({
        UIView *book = [[UIView alloc] init];
        book.backgroundColor = [UIColor colorWithHex:CLThemeBluelight alpha:1];
        book.layer.cornerRadius = 16.0f;
        book.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:book];
        [book.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [book.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        [book.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
        [book.heightAnchor constraintEqualToAnchor:self.heightAnchor constant:offset].active = YES;
        book;
    });
    
    self.weekdayLocation = ({
        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        l.textLabel.textColor = [UIColor whiteColor];
        l.detailTextLabel.textColor = [UIColor whiteColor];
        l.textLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        l.detailTextLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        l.userInteractionEnabled = NO;
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.book addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.book.topAnchor constant:8].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.book.leftAnchor].active = YES;
        [l.widthAnchor constraintEqualToAnchor:self.book.widthAnchor].active = YES;
        [l.heightAnchor constraintEqualToConstant:44].active = YES;
        l;
    });
    
    self.weekdayLocation.textLabel.text = @"Monday";
    self.weekdayLocation.detailTextLabel.text = @"somtwhere see you";
    
    self.name = ({
        UILabel *l = [[UILabel alloc] init];
        l.textColor = [UIColor whiteColor];
        l.adjustsFontSizeToFitWidth = YES;
        l.font = [UIFont systemFontOfSize:64 weight:UIFontWeightThin];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.book addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.book.topAnchor constant:44].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.book.leftAnchor constant:16].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.book.rightAnchor constant:-16].active = YES;
        [l.heightAnchor constraintEqualToConstant:86].active = YES;
        l;
    });
    
    self.name.text = @"History";
    
//    self.startEnd = ({
//        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
//        l.textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
//        l.detailTextLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
//        l.textLabel.textColor = l.detailTextLabel.textColor = [UIColor whiteColor];
//        l.translatesAutoresizingMaskIntoConstraints = NO;
//        l.userInteractionEnabled = NO;
//        [self.book addSubview:l];
//        [l.topAnchor constraintEqualToAnchor:self.name.bottomAnchor].active = YES;
//        [l.leftAnchor constraintEqualToAnchor:self.book.leftAnchor].active = YES;
//        [l.rightAnchor constraintEqualToAnchor:self.book.rightAnchor].active = YES;
//        [l.heightAnchor constraintEqualToConstant:44].active = YES;
//        l;
//    });
    
    self.to = ({
        UILabel *l = [[UILabel alloc] init];
        l.text = @"to";
        l.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        l.textColor = [UIColor whiteColor];
        l.textAlignment = NSTextAlignmentCenter;
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.book addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.name.bottomAnchor].active = YES;
        [l.centerXAnchor constraintEqualToAnchor:self.book.centerXAnchor].active = YES;
        [l.heightAnchor constraintEqualToConstant:56].active = YES;
        [l.widthAnchor constraintEqualToConstant:32].active = YES;
        l;
    });
    
    self.startEnd.textLabel.text = @"Start";
    self.startEnd.detailTextLabel.text = @"End";
    
//    self.startEnd.backgroundColor = [UIColor redColor];
    
    self.startEndTime = ({
        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        l.userInteractionEnabled = NO;
        [self.book addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.to.topAnchor].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.book.leftAnchor].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.book.rightAnchor].active = YES;
        [l.heightAnchor constraintEqualToAnchor:self.to.heightAnchor].active = YES;
        l;
    });
    
//    self.startEndTime.backgroundColor = [UIColor lightGrayColor];
    
    NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"09:05 pm"];
    [s setAttributes:@{
                       NSFontAttributeName: [UIFont systemFontOfSize:17 weight:UIFontWeightRegular],
                       NSForegroundColorAttributeName: [UIColor whiteColor]
                       }
               range:NSMakeRange(6, 2)];
    [s setAttributes:@{
                       NSFontAttributeName: [UIFont systemFontOfSize:36 weight:UIFontWeightThin],
                       NSForegroundColorAttributeName: [UIColor whiteColor]
                       }
               range:NSMakeRange(0, 5)];
//    self.start.attributedText = self.end.attributedText = s;
//    self.startEnd.textLabel.attributedText = s;
    self.startEndTime.textLabel.attributedText = self.startEndTime.detailTextLabel.attributedText = s;
    
    self.teacher = ({
        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        l.textLabel.textColor = [UIColor whiteColor];
        l.detailTextLabel.textColor = [UIColor whiteColor];
        l.textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        l.detailTextLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        l.userInteractionEnabled = NO;
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.book addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.to.bottomAnchor].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.book.leftAnchor].active = YES;
        [l.widthAnchor constraintEqualToAnchor:self.book.widthAnchor].active = YES;
        [l.heightAnchor constraintEqualToConstant:56].active = YES;
        l;
    });
    
//    self.teacher.backgroundColor = [UIColor purpleColor];
    
    self.teacher.textLabel.text = @"Teacher";
    self.teacher.detailTextLabel.text = @"Craig & steven";
    self.teacher.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    
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
        [self.book addSubview:tv];
        [tv.topAnchor constraintEqualToAnchor:self.teacher.bottomAnchor constant:8].active = YES;
        [tv.leftAnchor constraintEqualToAnchor:self.book.leftAnchor constant:16].active = YES;
        [tv.rightAnchor constraintEqualToAnchor:self.book.rightAnchor constant:-16].active = YES;
        [tv.bottomAnchor constraintEqualToAnchor:self.book.bottomAnchor constant:-8].active = YES;
        tv;
    });
    
    self.note.text = @"The new Chinese system font PingFang was designed specifically for digital displays, delivering unmatched legibility in both Simplified and Traditional Chinese.PingFang is available in six weights from ultralight to semibold. The different weights give you flexibility for headlines, captions, and more.";
    
    UIButton *(^actionButton)(void) = ^{
        UIButton *action = [[UIButton alloc] init];
        action.translatesAutoresizingMaskIntoConstraints = NO;
        action.layer.cornerRadius = 16.0f;
        action.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:action];
        [action.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [action.heightAnchor constraintEqualToConstant:57].active = YES;
        [action.widthAnchor constraintEqualToAnchor:self.book.widthAnchor].active = YES;
        
        return action;
    };
    
//    self.action1 = ({
//        UIButton *action = actionButton();
//        [action.topAnchor constraintEqualToAnchor:self.book.bottomAnchor constant:8].active = YES;
//        action;
//    });
//    
//    self.action2 = ({
//        UIButton *action = actionButton();
//        [action.topAnchor constraintEqualToAnchor:self.action1.bottomAnchor constant:2].active = YES;
//        [action.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-8].active = YES;
//        action;
//    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8 - fabs(scrollView.contentOffset.y) / 360.0];
    
    if( scrollView.contentOffset.y == 0 ){
        self.userInteractionEnabled = YES;
    }
    
    if( scrollView.contentOffset.y < -180 ){
        self.userInteractionEnabled = NO;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
