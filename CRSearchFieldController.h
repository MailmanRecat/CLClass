//
//  CRSearchFieldController.h
//  CRTestingProject
//
//  Created by caine on 1/4/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CLBasicViewController.h"

@interface CRSearchFieldController : CLBasicViewController

@property( nonatomic, strong ) UITextField *textField;
@property( nonatomic, strong ) UIButton    *dismissButton;
@property( nonatomic, strong ) NSArray<NSString *> *data;

@end
