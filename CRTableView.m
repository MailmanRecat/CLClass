//
//  CRTableView.m
//  CLClass
//
//  Created by caine on 2/3/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRTableView.h"

@implementation CRTableView

- (instancetype)init{
    self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if( self ){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.sectionFooterHeight = 0.0f;
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.shouldRelayoutGuide = [NSMutableArray new];
        self.visibleHeaderViews  = [NSMutableArray new];
    }
    return self;
}

- (void)layoutHeaderViewPosition{
    [self.visibleHeaderViews enumerateObjectsUsingBlock:^(CRTableViewApparentDiffHeaderView *hv, NSUInteger ind, BOOL *sS){
        [self.shouldRelayoutGuide addObject:hv.photowallLayoutGuide];
    }];
    
    [self layoutHeaderView:YES];
}

- (void)layoutHeaderView:(BOOL)layoutIfNeed{
    __block UIView *view;
    [self.shouldRelayoutGuide enumerateObjectsUsingBlock:^(NSLayoutConstraint *obj, NSUInteger i, BOOL *sS){
        obj.constant = ({
            view = ((UIView *)obj.firstItem).superview.superview;
            CGFloat fuck = view.frame.origin.y - [UIScreen mainScreen].bounds.size.height - self.contentOffset.y;
            -fuck / 3.5;
        });
    }];
    
    if( layoutIfNeed )
        [self layoutIfNeeded];
}

@end
