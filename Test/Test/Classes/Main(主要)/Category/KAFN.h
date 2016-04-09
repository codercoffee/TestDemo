//
//  KAFN.h
//  AFN
//
//  Created by wk on 15/12/17.
//  Copyright © 2015年 wk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KAFN : NSObject

/**
 *  截取带参数的url
 *
 *  @param url 原url
 *
 *  @return 截取出的不带参数的url
 */
+ (NSString *)kCaptureUrl:(NSString *)url;

/**
 *  提取url本身自带参数
 *
 *  @param url 注意：这里传进来的是没处理之前的url
 *  @param params 参数字典
 *
 *  @return 添加参数后的字典
 */
+ (NSMutableDictionary *)kDealParamsOfUrl:(NSString *)url params:(NSMutableDictionary *)params;

@end
