//
//  NSString+WGSize.h
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/13.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (WGSize)

- (CGSize)getUICeilSize:(UIFont *)font;

- (CGSize)getUICeilSize:(UIFont *)font limitWidth:(CGFloat)width;

- (CGSize)getUICeilSize:(UIFont *)font limitSize:(CGSize)size;

- (CGSize)getUISize:(UIFont *)font;

- (CGSize)getUISize:(UIFont *)font limitWidth:(CGFloat)width;

- (CGSize)getUISize:(UIFont *)font limitSize:(CGSize)size;

- (CGSize)getUISize:(UIFont *)font limitWidth:(CGFloat)width lineSpacing:(CGFloat)space;

- (NSInteger)getLineCount:(UIFont *)font withWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
