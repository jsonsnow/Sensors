//
//  NSArray+WGSafe.h
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/6.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (WGSafe)

/** 安全快速构造方法 */
+ (instancetype)safeArrayWithArray:(NSArray<ObjectType> *)array;

/** 安全快速构造方法 */
+ (instancetype)safeArrayWithObject:(ObjectType)object;

/** 安全取object */
- (nullable ObjectType)safeObjectAtIndex:(NSUInteger)index;

/** 安全取NSString */
- (NSString *)safeStringObjectAtIndex:(NSUInteger)index;

/** 判断子元素是否是elementClass */
- (BOOL)safeKindofElementClass:(Class)elementClass;

@end

NS_ASSUME_NONNULL_END
