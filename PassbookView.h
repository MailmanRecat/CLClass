//
//  PassbookView.h
//  CLClass
//
//  Created by caine on 1/26/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRClassAsset.h"

@interface PassbookView : UIVisualEffectView

@property( nonatomic, strong ) UIButton *action1;
@property( nonatomic, strong ) UIButton *action2;

- (void)passbookOfClassAsset:(CRClassAsset *)asset;

@end
