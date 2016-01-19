//
//  CRApparentDiffView.m
//  CRClassSchedule
//
//  Created by caine on 1/5/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRApparentDiffView.h"
#import "CATextLabel.h"

@interface CRApparentDiffView()

@property( nonatomic, strong ) CATextLayer  *textLabel;
@property( nonatomic, strong ) UIImageView  *photowall;

@end

@implementation CRApparentDiffView

- (instancetype)initWithString:(NSString *)string font:(UIFont *)font photo:(UIImage *)photo{
    self = [super init];
    if( self ){
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        self.photowall = ({
            UIImageView *pw = [[UIImageView alloc] initWithImage:photo];
            pw.contentMode = UIViewContentModeScaleAspectFill;
            pw.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:pw];
            [pw.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
            [pw.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
            [pw.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
            [pw.heightAnchor constraintEqualToAnchor:pw.widthAnchor].active = YES;
            self.photowallLayoutGuide = [pw.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:21];
            self.photowallLayoutGuide.active = YES;
            pw;
        });
        
        self.textLabel = ({
            CATextLayer *tl = [CATextLabel labelFromRect:CGRectMake(56, 32, 200, 56) string:string font:font];
            [self.layer addSublayer:tl];
            tl;
        });
    }
    return self;
}

+ (NSArray *)fetchHeaderViews{
    NSArray *weekdays = @[ @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday" ];

    NSMutableArray *result = [NSMutableArray new];
    
    for( int pizza = 0; pizza < 7; pizza++ ){
        [result addObject:[[CRApparentDiffView alloc] initWithString:weekdays[pizza]
                                                                font:[UIFont systemFontOfSize:25 weight:UIFontWeightRegular]
                                                               photo:[UIImage imageNamed:[NSString stringWithFormat:@"M%d.jpg", pizza + 5]]]];
    }
    
    return (NSArray *)result;
}

@end
