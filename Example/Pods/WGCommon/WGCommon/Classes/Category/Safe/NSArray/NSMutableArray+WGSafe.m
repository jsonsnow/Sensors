//
//  NSMutableArray+WGSafe.m
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/6.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import "NSMutableArray+WGSafe.h"

@implementation NSMutableArray (WGSafe)

#pragma mark - Public Methods

- (void)safeAddObject:(id)object {
    if (![self isKindOfClass:[NSMutableArray class]]) {
        return ;
    }
    
    if (object) {
        [self addObject:object];
    }
}

- (void)safeAddObjectsFromArray:(NSArray *)array {
    if (![array isKindOfClass:[NSArray class]]) {
        return ;
    }
    [self addObjectsFromArray:array];
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (![self isKindOfClass:[NSMutableArray class]]) {
        return ;
    }
    
    if (index >= self.count) {
        return ;
    }
    
    [self removeObjectAtIndex:index];
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    if (object) {
        [self replaceObjectAtIndex:index withObject:object];
    }
}

- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index {
    if (![self isKindOfClass:[NSMutableArray class]]) {
        return ;
    }
    
    if (!object) {
        return ;
    }
    
    if (index > self.count) {
        return ;
    }
    
    [self insertObject:object atIndex:index];
}

- (void)safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexs {
    if (![self isKindOfClass:[NSMutableArray class]]) {
        return ;
    }
    
    if (indexs == nil) {
        return ;
    }
    
    if (indexs.count != objects.count ||
        indexs.firstIndex >= objects.count ||
        indexs.lastIndex >= objects.count) {
        return ;
    }
    
    [self insertObjects:objects atIndexes:indexs];
}


@end
