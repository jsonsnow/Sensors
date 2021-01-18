//
//  BundleLoad.h
//  WGCommon
//
//  Created by chen liang on 2021/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BundleLoad : NSObject

//根据图片名称获取图片
+ (UIImage *)imageNamed:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
