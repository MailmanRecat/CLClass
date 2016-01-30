//
//  CRClassEditController.h
//  CRTestingProject
//
//  Created by caine on 1/13/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CLBasicViewController.h"
#import "CRClassAsset.h"

@protocol classEditingDelegate<NSObject>

- (void)didInsertClassAtIndexPath:(NSIndexPath *)indexPath;
- (void)didDeleteClassAtIndexPath:(NSIndexPath *)indexPath;
- (void)didRiviseClassFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end

@interface CRClassEditController : CLBasicViewController

@property( nonatomic, weak   ) id<classEditingDelegate> delegate;
@property( nonatomic, strong ) UIColor *themeColor;
@property( nonatomic, strong ) CRClassAsset *classAsset;

@property( nonatomic, strong ) NSIndexPath  *oldIndexPath;

@end
