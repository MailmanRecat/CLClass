//
//  CLTableViewController.m
//  CLClass
//
//  Created by caine on 1/6/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CLTableViewController.h"

//controll
#import "CRClassEditController.h"

//UI
#import "CRClassControlTransition.h"
#import "CLClassTableViewCell.h"
#import "CRApparentDiffView.h"
#import "CRVisualFloatingButton.h"

@interface CLTableViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property( nonatomic, strong ) CRClassControlTransition *controlTransitionDelegate;

@property( nonatomic, strong ) CRVisualFloatingButton *letClassBtn;
@property( nonatomic, strong ) CRVisualFloatingButton *letAccountBtn;

@property( nonatomic, strong ) UITableView *bear;
@property( nonatomic, strong ) NSArray *headerViews;
@property( nonatomic, strong ) NSArray *headerViewsLayoutGuide;
@property( nonatomic, strong ) NSMutableArray *shouldRelayoutGuide;

@end

@implementation CLTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.controlTransitionDelegate = [[CRClassControlTransition alloc] init];
 
    [self letBear];
    [self letActionBtn];
}

- (void)letClassController{
    CRClassEditController *control = [[CRClassEditController alloc] init];
    control.transitioningDelegate = self.controlTransitionDelegate;
    
    [self presentViewController:control animated:YES completion:nil];
}

- (void)letActionBtn{
    self.letClassBtn = ({
        CRVisualFloatingButton *btn = [[CRVisualFloatingButton alloc] initFromFont:[UIFont MaterialDesignIconsWithSize:25]
                                                                             title:[UIFont mdiPlus]
                                                                   blurEffectStyle:UIBlurEffectStyleExtraLight];
        [btn addTarget:self action:@selector(letClassController) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16].active = YES;
        [btn.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-16].active = YES;
        btn;
    });
    
    self.letAccountBtn = ({
        CRVisualFloatingButton *btn = [[CRVisualFloatingButton alloc] initFromFont:[UIFont MaterialDesignIconsWithSize:24]
                                                                             title:[UIFont mdiAccount]
                                                                   blurEffectStyle:UIBlurEffectStyleExtraLight];
        [self.view addSubview:btn];
        [btn.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16].active = YES;
        [btn.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-88].active = YES;
        btn;
    });
}

- (void)letBear{
    self.bear = ({
        UITableView *bear = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.showsHorizontalScrollIndicator = NO;
        bear.showsVerticalScrollIndicator = NO;
        bear.backgroundColor = [UIColor clearColor];
        bear.separatorStyle = UITableViewCellSeparatorStyleNone;
        bear.delegate = self;
        bear.dataSource = self;
        bear;
    });
    
    [self.view addSubview:self.bear];
    [self.bear.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:STATUS_BAR_HEIGHT].active = YES;
    [self.bear.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.bear.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.bear.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    [self setShouldRelayoutGuide:[NSMutableArray new]];
    [self letBearHeaderViews];
}

- (void)letBearHeaderViews{
    self.headerViews = [CRApparentDiffView fetchHeaderViews];
    __block NSMutableArray *layout = [NSMutableArray new];
    [self.headerViews enumerateObjectsUsingBlock:^(CRApparentDiffView *ad, NSUInteger index, BOOL *sS){
        ad.photowallLayoutGuide.identifier = [NSString stringWithFormat:@"%ld", index];
        [layout addObject:ad.photowallLayoutGuide];
    }];
    self.headerViewsLayoutGuide = (NSArray *)layout;
}

- (void)layoutHeaderView:(BOOL)layoutIfNeed{
    __block UIView *view;
    [self.shouldRelayoutGuide enumerateObjectsUsingBlock:^(NSLayoutConstraint *obj, NSUInteger i, BOOL *sS){
        obj.constant = ({
            view = self.headerViews[[obj.identifier integerValue]];
            CGFloat fuck = view.frame.origin.y - self.view.frame.size.height - self.bear.contentOffset.y;
            -fuck / 4;
        });
    }];
    
    if( layoutIfNeed )
        [self.bear layoutIfNeeded];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 142.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.headerViews objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    [self.shouldRelayoutGuide addObject:self.headerViewsLayoutGuide[section]];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    [self.shouldRelayoutGuide removeObject:self.headerViewsLayoutGuide[section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLClassTableViewCell *hair;
    
    hair = [tableView dequeueReusableCellWithIdentifier:kCLClassCellID];
    if( hair == nil ){
        hair = [[CLClassTableViewCell alloc] initFromClass];
    }
    
//    hair.classname.backgroundColor = [UIColor redColor];
    hair.classname.text = @"Class";
    hair.classtime.string = @"class time";
    hair.classcontent.text = @"content";
    
    return hair;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self layoutHeaderView:NO];
    [self.view layoutIfNeeded];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
