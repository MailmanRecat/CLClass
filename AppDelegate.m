//
//  AppDelegate.m
//  CLClass
//
//  Created by caine on 1/5/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "AppDelegate.h"
#import "CLTableViewController.h"

@interface AppDelegate ()

@property( nonatomic, strong ) UIImageView *photowall;
@property( nonatomic, strong ) UIView      *effectBackground;
@property( nonatomic, strong ) UIVisualEffectView *backgroundEffect;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = ({
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window;
    });
    
    [self letApplicationBackground];
    
    [self.window setRootViewController:[[CLTableViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setEffectBackgroundView:(UIView *)view{
    [self.effectBackground removeFromSuperview];
    [self setEffectBackground:view];
    [self.window insertSubview:self.effectBackground atIndex:0];
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view.widthAnchor constraintEqualToAnchor:self.window.widthAnchor].active = YES;
    [view.heightAnchor constraintEqualToAnchor:self.window.heightAnchor].active = YES;
    [view.centerXAnchor constraintEqualToAnchor:self.window.centerXAnchor].active = YES;
    [view.centerYAnchor constraintEqualToAnchor:self.window.centerYAnchor].active = YES;
}

- (void)letApplicationBackground{
    void (^letLayout)(UIView *, UIView *) = ^(UIView *layoutView, UIView *superview){
        [layoutView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [superview addSubview:layoutView];
        [layoutView.widthAnchor constraintEqualToAnchor:superview.widthAnchor].active = YES;
        [layoutView.heightAnchor constraintEqualToAnchor:superview.heightAnchor].active = YES;
        [layoutView.centerXAnchor constraintEqualToAnchor:superview.centerXAnchor].active = YES;
        [layoutView.centerYAnchor constraintEqualToAnchor:superview.centerYAnchor].active = YES;
    };
    
//    self.photowall = ({
//        UIImageView *photowall = [[UIImageView alloc] init];
//        photowall.image = [UIImage imageNamed:@"Sky.jpg"];
//        letLayout(photowall, self.window);
//        photowall;
//    });
    
    self.backgroundEffect = ({
        UIVisualEffectView *visual = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        letLayout(visual, self.window);
        visual;
    });
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
