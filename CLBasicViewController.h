//
//  CLBasicViewController.h
//  CRClass
//
//  Created by caine on 1/5/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#import <UIKit/UIKit.h>
#import "UIFont+MaterialDesignIcons.h"
#import "UIColor+Theme.h"

@interface CLBasicViewController : UIViewController

- (void)dismissSelf;

@end
