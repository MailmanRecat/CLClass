//
//  CRClassControlAnimation.m
//  CRTestingProject
//
//  Created by caine on 1/15/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRClassControlAnimation.h"
#import "UIView+CRView.h"

@implementation CRClassControlAnimation

- (instancetype)initFromStyle:(BOOL)present{
    self = [super init];
    if( self ){
        _present = present;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.25f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.present ? [self letPresent:transitionContext] : [self letDismiss:transitionContext];
}

- (void)letPresent:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView   = [transitionContext viewForKey:UITransitionContextToViewKey];
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    UIView *visibleView = [[UIView alloc] initWithFrame:screenBounds];
    [visibleView setClipsToBounds:YES];
    [visibleView addSubview:fromView];
    
    [containerView addSubview:visibleView];
    [containerView addSubview:toView];
    
    CGRect visibleViewFinalRect, fromViewFinalRect, toViewFinalRect;
    
    if( self.Horizontal ){
        
        toView.frame = ({
            CGRect rect = toView.bounds;
            rect.origin.x = rect.size.width;
            rect;
        });
        visibleViewFinalRect = ({
            CGRect rect = visibleView.bounds;
            rect.size.width = 0;
            rect;
        });
        fromViewFinalRect = ({
            CGRect rect = fromView.bounds;
            rect.origin.x = -rect.size.width * 0.382;
            rect;
        });
        
        toViewFinalRect = screenBounds;
        
        [toView letShadowWithPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, toView.frame.size.height)].CGPath
                             size:CGSizeMake(-1, 0)
                          opacity:1
                           radius:4];
        
    }else{
        
        toView.frame = CGRectMake(0, screenBounds.size.height, screenBounds.size.width, screenBounds.size.height);
        
        visibleViewFinalRect = CGRectMake(0, 0, screenBounds.size.width, 0);
        
        fromViewFinalRect = screenBounds;
        toViewFinalRect = screenBounds;
    }
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f options:(7 << 16)
                     animations:^{
                         
                         visibleView.frame = visibleViewFinalRect;
                         
                         fromView.frame = fromViewFinalRect;
                         
                         toView.frame = toViewFinalRect;
                         
                     }completion:^(BOOL f){
                         
                         if( self.Horizontal ){
                             [toView letShadowWithPath:[UIBezierPath bezierPathWithRect:CGRectZero].CGPath
                                                  size:CGSizeZero
                                               opacity:0
                                                radius:0];
                         }
                         
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)letDismiss:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView   = [transitionContext viewForKey:UITransitionContextToViewKey];
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    UIView *visibleView = [[UIView alloc] initWithFrame:screenBounds];
    [visibleView setClipsToBounds:YES];
    [visibleView addSubview:toView];
    
    [containerView addSubview:visibleView];
    [containerView addSubview:fromView];
    
    CGRect visibleViewFinalRect, fromViewFinalRect, toViewFinalRect;
    
    if( self.Horizontal ){
        
        toView.frame = ({
            CGRect rect = toView.bounds;
            rect.origin.x = -rect.size.width * 0.382;
            rect;
        });
        visibleView.frame = ({
            CGRect rect = visibleView.frame;
            rect.size.width = 0;
            rect;
        });
        
        visibleViewFinalRect = screenBounds;
        fromViewFinalRect = ({
            CGRect rect = screenBounds;
            rect.origin.x = rect.size.width;
            rect;
        });
        
        toViewFinalRect = screenBounds;
        
        [fromView letShadowWithPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, toView.frame.size.height)].CGPath
                               size:CGSizeMake(-1, 0)
                            opacity:1
                             radius:4];
    }else{
        
        visibleView.frame = ({
            CGRect rect = screenBounds;
            rect.size.height = 0;
            rect;
        });
        
        visibleViewFinalRect = screenBounds;
        
        fromViewFinalRect = ({
            CGRect rect = screenBounds;
            rect.origin.y = screenBounds.size.height;
            rect;
        });
        
        toViewFinalRect = screenBounds;
    }
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f options:(7 << 16)
                     animations:^{
                         
                         visibleView.frame = visibleViewFinalRect;
                         
                         fromView.frame = fromViewFinalRect;
                         
                         toView.frame = toViewFinalRect;
                         
                     }completion:^(BOOL f){
                         
                         if( self.Horizontal ){
                             [fromView letShadowWithPath:[UIBezierPath bezierPathWithRect:CGRectZero].CGPath
                                                  size:CGSizeZero
                                               opacity:0
                                                radius:0];
                         }
                         
                         [transitionContext completeTransition:YES];
                     }];

}

@end
