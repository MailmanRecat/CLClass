//
//  CRClassControlAnimation.h
//  CRTestingProject
//
//  Created by caine on 1/15/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRClassControlAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property( nonatomic, assign ) BOOL Horizontal;
@property( nonatomic, assign, readonly ) BOOL present;

- (instancetype)initFromStyle:(BOOL)present;

@end
