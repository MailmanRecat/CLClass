//
//  SearchCache.h
//  CLClass
//
//  Created by caine on 1/25/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const SC_COURSE_NAME = @"SC_COURSE_NAME";
static NSString *const SC_LOCATION    = @"SC_LOCATION";
static NSString *const SC_TEACHER     = @"SC_TEACHER";

@interface SearchCache : NSObject

+ (NSMutableArray *)cacheFromName:(NSString *)name;
+ (void)insertStringToCache:(NSString *)string name:(NSString *)name;
+ (void)clearCacheAtIndex:(NSUInteger)index name:(NSString *)name;
+ (void)clearCache:(NSString *)name;

@end
