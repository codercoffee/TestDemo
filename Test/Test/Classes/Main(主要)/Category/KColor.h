//
//  KColor.h
//  StonePass
//
//  Created by wk on 16/4/9.
//  Copyright © 2016年 虞政凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KColor : NSObject

/**
 *  用十六进制颜色字符串来设置颜色
 *
 *  @param stringToConvert 十六进制颜色字符串
 *
 *  @return RGB颜色
 */
+ (UIColor *)kColorWithHexString:(NSString *)stringToConvert;

/**
 *  把随机色转换为十六进制颜色
 *
 *  @return 十六进制颜色
 */
+ (NSString *)kRandomColorToHexString;

@end
