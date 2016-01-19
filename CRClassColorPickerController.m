//
//  CRClassColorPickerController.m
//  CRTestingProject
//
//  Created by caine on 1/14/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRClassColorPickerController.h"
#import "UIFont+MaterialDesignIcons.h"

#import "UIColor+Theme.h"

@interface CRClassColorPickerController()<UITableViewDataSource, UITableViewDelegate>

@property( nonatomic, strong ) UINavigationBar *bar;
@property( nonatomic, strong ) UITableView *bear;

@property( nonatomic, strong ) NSArray *colors;

@property( nonatomic, strong ) NSArray<UITableViewCell *> *colorCell;
@property( nonatomic, strong ) NSIndexPath *checkedIndexPath;

@end

@implementation CRClassColorPickerController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.bar = ({
        UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:({
            CGRect rect = self.view.bounds;
            rect.size.height = STATUS_BAR_HEIGHT + 44;
            rect;
        })];
        
        UINavigationItem *item  = [[UINavigationItem alloc] initWithTitle:@"Colors"];
        item.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(dismissSelf)];
        item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:nil
                                                                                action:nil];
        item.leftBarButtonItem.tintColor = [UIColor redColor];
        
        [bar pushNavigationItem:item animated:NO];
        [self.view addSubview:bar];
        
        bar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        bar;
    });
    
    UILabel *(^letIcon)(UIColor *) = ^(UIColor *c){
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        l.font = [UIFont MaterialDesignIconsWithSize:12];
        l.text = [UIFont mdiCheckboxBlankCircle];
        l.textColor = c;
        l.textAlignment = NSTextAlignmentCenter;
        return l;
    };
    
    self.colors     = @[
                            [UIColor colorWithRed:255 / 255.0 green:41  / 255.0 blue:104 / 255.0 alpha:1],
                            [UIColor colorWithRed:255 / 255.0 green:149 / 255.0 blue:0   / 255.0 alpha:1],
                            [UIColor colorWithRed:255 / 255.0 green:204 / 255.0 blue:1   / 255.0 alpha:1],
                            [UIColor colorWithRed:99  / 255.0 green:218 / 255.0 blue:56  / 255.0 alpha:1],
                            [UIColor colorWithRed:27  / 255.0 green:173 / 255.0 blue:248 / 255.0 alpha:1],
                            [UIColor colorWithRed:204 / 255.0 green:115 / 255.0 blue:225 / 255.0 alpha:1],
                            [UIColor colorWithRed:161 / 255.0 green:131 / 255.0 blue:93  / 255.0 alpha:1]
                            ];
    
    NSArray *colornames = @[
                            @"Red", @"Orange", @"Yellow", @"Green", @"Blue", @"Purple", @"Brown"
                            ];
    
    self.checkedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    self.colorCell = ({
        NSMutableArray<UITableViewCell *> *u = [NSMutableArray new];
        for( int i = 0; i < 7; i++ ){
            [u addObject:({
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FUCK"];
                cell.textLabel.text = colornames[i];
                cell.accessoryType  = self.checkedIndexPath.row == i ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
                [cell addSubview:letIcon(self.colors[i])];
                cell;
            })];
        }
        (NSArray *)u;
    });
    
    [self letBear];
}

- (void)letBear{
    self.bear = ({
        UITableView *bear = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.showsHorizontalScrollIndicator = NO;
        bear.showsVerticalScrollIndicator = NO;
        bear.sectionFooterHeight = 0.0f;
        bear.contentInset    = UIEdgeInsetsMake(STATUS_BAR_HEIGHT + 44, 0, 0, 0);
        bear.separatorInset  = UIEdgeInsetsMake(0, 44, 0, 0);
        bear.allowsMultipleSelectionDuringEditing = NO;
        bear.delegate = self;
        bear.dataSource = self;
        bear;
    });
    
    [self.view insertSubview:self.bear belowSubview:self.bar];
    [self.bear.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.bear.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.bear.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.bear.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.colorCell objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ((UITableViewCell *)[tableView cellForRowAtIndexPath:self.checkedIndexPath]).accessoryType = UITableViewCellAccessoryNone;
    ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.checkedIndexPath = indexPath;
    
    self.bar.items.firstObject.rightBarButtonItem.tintColor = self.colors[indexPath.row];
}

- (void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
