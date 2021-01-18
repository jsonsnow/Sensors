#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SensorHeaderFile.h"
#import "SensorsAnalyticsSDK+Remove.h"

FOUNDATION_EXPORT double SensorsVersionNumber;
FOUNDATION_EXPORT const unsigned char SensorsVersionString[];

