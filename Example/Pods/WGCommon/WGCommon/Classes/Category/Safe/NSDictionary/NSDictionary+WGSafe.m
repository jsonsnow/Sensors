//
//  NSDictionary+WGSafe.m
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/6.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import "NSDictionary+WGSafe.h"

@implementation NSDictionary (WGSafe)

#pragma mark - Public Methods

+ (instancetype)safeDictionaryWithObject:(id)object forKey:(id <NSCopying>)key {
    if (object && key) {
        return [self dictionaryWithObject:object forKey:key];
    }
    else {
        return [self dictionary];
    }
}

- (id)safeObjectForKey:(id)key {
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    if (key) {
        return [self objectForKey:key];
    }
    else {
        return nil;
    }
}

- (NSString *)safeStringForKey:(id)key {
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    if (!key) {
        return nil;
    }
    
    NSString *string = [self objectForKey:key];
    if ([string isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)string stringValue];
    }
    if (![string isKindOfClass:[NSString class]]) {
        string = nil;
    }
    return string;
}


- (NSArray *)safeArrayForKey:(id)key {
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    if (!key) {
        return nil;
    }
    
    NSArray *array = [self objectForKey:key];
    if (![array isKindOfClass:[NSArray class]]) {
        array = nil;
    }
    return array;
}

- (NSDictionary *)safeDictionaryForKey:(id)key {
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    if (!key) {
        return nil;
    }
    
    NSDictionary *dictionary = [self objectForKey:key];
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return dictionary;
}


@end
