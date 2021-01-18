//
//  NSMutableDictionary+WGSafe.h
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/6.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary<KeyType, ObjectType> (WGSafe)

+ (instancetype)safeDictionaryWithDictionary:(NSDictionary<KeyType, ObjectType> *)dict;

- (void)safeSetObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;

- (void)safeRemoveObjectForKey:(KeyType)aKey;

/** Dictionary add otherDictionary */
- (void)safeAddEntriesFromDictionary:(NSDictionary<KeyType, ObjectType> *)otherDictionary;

@end

NS_ASSUME_NONNULL_END
