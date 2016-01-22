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

#import "CRClassDatabase.h"

@interface CRClassAccountControler()<UITableViewDataSource, UITableViewDelegate>

@property( nonatomic, strong ) UITableView *bear;
@property( nonatomic, strong ) NSArray     *accounts;

@end

@implementation CRClassAccountControler

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Accounts"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHex:CLThemeRedlight alpha:1]];
    
    self.accounts = [CRClassDatabase selectAllAccounts];
    
    [self doBear];
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
        return self.accounts.count;
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
        
        functionalCell.accountName = ((CRAccountAsset *)self.accounts[indexPath.row]).name;
        
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
    
    if( indexPath.row == 0 && indexPath.section == 0 ){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:[CRClassAccountCreateController new] animated:YES];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
