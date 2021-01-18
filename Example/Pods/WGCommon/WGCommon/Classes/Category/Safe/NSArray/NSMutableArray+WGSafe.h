//
//  NSMutableArray+WGSafe.h
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/6.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray<ObjectType> (WGSafe)

/** 安全Add Object */
- (void)safeAddObject:(ObjectType)object;

/** 安全Add Array */
- (void)safeAddObjectsFromArray:(NSArray<ObjectType> *)array;

/** 安全Remove Object */
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;

/** 安全replace Object */
- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)object;

/** 安全Insert Object */
- (void)safeInsertObject:(ObjectType)object atIndex:(NSUInteger)index;

/** 安全Insert Objects */
- (void)safeInsertObjects:(NSArray<ObjectType> *)objects atIndexes:(NSIndexSet *)indexs;



@end

NS_ASSUME_NONNULL_END
