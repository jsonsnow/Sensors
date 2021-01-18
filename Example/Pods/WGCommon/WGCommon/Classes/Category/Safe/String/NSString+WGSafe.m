//
//  NSString+WGSafe.m
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/6.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import "NSString+WGSafe.h"

@implementation NSString (WGSafe)

#pragma mark - Public Methods

+ (instancetype)safeStringWithString:(NSString *)string {
    if (string) {
        return [self stringWithString:string];
    }
    else {
        return [self stringWithString:@""];
    }
}

- (instancetype)safeInitWithString:(NSString *)aString {
    if (![self isKindOfClass:[NSString class]] ||
        ![aString isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    if (aString) {
        return [self initWithString:aString];
    }
    else {
        return [self initWithString:@""];
    }
}


- (NSString *)safeSubstringFromIndex:(NSUInteger)from {
    if (![self isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    if (from > self.length) {
        return nil;
    }
    else {
        return [self substringFromIndex:from];
    }
}

- (NSString *)safeSubstringToIndex:(NSUInteger)to {
    if (![self isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    if (to > self.length) {
        return nil;
    }
    else {
        return [self substringToIndex:to];
    }
}

- (NSString *)safeSubstringWithRange:(NSRange)range {
    if (![self isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    if (range.location + range.length > self.length) {
        return nil;
    }
    else {
        return [self substringWithRange:range];
    }
}

- (NSRange)safeRangeOfString:(NSString *)aString {
    if (![self isKindOfClass:[NSString class]] ||
        ![aString isKindOfClass:[NSString class]]) {
        return NSMakeRange(NSNotFound, 0);
    }
    
    if (aString) {
        return [self rangeOfString:aString];
    }
    else {
        return NSMakeRange(NSNotFound, 0);
    }
}

- (NSRange)safeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask {
    if (![self isKindOfClass:[NSString class]] ||
        ![aString isKindOfClass:[NSString class]]) {
        return NSMakeRange(NSNotFound, 0);
    }
    
    if (aString) {
        return [self rangeOfString:aString options:mask];
    }
    else {
        return NSMakeRange(NSNotFound, 0);
    }
}

- (NSString *)safeStringByAppendingString:(NSString *)aString {
    if (![self isKindOfClass:[NSString class]] ||
        ![aString isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    if (aString) {
        return [self stringByAppendingString:aString];
    }
    else {
        return [self stringByAppendingString:@""];
    }
}


@end
