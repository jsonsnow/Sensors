//
//  NSString+WGSize.m
//  WeAblum
//
//  Created by 张忠燕 on 2018/12/13.
//  Copyright © 2018 WeAblum. All rights reserved.
//

#import "NSString+WGSize.h"
#import <WGCommon/WGCommon-Swift.h>

@implementation NSString (WGSize)

#pragma mark - Public Methods

- (CGSize)getUICeilSize:(UIFont *)font {
    CGSize size = [self getUISize:font];
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

- (CGSize)getUICeilSize:(UIFont *)font limitWidth:(CGFloat)width {
    CGSize size = [self getUISize:font limitWidth:width];
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

- (CGSize)getUICeilSize:(UIFont *)font limitSize:(CGSize)size
{
    size = [self getUISize:font limitSize:size];
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

- (CGSize)getUISize:(UIFont *)font {
    return [self getUISize:font limitWidth:CGFLOAT_MAX];
}

- (CGSize)getUISize:(UIFont *)font limitWidth:(CGFloat)width {
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    return [self getUISize:font limitSize:size];
}

- (CGSize)getUISize:(UIFont *)font limitSize:(CGSize)size
{
    NSDictionary *attributesDict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributesDict context:nil].size;
}

- (CGSize)getUISize:(UIFont *)font limitWidth:(CGFloat)width lineSpacing:(CGFloat)space {
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = space;
    
    NSDictionary *attributesDict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,paragraphStyle, NSParagraphStyleAttributeName, nil];
    
    return [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributesDict context:nil].size;
}

- (NSInteger)getLineCount:(UIFont *)font withWidth:(CGFloat)width {
    CGSize size = [self getUISize:font limitWidth:width];
    NSInteger lineCount = ceil(size.height/font.lineHeight);
    return lineCount;
}

@end
