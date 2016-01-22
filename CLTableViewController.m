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
#import "CRClassColorPickerController.h"
#import "CRClassAccountControler.h"

//UI
#import "CRClassControlTransition.h"
#import "CRTableViewFunctionalCell.h"
#import "CRTableViewApparentDiffHeaderView.h"

@interface CLTableViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property( nonatomic, strong ) CRClassControlTransition *controlTransitionDelegate;

@property( nonatomic, strong ) UIToolbar   *toolBar;
@property( nonatomic, strong ) UITableView *bear;
@property( nonatomic, strong ) UILabel     *classCountLabel;

@property( nonatomic, strong ) NSMutableArray *shouldRelayoutGuide;
@property( nonatomic, strong ) NSMutableArray *visibleHeaderViews;

@property( nonatomic, assign ) BOOL folder;

@end

@implementation CLTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.shouldRelayoutGuide = [[NSMutableArray alloc] init];
    self.visibleHeaderViews  = [[NSMutableArray alloc] init];
    self.controlTransitionDelegate = [[CRClassControlTransition alloc] init];
    
    [self doBear];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self layoutHeaderViewPosition];
}

- (void)folderBear{
    self.folder = !self.folder;
    [self.shouldRelayoutGuide removeAllObjects];
    
    [self.bear beginUpdates];
    [self.bear reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.bear numberOfSections])]
             withRowAnimation:UITableViewRowAnimationFade];
    [self.bear endUpdates];
    
    [self layoutHeaderViewPosition];
}

- (void)classController{
    CRClassEditController *control = [[CRClassEditController alloc] init];
    control.transitioningDelegate = self.controlTransitionDelegate;
    
    [self presentViewController:control animated:YES completion:nil];
}

- (void)accountsController{
    CRClassAccountControler *accountController = [[CRClassAccountControler alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:accountController];
    navigationController.transitioningDelegate = self.controlTransitionDelegate;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)doBear{
    self.bear = ({
        UITableView *bear = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.showsHorizontalScrollIndicator = NO;
        bear.showsVerticalScrollIndicator = NO;
        bear.sectionFooterHeight = 0.0f;
        bear.contentInset = UIEdgeInsetsMake(0, 0, 44 + STATUS_BAR_HEIGHT, 0);
        bear.backgroundColor = [UIColor clearColor];
        bear.separatorStyle = UITableViewCellSeparatorStyleNone;
        bear.delegate = self;
        bear.dataSource = self;
        
        [self.view addSubview:bear];
        [bear.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:STATUS_BAR_HEIGHT].active = YES;
        [bear.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [bear.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [bear.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:STATUS_BAR_HEIGHT].active = YES;
        
        bear;
    });
    
    self.toolBar = ({
        UIToolbar *tb = [[UIToolbar alloc] init];
        tb.barStyle = UIBarStyleBlackTranslucent;
        tb.items = @[
                     [[UIBarButtonItem alloc] initWithTitle:@"Craig" style:UIBarButtonItemStylePlain
                                                     target:self action:@selector(accountsController)],
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                   target:self action:@selector(classController)],
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                                   target:self action:@selector(folderBear)]
                     ];
        tb.tintColor = [UIColor colorWithIndex:CLThemeRedlight alpha:1];
        
        [self.view addSubview:tb];
        [tb setTranslatesAutoresizingMaskIntoConstraints:NO];
        [tb.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        [tb.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [tb.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [tb.heightAnchor constraintEqualToConstant:44].active = YES;
        
        tb;
    });
}

- (void)layoutHeaderViewPosition{
    [self.visibleHeaderViews enumerateObjectsUsingBlock:^(CRTableViewApparentDiffHeaderView *hv, NSUInteger ind, BOOL *sS){
        [self.shouldRelayoutGuide addObject:hv.photowallLayoutGuide];
    }];
    
    [self layoutHeaderView:YES];
}

- (void)layoutHeaderView:(BOOL)layoutIfNeed{
    __block UIView *view;
    [self.shouldRelayoutGuide enumerateObjectsUsingBlock:^(NSLayoutConstraint *obj, NSUInteger i, BOOL *sS){
        obj.constant = ({
            view = ((UIView *)obj.firstItem).superview.superview;
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
    if( self.folder )
        return 0;
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( self.folder )
        return 0.0f;
    
    return 56.0f + 16.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.view.frame.size.height * 0.24;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if( section == 6 )
        return 44.0f;
    
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *weekdays = @[ @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday" ];
    CRTableViewApparentDiffHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:REUSE_TABLEVIEW_APPARENTDIFF_ID];
    if( header == nil ){
        header =  [[CRTableViewApparentDiffHeaderView alloc] initWithTitle:@"Spaceflexday" photo:nil];
    }
    
    header.photowallLayoutGuide.identifier = [NSString stringWithFormat:@"%ld", section];
    header.titleLabel.string = weekdays[section];
    header.photowall.image   = [UIImage imageNamed:[NSString stringWithFormat:@"M%ld.jpg", section + 5]];

    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if( section == 6 ){
        if( self.classCountLabel == nil ){
            self.classCountLabel = [[UILabel alloc] init];
            self.classCountLabel.textAlignment = NSTextAlignmentCenter;
            self.classCountLabel.textColor = [UIColor whiteColor];
            self.classCountLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        }
        
        self.classCountLabel.text = @"57 classes";
        
        return self.classCountLabel;
    }
    
    UITableViewHeaderFooterView *fuck = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FUCK"];
    if( fuck == nil ){
       fuck = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"FUCK"];
    }
    
    return fuck;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    [self.visibleHeaderViews  addObject:view];
    [self.shouldRelayoutGuide addObject:((CRTableViewApparentDiffHeaderView *)view).photowallLayoutGuide];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    [self.visibleHeaderViews removeObject:view];
    [self.shouldRelayoutGuide removeObject:((CRTableViewApparentDiffHeaderView *)view).photowallLayoutGuide];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CRTableViewFunctionalCell *functionalCell;
    
    functionalCell = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_CLASS];
    if( functionalCell == nil ){
        functionalCell =  [[CRTableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_CLASS];
    }
    
    functionalCell.classtime.text = @"09:40 PM";
    functionalCell.classname.text = @"English";
    functionalCell.classlocation.text = @"Unknow";
    
    functionalCell.classtime.textColor =
    functionalCell.classname.textColor =
    functionalCell.classlocation.textColor = [UIColor colorWithHex:CLThemeRedlight alpha:1];
    
    return functionalCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select");
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
