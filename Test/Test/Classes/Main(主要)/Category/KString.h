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

/**
 *  获取字符串所占空间大小CGSize
 *
 *  @param text 字符串内容
 *  @param font 字号
 *  @param maxW 最大宽度
 *
 *  @return 计算之后的字符串所占空间大小
 */
+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font andMaxW:(CGFloat)maxW;

/**
 *  获取字符串所占空间大小CGSize
 *
 *  @param text 字符串内容
 *  @param font 字号
 *
 *  @return 计算之后的字符串所占空间大小
 */
+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font;

/**
 *  获取字符串所占空间大小CGSize
 *
 *  @param text      字符串内容
 *  @param font      字号
 *  @param size      字符串约束的范围的宽度和高度 CGSizeMake(SCREEN_WIDTH, MAXFLOAT)
 *  @param lineSpace 行间距
 *  @param color     颜色
 *
 *  @return 计算之后的字符串所占空间大小
 */
+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font andSize:(CGSize)size andLineSpace:(CGFloat)lineSpace andColor:(UIColor *)color;

/**
 *  判断字符串中是否含有另一个字符串，包含则返回从左到右开始，第一个该字符位置开始，并包括之后的全部字符的新字符串,否则返回原字符串
 *
 *  @param originalString  原字符串
 *  @param specifiedString 判断是否含有的另一个字符串
 *
 *  @return 截取的新字符串或原字符串
 */
+ (NSString *)kInterceptOriginalString:(NSString *)originalString withSpecifiedString:(NSString *)specifiedString;

/**
 *  MD5加密
 *
 *  @return 加密后的32位字符串
 */
+ (NSString *)kMD5:(NSString *)str;

@end
