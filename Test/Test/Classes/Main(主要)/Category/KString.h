//
//  KString.h
//  NSString
//
//  Created by wk on 15/12/22.
//  Copyright © 2015年 wk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KString : NSObject

/** 根据字符串、字体大小、最大宽度获得字符串所占空间大小CGSize */
+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font andMaxW:(CGFloat)maxW;
/** 根据字符串、字体大小获得字符串所占空间大小CGSize */
+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font;


/** 根据字符串、字体、行间距、颜色获得字体所占空间大小CGSize，限制在size大小范围内 */
+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font andSize:(CGSize)size andLineSpace:(CGFloat)lineSpace andColor:(UIColor *)color;

/** 判断字符串中是否含有另一个字符串，包含则返回从左到右开始，第一个该字符位置开始，并包括之后的全部字符的新字符串,否则返回原字符串 */
+ (NSString *)kInterceptOriginalString:(NSString *)originalString withSpecifiedString:(NSString *)specifiedString;

@end
