//
//  SearchCache.m
//  CLClass
//
//  Created by caine on 1/25/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "SearchCache.h"

@implementation SearchCache

+ (NSMutableArray *)cacheFromName:(NSString *)name{
    NSArray *cache = [[NSUserDefaults standardUserDefaults] objectForKey:[self keyFromName:name]];
    
    return [[NSMutableArray alloc] initWithArray:cache];
}

+ (void)insertStringToCache:(NSString *)string name:(NSString *)name{
    NSMutableArray *cache = [self cacheFromName:name];
    [cache insertObject:string atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:cache forKey:[self keyFromName:name]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clearCacheAtIndex:(NSUInteger)index name:(NSString *)name{
    NSMutableArray *cache = [SearchCache cacheFromName:name];
    
    if( index < cache.count ){
        [cache removeObjectAtIndex:index];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:cache forKey:[self keyFromName:name]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clearCache:(NSString *)name{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:[self keyFromName:name]];
}

+ (NSString *)keyFromName:(NSString *)name{
    return [NSString stringWithFormat:@"SearchCache%@", name];
}

@end
