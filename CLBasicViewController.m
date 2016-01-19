//
//  CLBasicViewController.m
//  CRClass
//
//  Created by caine on 1/5/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CLBasicViewController.h"

@interface CLBasicViewController()

@end

@implementation CLBasicViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self letEffect];
}

- (void)letEffect{
    self.backgroundEffect = ({
        UIVisualEffectView *effect = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        [self.view addSubview:effect];
        [effect setTranslatesAutoresizingMaskIntoConstraints:NO];
        [effect.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
        [effect.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [effect.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [effect.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        effect;
    });
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
