//
//  NSString+WGSafe.h
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/6.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (WGSafe)

+ (instancetype)safeStringWithString:(NSString *)string;

- (instancetype)safeInitWithString:(NSString *)aString;

- (nullable NSString *)safeSubstringFromIndex:(NSUInteger)from;

- (nullable NSString *)safeSubstringToIndex:(NSUInteger)to;

- (nullable NSString *)safeSubstringWithRange:(NSRange)range;

- (NSRange)safeRangeOfString:(NSString *)aString;

- (NSRange)safeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask;

- (nullable NSString *)safeStringByAppendingString:(NSString *)aString;

@end

NS_ASSUME_NONNULL_END
