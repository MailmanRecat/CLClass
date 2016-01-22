//
//  CRTableViewFunctionalCell.h
//  CLClass
//
//  Created by caine on 1/22/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const REUSE_FUNCTIONAL_CELL_ID_ACCOUNT = @"UITABLEVIEW_REUSE_FUNCTIONAL_CELL_ID_ACCOUNT";
static NSString *const REUSE_FUNCTIONAL_CELL_ID_CLASS   = @"UITABLEVIEW_REUSE_FUNCTIONAL_CELL_ID_CLASS";

@interface CRTableViewFunctionalCell : UITableViewCell

@property( nonatomic, strong ) NSString *accountName;

@property( nonatomic, strong ) UILabel  *classtime;
@property( nonatomic, strong ) UILabel  *classname;
@property( nonatomic, strong ) UILabel  *classlocation;

- (instancetype)initWithReuseString:(NSString *)RString;

@end