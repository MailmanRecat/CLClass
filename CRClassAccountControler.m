//
//  CRClassAccountControler.m
//  CLClass
//
//  Created by caine on 1/20/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRClassAccountControler.h"
#import "CRClassAccountCreateController.h"
#import "CRTableViewFunctionalCell.h"


@interface CRClassAccountControler()<UITableViewDataSource, UITableViewDelegate, CRClassAccountCreateDeleagte>

@property( nonatomic, strong ) UITableView *bear;

@property( nonatomic, strong ) CRAccountManager *accountManager;
@property( nonatomic, strong ) NSIndexPath *currentAInP;
@property( nonatomic, assign ) BOOL shouldReloadAccount;

@end

@implementation CRClassAccountControler

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Accounts"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHex:CLThemeRedlight alpha:1]];
    
    self.accountManager = [CRAccountManager defaultManager];
    
    [self doBear];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if( self.shouldReloadAccount ){
        
        [self.bear cellForRowAtIndexPath:self.currentAInP].accessoryType = UITableViewCellAccessoryNone;
        
        [self.bear insertRowsAtIndexPaths:@[
                                            [NSIndexPath indexPathForRow:self.accountManager.accounts.count - 1 inSection:0]
                                            ]
                         withRowAnimation:UITableViewRowAnimationTop];
        
        self.shouldReloadAccount = NO;
    }
}

- (void)doBear{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(dismissSelf)];
    self.navigationItem.rightBarButtonItem.tintColor  = [UIColor colorWithHex:CLThemeRedlight alpha:1];
    
    
    self.bear = ({
        UITableView *bear = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.showsHorizontalScrollIndicator = NO;
        bear.showsVerticalScrollIndicator = NO;
        bear.sectionFooterHeight = 0.0f;
        bear.sectionHeaderHeight = 36.0f;
        bear.allowsMultipleSelectionDuringEditing = NO;
        bear.delegate = self;
        bear.dataSource = self;
        bear;
    });
    
    [self.view addSubview:self.bear];
    [self.bear.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.bear.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.bear.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.bear.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if( section == 0 )
        return self.accountManager.accounts.count + 1;
    if( section == 1 )
        return 1;
    if( section == 2 )
        return 1;
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.section == 0 )
        return 56.0f;
    
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if( section == 1 )
        return 56.0f;
        
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if( section != 1 ) return [UIView new];
    
    UITableViewHeaderFooterView *info = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"APP_INFO"];
    if( info == nil ){
        info =  [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"APP_INFO"];
        info.textLabel.text = @"Version 9.1 \nAuthor: mailman";
    }
    
    return info;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CRTableViewFunctionalCell *functionalCell;
    
    if( indexPath.section == 0 ){
        functionalCell = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_ACCOUNT];
        if( functionalCell == nil ){
            functionalCell =  [[CRTableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_ACCOUNT];
        }
        
        if( indexPath.row == self.accountManager.accounts.count ){
            functionalCell.accountName = @"Add account";
            functionalCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return functionalCell;
        }
        
        functionalCell.accountName = ((CRAccountAsset *)self.accountManager.accounts[indexPath.row]).name;
        
        if( [((CRAccountAsset *)self.accountManager.accounts[indexPath.row]).token isEqualToString:CRAccountCurrentToken] ){
            self.currentAInP = indexPath;
            functionalCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            functionalCell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return functionalCell;
    }
    if( indexPath.section == 1 ){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FEEDBACK"];
        if( cell == nil ){
            cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FEEDBACK"];
            
            cell.textLabel.text = @"Feedback";
        }
        
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if( indexPath.section == 0 ){
        
        if( indexPath.row == self.accountManager.accounts.count ){
            CRClassAccountCreateController *ca = [[CRClassAccountCreateController alloc] init];
            ca.delegate = self;
            [self.navigationController pushViewController:ca animated:YES];
        }else if( indexPath.row != self.currentAInP.row ){
            
            [tableView cellForRowAtIndexPath:self.currentAInP].accessoryType = UITableViewCellAccessoryNone;
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
            
            [self.accountManager changeUser:self.accountManager.accounts[indexPath.row]];
            
            self.currentAInP = indexPath;
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.section == 0 ){
        if( indexPath.row == self.accountManager.accounts.count || indexPath.row == self.currentAInP.row )
            return NO;
        
        return YES;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(NSIndexPath *)indexPath{
    if( editingStyle == UITableViewCellEditingStyleDelete ){
        [self.accountManager removeUser:[self.accountManager.accounts objectAtIndex:indexPath.row]];
        
        [self.bear deleteRowsAtIndexPaths:@[
                                            indexPath
                                            ]
                         withRowAnimation:UITableViewRowAnimationBottom];
        self.currentAInP = [NSIndexPath indexPathForRow:[self.accountManager.accounts indexOfObject:self.accountManager.currentAccount] inSection:0];
    }
}

- (void)didCreateAccount:(NSString *)name{
    self.shouldReloadAccount = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
