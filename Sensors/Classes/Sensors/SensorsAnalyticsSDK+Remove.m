//
//  SensorsAnalyticsSDK+Remove.m
//  WeAblum
//
//  Created by chen liang on 2019/12/23.
//  Copyright © 2019 WeAblum. All rights reserved.
//

#import "SensorsAnalyticsSDK+Remove.h"
#import "UIViewController+AutoTrack.h"

@implementation SensorsAnalyticsSDK (Remove)

- (NSMutableArray *)allIgnoreCtrs  {
    return [self valueForKey:@"_ignoredViewControllers"];
}

- (void)removeSingleIgnoreCtrName:(NSString *)name {
    [self removeArryIgnoreCtrName:@[name]];
}

- (void)removeArryIgnoreCtrName:(NSArray<NSString *> *)name {
    @synchronized (self) {
        NSMutableArray *ignores = [self allIgnoreCtrs];
        [ignores removeObjectsInArray:name];
    }
}

- (void)removeAllIgnores {
    [self removeArryIgnoreCtrName:[self allIgnoreCtrs].copy];
}

- (NSString *)sensorsdata_title {
    return SensorsAnalyticsSDK.sharedInstance.currentViewController.sensorsdata_title;
}

@end
