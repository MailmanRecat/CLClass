//
//  CRTableViewApparentDiffHeaderView.h
//  CLClass
//
//  Created by caine on 1/22/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const REUSE_TABLEVIEW_APPARENTDIFF_ID = @"REUSE_TABLEVIEW_APPARENTDIFF_ID";

@interface CRTableViewApparentDiffHeaderView : UITableViewHeaderFooterView

@property( nonatomic, strong ) CATextLayer  *titleLabel;
@property( nonatomic, strong ) UIImageView  *photowall;
@property( nonatomic, strong ) NSLayoutConstraint *photowallLayoutGuide;

- (instancetype)initWithTitle:(NSString *)title photo:(UIImage *)photo;

@end
