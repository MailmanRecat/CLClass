//
//  CRTableView.h
//  CLClass
//
//  Created by caine on 2/3/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRTableViewApparentDiffHeaderView.h"

@interface CRTableView : UITableView

@property( nonatomic, strong ) NSMutableArray *shouldRelayoutGuide;
@property( nonatomic, strong ) NSMutableArray *visibleHeaderViews;

- (void)layoutHeaderViewPosition;
- (void)layoutHeaderView:(BOOL)layoutIfNeed;

@end
