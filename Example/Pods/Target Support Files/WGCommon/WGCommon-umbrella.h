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

#import "BundleLoad.h"
#import "NSString+WGSize.h"
#import "NSArray+WGSafe.h"
#import "NSMutableArray+WGSafe.h"
#import "NSDictionary+WGSafe.h"
#import "NSMutableDictionary+WGSafe.h"
#import "NSString+WGSafe.h"
#import "WGSafeDefine.h"
#import "UIView+ShapeView.h"
#import "MassoryBridge.h"
#import "JSONUtils.h"
#import "WGCommon.h"

FOUNDATION_EXPORT double WGCommonVersionNumber;
FOUNDATION_EXPORT const unsigned char WGCommonVersionString[];

