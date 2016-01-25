//
//  CRSearchFieldController.h
//  CRTestingProject
//
//  Created by caine on 1/4/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CLBasicViewController.h"

@interface CRSearchFieldController : CLBasicViewController

@property( nonatomic, strong ) void(^valueSelectedHandler)(NSString *type, NSString *value, BOOL newKey);

@property( nonatomic, strong ) UITextField *textField;
@property( nonatomic, strong ) UIButton    *dismissButton;
@property( nonatomic, strong ) NSString    *type;
@property( nonatomic, strong ) NSString    *placeholderString;
@property( nonatomic, strong ) UIColor     *themeColor;

@property( nonatomic, strong ) NSString    *secondHeader;
@property( nonatomic, strong ) NSArray<NSString *> *data;
@property( nonatomic, strong ) NSArray<NSString *> *secondData;

@end
