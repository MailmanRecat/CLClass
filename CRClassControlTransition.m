//
//  CRClassControlTransition.m
//  CRTestingProject
//
//  Created by caine on 1/15/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRClassControlTransition.h"
#import "CRClassControlAnimation.h"

@interface CRClassControlTransition()

@property( nonatomic, strong ) CRClassControlAnimation *presentAnimation;
@property( nonatomic, strong ) CRClassControlAnimation *dismissAnimation;

@end

@implementation CRClassControlTransition

- (void)setHorizontal:(BOOL)Horizontal{
    if( _Horizontal != Horizontal ){
        _Horizontal  = Horizontal;
        
        self.presentAnimation.Horizontal = self.dismissAnimation.Horizontal = Horizontal;
    }
}

- (instancetype)init{
    self = [super init];
    if( self ){
        self.presentAnimation = [[CRClassControlAnimation alloc] initFromStyle:YES];
        self.dismissAnimation = [[CRClassControlAnimation alloc] initFromStyle:NO];
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self.presentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return self.dismissAnimation;
}

@end
