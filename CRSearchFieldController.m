//
//  CRSearchFieldController.m
//  CRTestingProject
//
//  Created by caine on 1/4/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRSearchFieldController.h"
#import "UIView+CRView.h"
#import "UIColor+Theme.h"
#import "Craig.h"

@interface CRSearchFieldController()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property( nonatomic, strong ) UITableView *bear;

@property( nonatomic, strong ) CAShapeLayer *visualBorder;
@end

@implementation CRSearchFieldController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.secondHeader = @"COURES NAME";
    
    self.secondData   = @[
                          @"math",
                          @"history"
                          ];
    
    UIVibrancyEffect   *effect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    UIVisualEffectView *visual = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    visual.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
    visual.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:visual];
    
    CAShapeLayer *border = [CAShapeLayer layer];
    border.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4].CGColor;
    [self.view.layer addSublayer:border];
    
    self.visualBorder = border;
    
    [self letBear];
    [self letSearchField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DidKeyBoardChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)DidKeyBoardChangeFrame:(NSNotification *)keyboardInfo{
    NSDictionary *info = [keyboardInfo userInfo];
    CGFloat constant = self.view.frame.size.height - [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    if( self.bear.superview == self.view ){
        self.bear.contentInset = UIEdgeInsetsMake(0, 0, constant + 8, 0);
    }
}

- (void)viewWillLayoutSubviews{
    self.visualBorder.frame = CGRectMake(0, 63.5, self.view.frame.size.width, 0.5);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)letSearchField{
    
    CGFloat height = 28;
    
    self.dismissButton = ({
        UIButton *dismiss = [[UIButton alloc] initWithFrame:CGRectMake(375 - 72, STATUS_BAR_HEIGHT + 8, 72, height)];
        dismiss.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        dismiss.layer.cornerRadius = 32 / 2;
        [self.view addSubview:dismiss];
        [dismiss setTitleColor:[self.themeColor colorWithAlphaComponent:1] forState:UIControlStateNormal];
        [dismiss setTitleColor:[self.themeColor colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
        [dismiss setTitle:@"Cancel" forState:UIControlStateNormal];
        [dismiss addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        dismiss;
    });
    
    self.textField = ({
        UITextField *tf = [[UITextField alloc] init];
        tf.layer.cornerRadius = 4.0f;
        tf.keyboardAppearance = UIKeyboardAppearanceDark;
        tf.returnKeyType = UIReturnKeyDone;
        tf.enablesReturnKeyAutomatically = YES;
        tf.delegate = self;
        tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholderString
                                                                   attributes:@{
                                                                                NSForegroundColorAttributeName: [UIColor colorWithWhite:1 alpha:0.8]
                                                                                }];
        tf.textColor = [UIColor whiteColor];
        tf.tintColor = [UIColor whiteColor];
        tf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        tf.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:tf];
        [tf.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:STATUS_BAR_HEIGHT + 8].active = YES;
        [tf.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:8].active = YES;
        [tf.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-72].active = YES;
        [tf.heightAnchor constraintEqualToConstant:28].active = YES;
        tf;
    });
    
    [self.textField addTarget:self action:@selector(onEditing) forControlEvents:UIControlEventAllEditingEvents];
}

- (void)letBear{
    
    self.bear = ({
        UITableView *bear = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.showsHorizontalScrollIndicator = NO;
        bear.showsVerticalScrollIndicator = NO;
        bear.sectionFooterHeight = 0.0f;
        bear.sectionHeaderHeight = 44.0f;
        bear.separatorColor  = [UIColor colorWithWhite:1 alpha:0.4];
        bear.backgroundColor = [UIColor clearColor];
        bear.allowsMultipleSelectionDuringEditing = NO;
        bear.delegate = self;
        bear.dataSource = self;
        bear;
    });
    
    [self.view addSubview:self.bear];
    [self.bear.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:STATUS_BAR_HEIGHT + 44].active = YES;
    [self.bear.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.bear.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.bear.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.secondData ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? self.data.count : self.secondData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HFUCK"];
    if( header == nil ){
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"HFUCK"];
        header.backgroundView = [UIView new];
        header.contentView.backgroundColor = [UIColor clearColor];
        header.textLabel.text = @"RECENTS";
        header.textLabel.textColor = [UIColor whiteColor];
    }
    
    if( section == 0 )
        header.textLabel.text = @"RECENTS";
    else
        header.textLabel.text = self.secondHeader;
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *hair = [tableView dequeueReusableCellWithIdentifier:@"CFUCK"];
    if( hair == nil ){
        hair = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CFUCK"];
        hair.backgroundColor = [UIColor clearColor];
        hair.selectedBackgroundView = [Craig tableViewSelectedBackgroundEffectView:UIBlurEffectStyleDark];
        hair.textLabel.textColor = [UIColor whiteColor];
    }
    
    if( indexPath.section == 0 )
        hair.textLabel.text = self.data[indexPath.row];
    
    else if( indexPath.section == 1 )
        hair.textLabel.text = self.secondData[indexPath.row];
    
    return hair;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.section == 0 ){
        
        [self dismissViewControllerAnimated:YES completion:^{
            if( self.valueSelectedHandler ){
                self.valueSelectedHandler( self.type, self.data[indexPath.row], NO );
            }
        }];
        
    }else if( indexPath.section == 1 ){
        
        [self dismissViewControllerAnimated:YES completion:^{
            if( self.valueSelectedHandler ){
                self.valueSelectedHandler( self.type, self.secondData[indexPath.row], NO );
            }
        }];
        
    }
}

- (void)onEditing{
    if( [self.textField.text isEqualToString:@""] )
        [self.dismissButton setTitle:@"Cancel" forState:UIControlStateNormal];
    else
        [self.dismissButton setTitle:@"Done" forState:UIControlStateNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self dismissSelf];
    
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)dismissSelf{
    [self.view endEditing:YES];
    
    if( self.valueSelectedHandler && [self.dismissButton.titleLabel.text isEqualToString:@"Done"] ){
        self.valueSelectedHandler( self.type, self.textField.text, YES );
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
