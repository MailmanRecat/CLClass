//
//  CRClassAccountCreateControllerViewController.m
//  CLClass
//
//  Created by caine on 1/21/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRClassAccountCreateController.h"
#import "UITableViewFunctionalCell.h"
#import "CRAccountManager.h"

@interface CRClassAccountCreateController()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property( nonatomic, strong ) UITableView *bear;
@property( nonatomic, strong ) UITableViewFunctionalCell *textFieldCell;
@property( nonatomic, strong ) UITableViewFunctionalCell *colorCell;
@property( nonatomic, strong ) UITableViewFunctionalCell *createButton;

@end

@implementation CRClassAccountCreateController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"New Account"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self doBear];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.textFieldCell.textField becomeFirstResponder];
}

- (void)doBear{
    self.textFieldCell = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_TEXTFIELD];
    self.textFieldCell.textField.placeholder = @"User name";
    self.textFieldCell.textField.delegate    = self;
    self.textFieldCell.textField.tintColor   = [UIColor colorWithHex:CLThemeRedlight alpha:1];
    self.textFieldCell.backgroundColor = [UIColor whiteColor];
    
    [self.textFieldCell.textField addTarget:self action:@selector(onTextFieldEdting) forControlEvents:UIControlEventAllEditingEvents];
    
    self.colorCell     = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_COLOR];
    self.colorCell.backgroundColor = [UIColor whiteColor];
    self.colorCell.textLabel.text  = @"Color";
    self.colorCell.textLabel.font  = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    self.colorCell.textLabel.textColor = [UIColor blackColor];
    self.colorCell.selectedBackgroundView = nil;
    self.colorCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.createButton  = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_BUTTON];
    self.createButton.backgroundColor = [UIColor whiteColor];
    self.createButton.textLabel.textAlignment = NSTextAlignmentLeft;
    self.createButton.textLabel.text = @"Create";
    self.createButton.textLabel.textColor = [UIColor colorWithHex:CLThemeRedlight alpha:1];
    self.createButton.selectedBackgroundView = nil;
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.row == 0 && indexPath.section == 0 )
        return self.textFieldCell;
    if( indexPath.row == 1 && indexPath.section == 0 )
        return self.colorCell;
    if( indexPath.row == 0 && indexPath.section == 1 ){
        if( [self.textFieldCell.textField.text isEqualToString:@""] )
            self.createButton.textLabel.textColor = [UIColor colorWithHex:CLThemeRedlight alpha:0.6];
        else
            self.createButton.textLabel.textColor = [UIColor colorWithHex:CLThemeRedlight alpha:1];
        
        return self.createButton;
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if( [self.textFieldCell.textField.text isEqualToString:@""] == NO && indexPath.section == 1 ){
        CRAccountAsset *asset = [CRAccountAsset defaultAsset];
        asset.name  = self.textFieldCell.textField.text;
        
        [[CRAccountManager defaultManager] addUser:asset];
        [self.navigationController popViewControllerAnimated:YES];
        
        if( self.delegate && [self.delegate respondsToSelector:@selector(didCreateAccount:)] ){
            [self.delegate didCreateAccount:asset.name];
        }
    }
}

- (void)onTextFieldEdting{
    [self.bear reloadRowsAtIndexPaths:@[
                                        [NSIndexPath indexPathForRow:0 inSection:1]
                                        ]
                     withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
