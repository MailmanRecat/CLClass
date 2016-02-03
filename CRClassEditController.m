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

#import "CRClassAssetManager.h"
#import "CRClassColorPickerController.h"
#import "CRSearchFieldController.h"
#import "SearchCache.h"
#import "CRClassControlTransition.h"
#import "Craig.h"

#import "DevelopTesting.h"

@interface CRClassEditController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UITextViewDelegate>

@property( nonatomic, strong ) CRClassAssetManager *classManager;

@property( nonatomic, strong ) UILabel *barTitle;
@property( nonatomic, strong ) UIButton *dismissBtn;
@property( nonatomic, strong ) UIButton *editBtn;

@property( nonatomic, strong ) UITableView *bear;
@property( nonatomic, strong ) UISegmentedControl *segmentedControl;

@property( nonatomic, strong ) NSArray *section0String;
@property( nonatomic, strong ) NSArray *section1String;
@property( nonatomic, strong ) NSArray *keysOnSpy;

@property( nonatomic, assign ) CGFloat textViewHeight;

@property( nonatomic, assign ) BOOL    startsEditing;
@property( nonatomic, assign ) BOOL    endsEditing;
@property( nonatomic, assign ) BOOL    notificationEditing;

@property( nonatomic, assign ) BOOL    classEditable;

@property( nonatomic, strong ) NSMutableDictionary *headerCache;

@property( nonatomic, strong ) NSIndexPath *deleteIndexPath;

@property( nonatomic, assign ) BOOL initSomething;
@end

@implementation CRClassEditController

- (void)initIndexPath{
    self.deleteIndexPath = [NSIndexPath indexPathForRow:0 inSection:3];
}

- (BOOL)isTargetIndexPath:(NSIndexPath *)target compare:(NSIndexPath *)compare{
    return target.row == compare.row && target.section == compare.section;
}

- (void)doSomethings{
    [self initIndexPath];
    
    self.title = @"Class";
    self.classManager = [CRClassAssetManager defaultManager];
    
    self.classEditable = YES;
    self.startsEditing = NO;
    self.endsEditing   = NO;
    self.notificationEditing = [self.classManager.editingAsset.alert intValue] == 0 ? NO : YES;
    self.textViewHeight = 128.0f;
    
    self.section0String = @[ @"Course name", @"Location" ];
    self.section1String = @[ @"Teacher", @"Starts", @"", @"Ends", @"", @"Notification", @"Repeat", @"Color" ];
    
    self.keysOnSpy = @[ @"name", @"location", @"teacher", @"weekday", @"color", @"start", @"end" ];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self doSomethings];
    
    self.headerCache = [[NSMutableDictionary alloc] init];
    
    [self letHeader];
    [self letBear];
    
    [self letObserver];
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
        [l.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        [l.heightAnchor constraintEqualToConstant:44].active = YES;
        l;
    });
    
    self.dismissBtn = ({
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"Done" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithIndex:[[CRClassAssetManager defaultManager].editingAsset.color intValue] alpha:1]
                  forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithIndex:[[CRClassAssetManager defaultManager].editingAsset.color intValue] alpha:0.4]
                  forState:UIControlStateHighlighted];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
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
        [btn setTitle:@"Cancel" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:CLThemeRedlight alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:CLThemeRedlight alpha:0.4] forState:UIControlStateHighlighted];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
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
    
    [self.dismissBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.editBtn    addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeWeekday{
    self.classManager.editingAsset.weekday = [NSString stringWithFormat:@"%ld", self.segmentedControl.selectedSegmentIndex];
}

- (void)letBear{
    self.segmentedControl = ({
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[
                                                                              @"M", @"T", @"W", @"T", @"F", @"S", @"S"
                                                                              ]];
        seg.tintColor = [UIColor colorWithIndex:[[CRClassAssetManager defaultManager].editingAsset.color intValue]];
        seg.translatesAutoresizingMaskIntoConstraints = NO;
        seg.selectedSegmentIndex = [[CRClassAssetManager defaultManager].editingAsset.weekday integerValue];
        seg.userInteractionEnabled = self.classEditable;
        seg;
    });
    
    [self.segmentedControl addTarget:self action:@selector(changeWeekday) forControlEvents:UIControlEventValueChanged];
    
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
        return self.section0String.count;
    else if( section == 1 )
        return self.section1String.count;
    else if( section == 2 )
        return 1;
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.row == 2 && indexPath.section == 1 )
        return self.startsEditing ? 215.0f : 0.0f;
    
    else if( indexPath.row == 4 && indexPath.section == 1 )
        return self.endsEditing   ? 215.0f : 0.0f;
    
    else if( indexPath.row == 6 && indexPath.section == 1 )
        return self.notificationEditing ? 44.0f : 0.0f;
    
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

- (void)didPickerViewValueChange:(UIDatePicker *)pickerView{
    NSDateComponents *c = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute
                                                          fromDate:pickerView.date];
    NSString *(^getTimeString)(void) = ^{
        NSString  *h = c.hour < 10 ? [NSString stringWithFormat:@"0%ld", c.hour] : [NSString stringWithFormat:@"%ld", c.hour];
        NSString  *m = c.minute < 10 ? [NSString stringWithFormat:@"0%ld", c.minute] : [NSString stringWithFormat:@"%ld", c.minute];
        
        return [NSString stringWithFormat:@"%@:%@", h, m];
    };
    
    NSString *timeString = getTimeString();
    if( self.startsEditing ){
        self.classManager.editingAsset.start = timeString;
        [self.bear reloadRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:1 inSection:1] ] withRowAnimation:UITableViewRowAnimationNone];
    }else if( self.endsEditing ){
        self.classManager.editingAsset.end   = timeString;
        [self.bear reloadRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:3 inSection:1] ] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)toggleNotification:(UISwitch *)switchControl{
    if( switchControl.tag == 1005 ){
        self.notificationEditing = !self.notificationEditing;
        
        [self.bear reloadRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:6 inSection:1] ]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *hair;
    
    CRClassAssetManager *dfm = [CRClassAssetManager defaultManager];
    
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
        hair.detailTextLabel.text = indexPath.row == 0 ? dfm.editingAsset.name : dfm.editingAsset.location;
        hair.detailTextLabel.textColor = [UIColor colorWithIndex:[dfm.editingAsset.color intValue]];
        
        hair.accessoryType = self.classEditable ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        
        return hair;
        
    }else if( indexPath.section == 1 ){
        
        if( indexPath.row == 2 || indexPath.row == 4 ){
            UITableViewFunctionalCell *cp = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_PICKER];
            if( cp == nil ){
                cp = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_PICKER];
                
                [cp.picker addTarget:self action:@selector(didPickerViewValueChange:) forControlEvents:UIControlEventValueChanged];
            }
            
            if( indexPath.row == 2 ){
                cp.hidden = !self.startsEditing;
            }else if( indexPath.row == 4 ){
                cp.hidden = !self.endsEditing;
            }
            
            return cp;
        }else if( indexPath.row == 5 || indexPath.row == 6 ){
            UITableViewFunctionalCell *sw = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_SWITCH];
            if( sw == nil ){
                sw =  [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_SWITCH];
                
                [sw.switchControl addTarget:self action:@selector(toggleNotification:) forControlEvents:UIControlEventValueChanged];
            }
            
            sw.textLabel.text = self.section1String[indexPath.row];
            sw.switchControl.onTintColor = [UIColor colorWithIndex:[[CRClassAssetManager defaultManager].editingAsset.color intValue]];
            
            if( indexPath.row == 5 ){
                sw.switchControl.tag = 1005;
                
                [sw.switchControl setOn:self.notificationEditing];
            }else if( indexPath.row == 6 ){
                sw.switchControl.tag = 1006;
                
                sw.hidden = !self.notificationEditing;
                
                [sw.switchControl setOn:[self.classManager.editingAsset.alertRepeat intValue] == 0 ? NO : YES];
            }
            
            return sw;
        }else if( indexPath.row == 7 ){
            hair = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_COLOR];
            if( hair == nil ){
                hair = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_COLOR];
                hair.textLabel.text = @"Color";
            }
            hair.detailTextLabel.textColor = [UIColor colorWithIndex:[dfm.editingAsset.color intValue]];
            
            hair.accessoryType = self.classEditable ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
            
            return hair;
        }
        
        hair = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_DEFAULT];
        if( hair == nil ){
            hair = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_DEFAULT];
        }
        
        hair.textLabel.text = self.section1String[indexPath.row];
        
        if( indexPath.row == 0 )
            hair.detailTextLabel.text = dfm.editingAsset.teacher;
        else if( indexPath.row == 1 )
            hair.detailTextLabel.text = dfm.editingAsset.start;
        else if( indexPath.row == 3 )
            hair.detailTextLabel.text = dfm.editingAsset.end;
        
        hair.detailTextLabel.textColor = [UIColor colorWithIndex:[dfm.editingAsset.color intValue]];
        
        hair.accessoryType = self.classEditable ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        
        return hair;
        
    }else if( indexPath.section == 2 ){
        UITableViewFunctionalCell *ct = [tableView dequeueReusableCellWithIdentifier:REUSE_FUNCTIONAL_CELL_ID_TEXT];
        if( ct == nil ){
            ct = [[UITableViewFunctionalCell alloc] initWithReuseString:REUSE_FUNCTIONAL_CELL_ID_TEXT];
            ct.textView.text = @"Notes";
            ct.textView.delegate = self;
        }
        
        UIColor *tc = [UIColor colorWithIndex:[dfm.editingAsset.color intValue]];
        
        ct.textView.text      = self.classManager.editingAsset.notes;
        ct.textView.textColor = [ct.textView.text isEqualToString:CRClassAssetNotesDefVal] ? [tc colorWithAlphaComponent:0.8] : tc;
        ct.textView.tintColor = ct.textView.textColor;
        
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
            ((CRClassControlTransition *)self.transitioningDelegate).Horizontal = YES;
            seac.transitioningDelegate = self.transitioningDelegate;
            seac.themeColor            = [UIColor colorWithIndex:[self.classManager.editingAsset.color intValue]];
            
            if( indexPath.section == 0 && indexPath.row == 0 ){
                seac.type = SC_COURSE_NAME;
                seac.data = [SearchCache cacheFromName:SC_COURSE_NAME];
                seac.placeholderString = @"course name";
            }else if( indexPath.section == 0 && indexPath.row == 1 ){
                seac.type = SC_LOCATION;
                seac.data = [SearchCache cacheFromName:SC_LOCATION];
                seac.placeholderString = @"location";
            }else if( indexPath.section == 1 && indexPath.row == 0 ){
                seac.type = SC_TEACHER;
                seac.data = [SearchCache cacheFromName:SC_TEACHER];
                seac.placeholderString = @"teacher";
            }
            
            seac.valueSelectedHandler = ^(NSString *type, NSString *value, BOOL ISNewKey){
                if( [value isEqualToString:@""] ) return;
                
                if( ISNewKey )
                    [SearchCache insertStringToCache:value name:type];
                
                if( [type isEqualToString:SC_COURSE_NAME] ){
                    self.classManager.editingAsset.name = value;
                }else if( [type isEqualToString:SC_LOCATION] ){
                    self.classManager.editingAsset.location = value;
                    
                }else if( [type isEqualToString:SC_TEACHER]  ){
                    self.classManager.editingAsset.teacher = value;
                    
                }
            };
            
            [self presentViewController:seac animated:YES completion:nil];
            
        }else if( indexPath.section == 1 && indexPath.row == 7 ){
            [self presentViewController:[CRClassColorPickerController new] animated:YES completion:nil];
            
        }else if( [self isTargetIndexPath:self.deleteIndexPath compare:indexPath] ){
            [self deleteClassAction];
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

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if( [textView.text isEqualToString:CRClassAssetNotesDefVal] ){
        textView.text = @"";
        textView.textColor = [UIColor colorWithIndex:[self.classManager.editingAsset.color intValue]];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSString *text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if( [text isEqualToString:CRClassAssetNotesDefVal] || [text isEqualToString:@""] ){
        textView.text = CRClassAssetNotesDefVal;
        textView.textColor = [[UIColor colorWithIndex:[self.classManager.editingAsset.color intValue]] colorWithAlphaComponent:0.8];
    }
    
    self.classManager.editingAsset.notes = textView.text;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if( [keyPath isEqualToString:@"name"] ){
        [self.bear reloadRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:0 inSection:0] ]
                         withRowAnimation:UITableViewRowAnimationNone];
        
    }else if( [keyPath isEqualToString:@"location"] ){
        [self.bear reloadRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:1 inSection:0] ]
                         withRowAnimation:UITableViewRowAnimationNone];
        
    }else if( [keyPath isEqualToString:@"teacher"]  ){
        [self.bear reloadRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:0 inSection:1] ]
                         withRowAnimation:UITableViewRowAnimationNone];
        
    }else if( [keyPath isEqualToString:@"weekday"] ){
        
    }else if( [keyPath isEqualToString:@"color"] ){
        [self.dismissBtn setTitleColor:[UIColor colorWithIndex:[[CRClassAssetManager defaultManager].editingAsset.color intValue] alpha:1]
                              forState:UIControlStateNormal];
        [self.dismissBtn setTitleColor:[UIColor colorWithIndex:[[CRClassAssetManager defaultManager].editingAsset.color intValue] alpha:0.4]
                              forState:UIControlStateHighlighted];
        self.segmentedControl.tintColor = [UIColor colorWithIndex:[[CRClassAssetManager defaultManager].editingAsset.color intValue]];
        [self.bear reloadData];
    }
}

- (void)letObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DidKeyBoardChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
    
    [self.keysOnSpy enumerateObjectsUsingBlock:^(NSString *key, NSUInteger index, BOOL *sS){
        [self.classManager.editingAsset addObserver:self
                                         forKeyPath:key
                                            options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                                            context:nil];
    }];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    ((CRClassControlTransition *)self.transitioningDelegate).Horizontal = NO;
    
    [self.keysOnSpy enumerateObjectsUsingBlock:^(NSString *key, NSUInteger index, BOOL *sS){
        [self.classManager.editingAsset removeObserver:self forKeyPath:key];
    }];
    
    [self.classManager setEditingAsset:nil];
    [self.view endEditing:YES];
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)deleteClassAction{
    UIAlertController *delAlert = [UIAlertController alertControllerWithTitle:@"Delete"
                                                                      message:@"Are you sure want to delete this class?"
                                                               preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction     *cancel   = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive
                                                         handler:nil];
    
    UIAlertAction     *confirm  = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){
                                                             [self deleteClass];
                                                         }];
    
    [delAlert addAction:cancel]; [delAlert addAction:confirm];
    [self presentViewController:delAlert animated:YES completion:nil];
}

- (void)deleteClass{
    NSIndexPath *indexPath = [self.classManager deleteClassAt:self.oldIndexPath];
    
    if( self.delegate && [self.delegate respondsToSelector:@selector(classEditing:deleteAtIndexPath:)] ){
        [self.delegate classEditing:self deleteAtIndexPath:indexPath];
    }
}

- (void)riviseClass{
    NSIndexPath *indexPath = [self.classManager reviseClassAt:self.oldIndexPath with:self.classManager.editingAsset];
    
    if( self.delegate && [self.delegate respondsToSelector:@selector(classEditing:riviseFromIndexPath:toIndexPath:)] ){
        [self.delegate classEditing:self riviseFromIndexPath:self.oldIndexPath toIndexPath:indexPath];
    }
}

- (void)insertClass{
    NSIndexPath *indexPath = [self.classManager insertClass:self.classManager.editingAsset];
    
    if( self.delegate && [self.delegate respondsToSelector:@selector(classEditing:insertAtIndexPath:)] ){
        [self.delegate classEditing:self insertAtIndexPath:indexPath];
    }
}

- (BOOL)isNewClass{
    return [self.classManager.editingAsset.token isEqualToString:CRClassAssetTokenDefVal];
}

- (void)save{
    BOOL isNewClass = [self isNewClass];
    
    if( isNewClass )
        [self insertClass];
    else if( !isNewClass && self.oldIndexPath )
        [self riviseClass];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
