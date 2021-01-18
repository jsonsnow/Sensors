//
//  NSArray+WGSafe.m
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/6.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import "NSArray+WGSafe.h"

@implementation NSArray (WGSafe)

#pragma mark - Public Methods

+ (instancetype)safeArrayWithArray:(NSArray *)array
{
    if (array && [array isKindOfClass:[NSArray class]]) {
        return [self arrayWithArray:array];
    }
    else {
        return [self array];
    }
}

+ (instancetype)safeArrayWithObject:(id)object
{
    if (object) {
        return [self arrayWithObject:object];
    }
    else {
        return [self array];
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    if (index >= self.count) {
        return nil;
    }
    else {
        return [self objectAtIndex:index];
    }
}

- (NSString *)safeStringObjectAtIndex:(NSUInteger)index {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if (index >= self.count) {
        return nil;
    }
    
    NSString *string = [self objectAtIndex:index];
    if (![string isKindOfClass:[NSString class]]) {
        string = nil;
    }
    return string;
}

- (BOOL)safeKindofElementClass:(Class)elementClass {
    if (![self isKindOfClass:[NSArray class]]) {
        return NO;
    }
    for (id e in self) {
        if (![e isKindOfClass:elementClass]) {
            return NO;
        }
    }
    return YES;
}


@end
