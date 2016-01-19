//
//  CLClassTableViewCell.h
//  CLClass
//
//  Created by caine on 1/6/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CATextLabel.h"

static NSString *const kCLClassCellID = @"K_CL_CLASS_CELL_ID";

@interface CLClassTableViewCell : UITableViewCell

@property( nonatomic, strong ) UILabel *classname;
@property( nonatomic, strong ) CATextLayer *classtime;
@property( nonatomic, strong ) UILabel *classcontent;

- (instancetype)initFromClass;

@end
