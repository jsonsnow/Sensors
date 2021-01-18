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

#import "SensorsAnalyticsSDK.h"
#import "SAAppExtensionDataManager.h"
#import "SASecurityPolicy.h"
#import "SAConfigOptions.h"
#import "SAConstants.h"

FOUNDATION_EXPORT double SensorsAnalyticsSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char SensorsAnalyticsSDKVersionString[];

