//
//  CRClassAccountCreateControllerViewController.h
//  CLClass
//
//  Created by caine on 1/21/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CLBasicViewController.h"

@protocol CRClassAccountCreateDeleagte <NSObject>

- (void)didCreateAccount:(NSString *)name;

@end

@interface CRClassAccountCreateController : CLBasicViewController

@property( nonatomic, weak ) id<CRClassAccountCreateDeleagte> delegate;

@end
