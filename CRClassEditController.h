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

- (void)didAddClassAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths isNewClass:(BOOL)isNewClass;

@end

@interface CRClassEditController : CLBasicViewController

@property( nonatomic, strong ) id<classEditingDelegate> delegate;
@property( nonatomic, strong ) UIColor *themeColor;
@property( nonatomic, strong ) CRClassAsset *classAsset;

@property( nonatomic, strong ) NSIndexPath  *oldIndexPath;

@end
