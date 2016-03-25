//
//  KAFN.h
//  AFN
//
//  Created by wk on 15/12/17.
//  Copyright © 2015年 wk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface KAFN : NSObject





/** 截取不带参数的url */
+ (NSString *)kCaptureUrl:(NSString *)url;

/** 提取url本身自带参数 */
+ (NSMutableDictionary *)kDealParamsOfUrl:(NSString *)url params:(NSMutableDictionary *)params;

@end
