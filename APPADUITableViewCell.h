//
//  APPADUITableViewCell.h
//  FontPreview
//
//  Created by caine on 1/24/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const APP_AD_TABLEVIEW_CELL_IDENT = @"APP_AD_TABLEVIEW_CELL_IDENT";

@interface APPADUITableViewCell : UITableViewCell

@property( nonatomic, strong ) UISwitch *switchControl;

- (instancetype)initWithReuseString:(NSString *)RString;

@end
