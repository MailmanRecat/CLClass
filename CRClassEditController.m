//
//  CRClassEditController.m
//  CRTestingProject
//
//  Created by caine on 1/13/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRClassEditController.h"
#import "UITableViewFunctionalCell.h"
#import "UIColor+Theme.h"

#import "CRClassColorPickerController.h"
#import "CRSearchFieldController.h"
#import "CRClassControlTransition.h"
#import "Craig.h"

@interface CRClassEditController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>

@property( nonatomic, strong ) CRClassControlTransition *customTransitionDetegate;

@property( nonatomic, strong ) UILabel *barTitle;
@property( nonatomic, strong ) UIButton *dismissBtn;
@property( nonatomic, strong ) UIButton *editBtn;

@property( nonatomic, strong ) UITableView *bear;
@property( nonatomic, strong ) UISegmentedControl *segmentedControl;

@property( nonatomic, strong ) NSArray *section0String;
@property( nonatomic, strong ) NSArray *section1String;

@property( nonatomic, assign ) CGFloat textViewHeight;

@property( nonatomic, strong ) NSArray *hoursStirng;
@property( nonatomic, strong ) NSArray *minusString;

@property( nonatomic, strong ) NSString *startsTime;
@property( nonatomic, strong ) NSString *endsTime;

@property( nonatomic, assign ) BOOL    startsEditing;
@property( nonatomic, assign ) BOOL    endsEditing;

@property( nonatomic, assign ) BOOL    classEditable;

@property( nonatomic, strong ) NSMutableDictionary *headerCache;

@property( nonatomic, assign ) NSUInteger section0RowCount;
@property( nonatomic, assign ) NSUInteger section1RowCount;
@end

@implementation CRClassEditController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.customTransitionDetegate = [[CRClassControlTransition alloc] init];
    self.title = @"Class";
    self.classAsset = [CRClassAsset defaultAsset];
    
    self.startsTime = self.endsTime = @"07:10 AM";
    
    self.textViewHeight = 128.0f;
    
    self.section0String = @[ @"Course name", @"Location" ];
    self.section1String = @[ @"Teacher", @"Class starts", @"", @"Class ends", @"", @"Color" ];
    
    self.hoursStirng    = @[
                            @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12"
                            ];
    
    self.minusString    = @[
                            @"05", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55"
                            ];
    
    self.section0RowCount = self.section0String.count;
    self.section1RowCount = self.section1String.count;
    
    self.headerCache = [[NSMutableDictionary alloc] init];
    
    self.view.tintColor = [UIColor colorWithHex:CLThemeRedlight alpha:1];
    
    [self letHeader];
    [self letBear];
    
    [self letObserver];
}

- (void)letClassEditing{
    self.classEditable = !self.classEditable;
}

- (void)setClassEditable:(BOOL)classEditable{
    if( classEditable == _classEditable ) return;
    _classEditable = classEditable;
    
    if( classEditable ){
        [self.editBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.dismissBtn setTitle:@"Save" forState:UIControlStateNormal];
        [self.segmentedControl setUserInteractionEnabled:YES];
    }else{
        [self.editBtn setTitle:@"Edit" forState:UIControlStateNormal];
        [self.dismissBtn setTitle:@"Done" forState:UIControlStateNormal];
        [self.segmentedControl setUserInteractionEnabled:NO];
        
        if( self.startsEditing || self.endsEditing ){
            self.startsEditing = self.endsEditing = NO;
            [self.bear reloadRowsAtIndexPaths:@[
                                                [NSIndexPath indexPathForRow:2 inSection:1],
                                                [NSIndexPath indexPathForRow:4 inSection:1]
                                                ] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    }
    
    [self.bear reloadRowsAtIndexPaths:@[
                                        [NSIndexPath indexPathForRow:0 inSection:0],
                                        [NSIndexPath indexPathForRow:1 inSection:0],
                                        
                                        [NSIndexPath indexPathForRow:0 inSection:1],
                                        [NSIndexPath indexPathForRow:1 inSection:1],
                                        [NSIndexPath indexPathForRow:3 inSection:1],
                                        [NSIndexPath indexPathForRow:5 inSection:1],
                                        ] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)setThemeColor:(UIColor *)themeColor{
    _themeColor = themeColor;
}

- (void)DidKeyBoardChangeFrame:(NSNotification *)keyboardInfo{
    NSDictionary *info = [keyboardInfo userInfo];
    CGFloat constant = self.view.frame.size.height - [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    NSIndexPath *ti = [NSIndexPath indexPathForRow:0 inSection:2];
    if( [((UITableViewFunctionalCell *)[self.bear cellForRowAtIndexPath:ti]).textView isFirstResponder] ){
        
    }else{
        self.bear.scrollEnabled = NO;
    }
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f options:(7 << 16)
                     animations:^{
                         self.bear.contentInset = ({
                             UIEdgeInsets is = self.bear.contentInset;
                             is.bottom       = constant + 8;
                             is;
                         });
                     }completion:^(BOOL f){
                         self.bear.scrollEnabled = YES;
                         if( [((UITableViewFunctionalCell *)[self.bear cellForRowAtIndexPath:ti]).textView isFirstResponder] ){
                             [self.bear scrollToRowAtIndexPath:ti atScrollPosition:UITableViewScrollPositionTop animated:YES];
                         }
                     }];
}

- (void)letHeader{
    self.barTitle = ({
        UILabel *l = [[UILabel alloc] init];
        l.text = self.title;
        l.textColor = [UIColor whiteColor];
        l.textAlignment = NSTextAlignmentCenter;
        l.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:l];
        [l.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:STATUS_BAR_HEIGHT].active = YES;
//        [l.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:-148].active = YES;
        [l.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        [l.heightAnchor constraintEqualToConstant:44].active = YES;
        l;
    });
    
    self.dismissBtn = ({
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"Done" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:CLThemeBluelight alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:CLThemeBluelight alpha:0.4] forState:UIControlStateHighlighted];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular]];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addSubview:btn];
        [btn.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:STATUS_BAR_HEIGHT].active = YES;
        [btn.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-8].active = YES;
        [btn.widthAnchor constraintEqualToConstant:64].active = YES;
        [btn.heightAnchor constraintEqualToConstant:44].active = YES;
        btn;
    });
    
    self.editBtn = ({
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"Edit" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:CLThemeRedlight alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:CLThemeRedlight alpha:0.4] forState:UIControlStateHighlighted];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular]];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [btn addTarget:self action:@selector(letClassEditing) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:STATUS_BAR_HEIGHT].active = YES;
        [btn.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:8].active = YES;
        [btn.widthAnchor constraintEqualToConstant:64].active = YES;
        [btn.heightAnchor constraintEqualToConstant:44].active = YES;
        btn;

    });
    
    UIView *border = [[UIView alloc] init];
    border.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    border.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:border];
    [border.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [border.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [border.bottomAnchor constraintEqualToAnchor:self.view.topAnchor constant:STATUS_BAR_HEIGHT + 43.5].active = YES;
    [border.heightAnchor constraintEqualToConstant:0.5].active = YES;
}

- (void)letBear{
    self.segmentedControl = ({
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[
                                                                              @"S", @"M", @"T", @"W", @"T", @"F", @"S"
                                                                              ]];
        seg.tintColor = [UIColor colorWithHex:CLThemeBluelight alpha:1];
        seg.translatesAutoresizingMaskIntoConstraints = NO;
        seg.selectedSegmentIndex = 0;
        seg.userInteractionEnabled = self.classEditable;
        seg;
    });
    
    self.bear = ({
        UITableView *bear = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.showsHorizontalScrollIndicator = NO;
        bear.showsVerticalScrollIndicator = NO;
        bear.sectionFooterHeight = 0.0f;
        bear.backgroundColor = [UIColor clearColor];
        bear.separatorColor  = [UIColor colorWithWhite:1 alpha:0.3];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if( section == 0 )
        return self.section0RowCount;
    else if( section == 1 )
        return self.section1RowCount;
    else if( section == 2 )
        return 1;
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.row == 2 && indexPath.section == 1 )
        return self.startsEditing ? 215.0f : 0.0f;
    else if( indexPath.row == 4 && indexPath.section == 1 )
        return self.endsEditing   ? 215.0f : 0.0f;
    else if( indexPath.row == 0 && indexPath.section == 2 )
        return self.textViewHeight;
    
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if( section == 0 || section == 2 ) return 56.0f;
    
    return 56.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if( section == 3 ) return ({
        
        UIView *content = [self.headerCache objectForKey:@"DELETE"];
        if( content == nil ){
            content = [Craig tableHeaderContentViewWithTitle:nil];
            [self.headerCache setObject:content forKey:@"DELETE"];
        }
        content;
    });
    
    else if( section == 2 ) return ({
        
        UIView *content = [self.headerCache objectForKey:@"NOTES"];
        if( content == nil ){
            content = [Craig tableHeaderContentViewWithTitle:@"NOTES"];
            [self.headerCache setObject:content forKey:@"NOTES"];
        }
        
        content;
    });
    
    else if( section == 0 ) return ({
        
        UIView *content = [self.headerCache objectForKey:@"INFO"];
        if( content == nil ){
            content = [Craig tableHeaderContentViewWithTitle:@"INFO"];
            [self.headerCache setObject:content forKey:@"INFO"];
        }
        
        content;
    });
    
    else if( section == 1 ) return ({
        
        UIView *content = [self.headerCache objectForKey:@"SEGFUCK"];
        if( content == nil ){
            content = [Craig tableHeaderContentViewWithTitle:nil];
            
            [self.headerCache setObject:content forKey:@"SEGFUCK"];
            
            [content addSubview:self.segmentedControl];
            [self.segmentedControl.leftAnchor constraintEqualToAnchor:content.leftAnchor constant:16].active = YES;
            [self.segmentedControl.rightAnchor constraintEqualToAnchor:content.rightAnchor constant:-16].active = YES;
            [self.segmentedControl.heightAnchor constraintEqualToConstant:30].active = YES;
            [self.segmentedControl.centerYAnchor constraintEqualToAnchor:content.centerYAnchor].active = YES;
        }
        
        content;
    });
    
    return [UIView new];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[NSAttributedString alloc] initWithString:
            component == 0 ? self.hoursStirng[row] : component == 1 ? self.minusString[row] : row == 0 ? @"am" : @"pm"
                                           attributes:@{
                                                        NSForegroundColorAttributeName: [UIColor whiteColor]
                                                        }];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return component == 0 ? self.hoursStirng.count : component == 1 ? self.minusString.count : 2;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *(^timeString)(void) = ^{
        NSString  *h = component == 0 ? self.hoursStirng[row] : self.hoursStirng[[pickerView selectedRowInComponent:0]];
        NSString  *m = component == 1 ? self.minusString[row] : self.minusString[[pickerView selectedRowInComponent:1]];
        NSString  *u = [pickerView selectedRowInComponent:2] == 0 ? @"AM" : @"PM";
        
        return [NSString stringWithFormat:@"%@:%@ %@", h, m, u];
    };
    
    if( self.startsEditing ){
        self.startsTime = timeString();
        [self.bear reloadRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:1 inSection:1] ] withRowAnimation:UITableViewRowAnimationNone];
    }else if( self.endsEditing ){
        self.endsTime   = timeString();
        [self.bear reloadRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:3 inSection:1] ] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *hair;
    
    if( indexPath.section == 3 ){
        
        hair = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_BUTTON];
        if( hair == nil ){
            hair = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_BUTTON];
            hair.textLabel.text = @"Delete Class";
            hair.textLabel.textColor = [UIColor colorWithHex:CLThemeRedlight alpha:1];
        }
        
        return hair;
        
    }else if( indexPath.section == 0 ){
        
        hair = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_DEFAULT];
        if( hair == nil ){
            hair = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_DEFAULT];
        }
        hair.textLabel.text = self.section0String[indexPath.row];
        hair.detailTextLabel.text = indexPath.row == 0 ? self.classAsset.name : self.classAsset.location;
        
        hair.accessoryType = self.classEditable ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        
        return hair;
        
    }else if( indexPath.section == 1 ){
        
        if( indexPath.row == 2 || indexPath.row == 4 ){
            UITableViewFunctionalCell *cp = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_PICKER];
            if( cp == nil ){
                cp = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_PICKER];
                cp.picker.delegate = self;
                cp.picker.dataSource = self;
                
                [cp.picker selectRow:(int)([cp.picker numberOfRowsInComponent:0] / 2) inComponent:0 animated:NO];
                [cp.picker selectRow:(int)([cp.picker numberOfRowsInComponent:1] / 2) inComponent:1 animated:NO];
            }
            
            if( indexPath.row == 2 )
                cp.hidden = self.startsEditing ? NO : YES;
            else if( indexPath.row == 4 )
                cp.hidden = self.endsEditing   ? NO : YES;
            
            return cp;
        }else if( indexPath.row == 5 ){
            hair = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_COLOR];
            if( hair == nil ){
                hair = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_COLOR];
                hair.textLabel.text = @"Color";
            }
            hair.detailTextLabel.textColor = self.view.tintColor;
            
            hair.accessoryType = self.classEditable ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
            
            return hair;
        }
        
        hair = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_DEFAULT];
        if( hair == nil ){
            hair = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_DEFAULT];
        }
        
        hair.textLabel.text = self.section1String[indexPath.row];
        hair.detailTextLabel.text = self.classAsset.teacher;
        
        if( indexPath.row == 1 )
            hair.detailTextLabel.text = self.startsTime;
        else if( indexPath.row == 3 )
            hair.detailTextLabel.text = self.endsTime;
        
        hair.accessoryType = self.classEditable ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        
        return hair;
        
    }else if( indexPath.section == 2 ){
        UITableViewFunctionalCell *ct = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_TEXT];
        if( ct == nil ){
            ct = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_TEXT];
            ct.textView.text = @"Notes";
            ct.textView.textColor = [UIColor colorWithHex:CLThemeBluelight alpha:1];
            ct.textView.tintColor = ct.textView.textColor;
            ct.textView.delegate = self;
        }
        
        return ct;
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if( self.classEditable == NO )
        return;
    
    if( (indexPath.row == 1 && indexPath.section == 1) ){
        self.startsEditing = !self.startsEditing;
        self.endsEditing   = NO;
        [tableView reloadRowsAtIndexPaths:@[
                                            [NSIndexPath indexPathForRow:2 inSection:1],
                                            [NSIndexPath indexPathForRow:4 inSection:1]
                                            ] withRowAnimation:UITableViewRowAnimationFade];
    }else if( indexPath.row == 3 && indexPath.section == 1 ){
        self.startsEditing = NO;
        self.endsEditing   = !self.endsEditing;
        [tableView reloadRowsAtIndexPaths:@[
                                            [NSIndexPath indexPathForRow:2 inSection:1],
                                            [NSIndexPath indexPathForRow:4 inSection:1]
                                            ] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        if( self.startsEditing || self.endsEditing ){
            self.startsEditing = self.endsEditing = NO;
            [tableView reloadRowsAtIndexPaths:@[
                                                [NSIndexPath indexPathForRow:2 inSection:1],
                                                [NSIndexPath indexPathForRow:4 inSection:1]
                                                ] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        
        if( indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 0) ){
            CRSearchFieldController *seac = [[CRSearchFieldController alloc] init];
            self.customTransitionDetegate.Horizontal = YES;
            seac.transitioningDelegate = self.customTransitionDetegate;
            [self presentViewController:seac animated:YES completion:nil];
        }else if( indexPath.section == 1 && indexPath.row == 5 ){
            [self presentViewController:[CRClassColorPickerController new] animated:YES completion:nil];
        }
        
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return self.classEditable;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if( scrollView == self.bear )
        [self.view endEditing:YES];
}

- (void)letObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DidKeyBoardChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
