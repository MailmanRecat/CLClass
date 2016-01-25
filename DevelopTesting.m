//
//  DevelopTesting.m
//  CLClass
//
//  Created by caine on 1/25/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "DevelopTesting.h"

@implementation DevelopTesting

+ (void)logClassAsset:(CRClassAsset *)asset{
    NSLog(@"token %@", asset.token);
    NSLog(@"name %@", asset.name);
    NSLog(@"user %@", asset.user);
    NSLog(@"weekday %@", asset.weekday);
    NSLog(@"start %@", asset.start);
    NSLog(@"end %@", asset.end);
    NSLog(@"location %@", asset.location);
    NSLog(@"teacher %@", asset.teacher);
    NSLog(@"color %@", asset.color);
    NSLog(@"notes %@", asset.notes);
    NSLog(@"type %@", asset.type);

}

@end
