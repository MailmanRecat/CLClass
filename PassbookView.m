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
@property( nonatomic, strong ) UILabel     *weekday;
@property( nonatomic, strong ) UILabel     *name;
@property( nonatomic, strong ) UITableViewCell *startEnd;
@property( nonatomic, strong ) CATextLayer *start;
@property( nonatomic, strong ) CATextLayer *end;
@property( nonatomic, strong ) UILabel     *to;
@property( nonatomic, strong ) UITableViewCell *teacher;
@property( nonatomic, strong ) UITableViewCell *location;
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
    
    self.book = ({
        UIView *book = [[UIView alloc] init];
        book.backgroundColor = [UIColor whiteColor];
        book.layer.cornerRadius = 16.0f;
        book.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:book];
        [book.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [book.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        [book.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
        [book.heightAnchor constraintEqualToAnchor:self.heightAnchor constant:-88 * 2 + 2].active = YES;
        book;
    });
    
    self.weekday = ({
        UILabel *l = [[UILabel alloc] init];
        l.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.book addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.book.topAnchor constant:8].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.book.leftAnchor constant:16].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.book.rightAnchor constant:16].active = YES;
        [l.heightAnchor constraintEqualToConstant:44].active = YES;
        l;
    });
    
    self.weekday.text = @"Monday";
    
    self.name = ({
        UILabel *l = [[UILabel alloc] init];
        l.adjustsFontSizeToFitWidth = YES;
        l.font = [UIFont systemFontOfSize:64 weight:UIFontWeightThin];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.book addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.book.topAnchor constant:44 + 8].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.book.leftAnchor constant:16].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.book.rightAnchor constant:-16].active = YES;
        [l.heightAnchor constraintEqualToConstant:72].active = YES;
        l;
    });
    
    self.name.text = @"History";
    
    self.startEnd = ({
        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        l.userInteractionEnabled = NO;
        l.textLabel.font = l.detailTextLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.book addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.name.bottomAnchor].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.book.leftAnchor].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.book.rightAnchor].active = YES;
        [l.heightAnchor constraintEqualToConstant:44].active = YES;
        l;
    });
    
    self.to = ({
        UILabel *l = [[UILabel alloc] init];
        l.text = @"to";
        l.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        l.textColor = [UIColor colorWithHex:CLThemeGray alpha:1];
        l.textAlignment = NSTextAlignmentCenter;
//        l.backgroundColor = [UIColor orangeColor];
        [self.book addSubview:l];
        l;
    });
    
//    self.startEnd.backgroundColor = [UIColor redColor];
    
    self.startEnd.textLabel.text = @"Start";
    self.startEnd.detailTextLabel.text = @"End";
    
    self.start = [CATextLayer layer];
    self.end   = [CATextLayer layer];
    
    [self.book.layer addSublayer:self.start];
    [self.book.layer addSublayer:self.end];
    
    self.start.wrapped = self.end.wrapped = YES;
    self.start.contentsScale = self.end.contentsScale = [UIScreen mainScreen].scale;
//    self.start.backgroundColor = self.end.backgroundColor = [UIColor orangeColor].CGColor;
    self.end.alignmentMode = kCAAlignmentRight;
    self.start.alignmentMode = kCAAlignmentLeft;
    
    NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:@"09:05 pm"];
    [s setAttributes:@{
                       NSFontAttributeName: [UIFont systemFontOfSize:18 weight:UIFontWeightRegular]
                       }
               range:NSMakeRange(6, 2)];
    [s setAttributes:@{
                       NSFontAttributeName: [UIFont systemFontOfSize:48 weight:UIFontWeightUltraLight]
                       }
               range:NSMakeRange(0, 5)];
    self.start.string = self.end.string = s;
    
    self.teacher = ({
        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        l.textLabel.textColor = [UIColor colorWithHex:CLThemeGray alpha:1];
        l.textLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        l.detailTextLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        l.userInteractionEnabled = NO;
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.book addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.startEnd.bottomAnchor constant:68].active = YES;
        [l.leftAnchor constraintEqualToAnchor:self.book.leftAnchor].active = YES;
        [l.widthAnchor constraintEqualToAnchor:self.book.widthAnchor multiplier:0.5].active = YES;
        [l.heightAnchor constraintEqualToConstant:56].active = YES;
        l;
    });
    
    self.location = ({
        UITableViewCell *l = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        l.textLabel.textColor = [UIColor colorWithHex:CLThemeGray alpha:1];
        l.textLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        l.detailTextLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        l.userInteractionEnabled = NO;
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.book addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.startEnd.bottomAnchor constant:68].active = YES;
        [l.rightAnchor constraintEqualToAnchor:self.book.rightAnchor].active = YES;
        [l.widthAnchor constraintEqualToAnchor:self.book.widthAnchor multiplier:0.5].active = YES;
        [l.heightAnchor constraintEqualToConstant:56].active = YES;
        l;
    });
    
//    self.teacher.backgroundColor = [UIColor purpleColor];
//    self.location.backgroundColor = [UIColor lightGrayColor];
    
    self.teacher.textLabel.text = @"Teacher";
    self.teacher.detailTextLabel.text = @"Craig";
    self.location.textLabel.text = @"Location";
    self.location.detailTextLabel.text = @"Steven Street 57";
    
    self.note = ({
        UITextView *tv = [[UITextView alloc] init];
        tv.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        tv.textContainerInset = UIEdgeInsetsZero;
        tv.textContainer.lineFragmentPadding = 0;
        tv.translatesAutoresizingMaskIntoConstraints = NO;
        [self.book addSubview:tv];
        [tv.topAnchor constraintEqualToAnchor:self.teacher.bottomAnchor constant:8].active = YES;
        [tv.leftAnchor constraintEqualToAnchor:self.book.leftAnchor constant:16].active = YES;
        [tv.rightAnchor constraintEqualToAnchor:self.book.rightAnchor constant:-16].active = YES;
        [tv.bottomAnchor constraintEqualToAnchor:self.book.bottomAnchor constant:-16].active = YES;
        tv;
    });
    
    self.note.text = @"Notes";
    
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
    
    self.action1 = ({
        UIButton *action = actionButton();
        [action.topAnchor constraintEqualToAnchor:self.book.bottomAnchor constant:8].active = YES;
        action;
    });
    
    self.action2 = ({
        UIButton *action = actionButton();
        [action.topAnchor constraintEqualToAnchor:self.action1.bottomAnchor constant:2].active = YES;
        [action.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-8].active = YES;
        action;
    });
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
    
    self.start.frame = CGRectMake(16, 8 + 44 + 72 + 44, self.frame.size.width / 2 - 32, 60);
    self.end.frame   = CGRectMake(self.frame.size.width / 2 + 16, 8 + 44 + 72 + 44, self.frame.size.width / 2 - 32, 60);
    self.to.frame    = CGRectMake(self.frame.size.width / 2 - 16, 8 + 44 + 72 + 44, 32, 60);
    
}

@end
