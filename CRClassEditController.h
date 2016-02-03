//
//  CRClassEditController.h
//  CRTestingProject
//
//  Created by caine on 1/13/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CLBasicViewController.h"
#import "CRClassAsset.h"

@protocol classEditingDelegate;

@interface CRClassEditController : CLBasicViewController

@property( nonatomic, weak   ) id<classEditingDelegate> delegate;
@property( nonatomic, strong ) UIColor *themeColor;
@property( nonatomic, strong ) CRClassAsset *classAsset;

@property( nonatomic, strong ) NSIndexPath  *oldIndexPath;

@end

@protocol classEditingDelegate<NSObject>

- (void)classEditing:(CRClassEditController *)controller insertAtIndexPath:(NSIndexPath *)indexPath;
- (void)classEditing:(CRClassEditController *)controller deleteAtIndexPath:(NSIndexPath *)indexPath;
- (void)classEditing:(CRClassEditController *)controller riviseFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end
