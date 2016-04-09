//
//  NSString+MD5.h
//  NSString
//
//  Created by wk on 16/1/6.
//  Copyright © 2016年 wk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

// MD5其实经过算法产生的是固定的128bit，即128个0和1的二进制位，每4位二进制对应一个16进制的元素，而在实际应用开发中，通常是以16进制输出的，所以正好就是32位的16进制，也就是32个16进制的数字。

/**
 *  MD5加密
 *
 *  @return 加密后的32位字符串
 */
- (NSString *)md5;

/**
 *  MD5加密
 *
 *  @return 加密后的32位字符串
 */
+ (NSString *)md5:(NSString *)str;


@end
