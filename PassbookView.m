//
//  PassbookView.m
//  CLClass
//
//  Created by caine on 1/26/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "PassbookView.h"

@interface PassbookView()<UIScrollViewDelegate>

@property( nonatomic, strong ) UIView *book;

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
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    
    self.book = ({
        UIView *book = [[UIView alloc] init];
        book.backgroundColor = [UIColor whiteColor];
        book.layer.cornerRadius = 24.0f;
        book.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:book];
        [book.topAnchor constraintEqualToAnchor:self.topAnchor constant:88].active = YES;
        [book.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [book.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        [book.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-88].active = YES;
        [book.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
        [book.heightAnchor constraintEqualToAnchor:self.heightAnchor constant:-88 * 2 + 2].active = YES;
        book;
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

@end
