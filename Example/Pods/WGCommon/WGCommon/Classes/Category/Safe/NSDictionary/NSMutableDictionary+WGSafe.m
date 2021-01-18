//
//  NSMutableDictionary+WGSafe.m
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/6.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import "NSMutableDictionary+WGSafe.h"

@implementation NSMutableDictionary (WGSafe)

#pragma mark - Public Methods

+ (instancetype)safeDictionaryWithDictionary:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        return [self dictionaryWithDictionary:dict];
    }
    else {
        return [NSMutableDictionary dictionary];
    }
}

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (![self isKindOfClass:[NSMutableDictionary class]]) {
        return ;
    }
    
    if (anObject && aKey && ![anObject isKindOfClass:[NSNull class]]) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)safeRemoveObjectForKey:(id<NSCopying>)aKey {
    if (![self isKindOfClass:[NSMutableDictionary class]]) {
        return ;
    }
    
    if (aKey) {
        [self removeObjectForKey:aKey];
    }
}

- (void)safeAddEntriesFromDictionary:(NSDictionary *)otherDictionary {
    if ([self isKindOfClass:[NSMutableDictionary class]] &&
        [otherDictionary isKindOfClass:[NSDictionary class]]) {
        [self addEntriesFromDictionary:otherDictionary];
    }
}

@end
