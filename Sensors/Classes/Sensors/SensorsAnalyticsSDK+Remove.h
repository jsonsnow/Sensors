//
//  SensorsAnalyticsSDK+Remove.h
//  WeAblum
//
//  Created by chen liang on 2019/12/23.
//  Copyright © 2019 WeAblum. All rights reserved.
//

//#import "SensorsAnalyticsSDK.h"
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface SensorsAnalyticsSDK (Remove)

- (void)removeSingleIgnoreCtrName:(NSString *)name;
- (void)removeArryIgnoreCtrName:(NSArray <NSString *> *)name;
- (void)removeAllIgnores;
- (NSString *)sensorsdata_title;

@end

NS_ASSUME_NONNULL_END
