//
//  CLTableViewController.m
//  CLClass
//
//  Created by caine on 1/6/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CLTableViewController.h"
#import "AppDelegate.h"

#import "CRClassAssetManager.h"

//controll
#import "CRClassEditController.h"
#import "CRClassColorPickerController.h"
#import "CRClassAccountControler.h"

//UI
#import "CRClassControlTransition.h"
#import "CRTableViewFunctionalCell.h"
#import "CRTableViewApparentDiffHeaderView.h"

@interface CLTableViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, classEditingDelegate>

@property( nonatomic, strong ) CRClassControlTransition *controlTransitionDelegate;

@property( nonatomic, strong ) CRClassAssetManager *classManager;

@property( nonatomic, strong ) NSLayoutConstraint *statusBarHeightLayoutGuide;

@property( nonatomic, strong ) UINavigationBar *navigationBar;
@property( nonatomic, strong ) UIToolbar   *toolBar;
@property( nonatomic, strong ) UIBarButtonItem *classesItem;
@property( nonatomic, strong ) UITableView *bear;
@property( nonatomic, strong ) UILabel     *classCountLabel;

@property( nonatomic, strong ) NSMutableArray *shouldRelayoutGuide;
@property( nonatomic, strong ) NSMutableArray *visibleHeaderViews;

@property( nonatomic, assign ) BOOL folder;

@property( nonatomic, assign ) BOOL shouldClassInsert;
@property( nonatomic, strong ) NSIndexPath *shouldClassInsertIndexPath;

@end

@implementation CLTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.classManager = [CRClassAssetManager defaultManager];
    
    self.shouldRelayoutGuide = [[NSMutableArray alloc] init];
    self.visibleHeaderViews  = [[NSMutableArray alloc] init];
    self.controlTransitionDelegate = [[CRClassControlTransition alloc] init];
    
    [self doBear];
    
    self.classesItem.title = [NSString stringWithFormat:@"%ld classes", ({
        __block NSUInteger number = 0;
        [self.classManager.classAssets enumerateObjectsUsingBlock:^(NSArray *a, NSUInteger index, BOOL *sS){
            number += a.count;
        }];
        number;
    })];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self layoutHeaderViewPosition];
    
    if( self.shouldClassInsert && self.shouldClassInsertIndexPath ){
        if( self.classManager.classAssets[self.shouldClassInsertIndexPath.section].count == 1 ){
            [self.bear beginUpdates];
            
            [self.bear deleteRowsAtIndexPaths:@[
                                                [NSIndexPath indexPathForRow:0 inSection:self.shouldClassInsertIndexPath.section]
                                                ]
                             withRowAnimation:UITableViewRowAnimationNone];
            [self.bear insertRowsAtIndexPaths:@[
                                                [NSIndexPath indexPathForRow:0 inSection:self.shouldClassInsertIndexPath.section],
                                                [NSIndexPath indexPathForRow:1 inSection:self.shouldClassInsertIndexPath.section],
                                                [NSIndexPath indexPathForRow:2 inSection:self.shouldClassInsertIndexPath.section]
                                                ]
                             withRowAnimation:UITableViewRowAnimationFade];
            
            [self.bear endUpdates];
        }else{
            [self.bear insertRowsAtIndexPaths:@[ self.shouldClassInsertIndexPath ] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        self.shouldClassInsert = self.shouldClassInsertIndexPath = nil;
    }
}

- (void)didAddClassAtIndexPath:(NSIndexPath *)indexPath{
    self.shouldClassInsert = YES;
    self.shouldClassInsertIndexPath = indexPath;
}

- (void)folderBear{
//    self.folder = !self.folder;
//    [self.shouldRelayoutGuide removeAllObjects];
//    
//    [self.bear beginUpdates];
//    [self.bear reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.bear numberOfSections])]
//             withRowAnimation:UITableViewRowAnimationFade];
//    [self.bear endUpdates];
//    
//    [self layoutHeaderViewPosition];
    
    [CRClassDatabase clearAllClassWithUserName:[CRAccountManager defaultManager].currentAccount.type];
    [self.classManager updateClass];
    [self.bear reloadData];
}

- (void)classController{
    CRClassEditController *control = [[CRClassEditController alloc] init];
    control.transitioningDelegate = self.controlTransitionDelegate;
    control.delegate = self;
    
    UIView *selfies = [self.view snapshotViewAfterScreenUpdates:NO];
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate) setEffectBackgroundView:selfies];
    
    [CRClassAssetManager defaultManager].editingAsset = [CRClassAsset defaultAsset];
    [CRClassAssetManager defaultManager].editingAsset.user = [CRAccountManager defaultManager].currentAccount.type;
    
    [self presentViewController:control animated:YES completion:nil];
}

- (void)accountsController{
    CRClassAccountControler *accountController = [[CRClassAccountControler alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:accountController];
    navigationController.transitioningDelegate = self.controlTransitionDelegate;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)doBear{
    UIVisualEffectView *bar = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    bar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bar];
    [bar.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [bar.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [bar.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    self.statusBarHeightLayoutGuide = [bar.heightAnchor constraintEqualToConstant:STATUS_BAR_HEIGHT];
    self.statusBarHeightLayoutGuide.active = YES;
    
    self.bear = ({
        UITableView *bear = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.showsHorizontalScrollIndicator = NO;
        bear.showsVerticalScrollIndicator = NO;
        bear.sectionFooterHeight = 0.0f;
        bear.contentInset = UIEdgeInsetsMake(STATUS_BAR_HEIGHT, 0, STATUS_BAR_HEIGHT + 4, 0);
        bear.backgroundColor = [UIColor clearColor];
        bear.separatorStyle = UITableViewCellSeparatorStyleNone;
        bear.delegate = self;
        bear.dataSource = self;
        
        [self.view insertSubview:bear belowSubview:bar];
        [bear.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
        [bear.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [bear.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [bear.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        
        bear;
    });
    
    self.classesItem = [[UIBarButtonItem alloc] initWithTitle:@"0 classes"
                                                        style:UIBarButtonItemStylePlain
                                                       target:self action:@selector(folderBear)];
    [self.classesItem setTitleTextAttributes:@{
                                               NSFontAttributeName: [UIFont systemFontOfSize:15 weight:UIFontWeightRegular]
                                              }
                                    forState:UIControlStateNormal];
    
    self.toolBar = ({
        UIToolbar *tb = [[UIToolbar alloc] init];
        tb.barStyle = UIBarStyleDefault;
        tb.items = @[
                     [[UIBarButtonItem alloc] initWithTitle:@"Craig" style:UIBarButtonItemStylePlain
                                                     target:self action:@selector(accountsController)],
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                     self.classesItem,
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                   target:self action:@selector(classController)]
                     ];
        tb.tintColor = [UIColor colorWithHex:CLThemeGray alpha:1];
        
        
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
            -fuck / 3.5;
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
    
    if( self.classManager.classAssets[section].count == 0 )
        return 1;
    
    return self.classManager.classAssets[section].count + 2;
}

- (BOOL)isBorder:(NSIndexPath *)indexPath{
    NSUInteger numberOfRow = self.classManager.classAssets[indexPath.section].count;
    return (indexPath.row == 0 || indexPath.row == numberOfRow + 1) && numberOfRow != 0;
}

- (BOOL)isEmptyClassDay:(NSIndexPath *)indexPath{
    return indexPath.row == 0 && self.classManager.classAssets[indexPath.section].count == 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( self.folder )
        return 0.0f;
    else if( [self isBorder:indexPath] )
        return 4.0f;
    else if( [self isEmptyClassDay:indexPath] )
        return 32.0f + 16.0f;
    
    return 56.0f + 16.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 156.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
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

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    [self.visibleHeaderViews  addObject:view];
    [self.shouldRelayoutGuide addObject:((CRTableViewApparentDiffHeaderView *)view).photowallLayoutGuide];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    [self.visibleHeaderViews removeObject:view];
    [self.shouldRelayoutGuide removeObject:((CRTableViewApparentDiffHeaderView *)view).photowallLayoutGuide];
}

- (CRClassAsset *)classAssetFromIndexPath:(NSIndexPath *)indexPath{
    return (CRClassAsset *)self.classManager.classAssets[indexPath.section][indexPath.row - 1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CRTableViewFunctionalCell *functionalCell;
    
    if( [self isBorder:indexPath] ){
        static NSString *const BorderCellID = @"BORDER_CELL_ID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BorderCellID];
        if( cell == nil ){
            cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BorderCellID];
            cell.backgroundColor = [UIColor whiteColor];
            cell.userInteractionEnabled = NO;
        }
        
        return cell;
    }else if( [self isEmptyClassDay:indexPath] ){
        functionalCell = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_NOCLASS];
        if( functionalCell == nil ){
            functionalCell =  [[CRTableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_NOCLASS];
            functionalCell.contaniner.backgroundColor = [UIColor colorWithIndex:CLThemeRedlight];
        }
        
        return functionalCell;
    }
    
    CRClassAsset *ca = [self classAssetFromIndexPath:indexPath];
    
    NSLog(@"%@ %ld", ca, self.classManager.classAssets[indexPath.section].count);
    
    functionalCell = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_CLASS];
    if( functionalCell == nil ){
        functionalCell =  [[CRTableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_CLASS];
    }
    
    functionalCell.classtime.text = ca.start;
    functionalCell.classtime.textColor = [UIColor colorWithIndex:CLThemeRedlight];
//    functionalCell.classname.text = ((CRClassAsset *)self.classManager.classAssets[indexPath.section][indexPath.row]).token;
    functionalCell.classname.text = ca.name;
    functionalCell.classlocation.text = ca.location;
    
    NSLog(@"%@", ca.color);
    functionalCell.classtime.textColor = [UIColor colorWithIndex:[ca.color intValue]];
    functionalCell.contaniner.backgroundColor = functionalCell.classtime.textColor;
    
    return functionalCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self layoutHeaderView:NO];
    
    if( scrollView.contentOffset.y < -STATUS_BAR_HEIGHT ){
        self.statusBarHeightLayoutGuide.constant = fabs(scrollView.contentOffset.y);
    }else if( self.statusBarHeightLayoutGuide.constant != STATUS_BAR_HEIGHT ){
        self.statusBarHeightLayoutGuide.constant = STATUS_BAR_HEIGHT;
    }
    
    [self.view layoutIfNeeded];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
