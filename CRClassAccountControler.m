//
//  CRClassAccountControler.m
//  CLClass
//
//  Created by caine on 1/20/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRClassAccountControler.h"
#import "CRClassAccountCreateController.h"

@interface CRClassAccountControler()<UITableViewDataSource, UITableViewDelegate>

@property( nonatomic, strong ) UITableView *bear;

@end

@implementation CRClassAccountControler

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Accounts"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FUCK"];
    cell.textLabel.text = @"cell";
    cell.textLabel.backgroundColor = [UIColor orangeColor];
    
    return cell;
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
