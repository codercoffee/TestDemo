//
//  KAFN.m
//  AFN
//
//  Created by wk on 15/12/17.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "KAFN.h"

@implementation KAFN

+ (NSString *)kCaptureUrl:(NSString *)url
{
    if ([url rangeOfString:@"?"].location != NSNotFound)
    {
        NSRange range = [url rangeOfString:@"?"];
        url = [url substringToIndex:range.location];
    }
    return url;
}

+ (NSMutableDictionary *)kDealParamsOfUrl:(NSString *)url params:(NSMutableDictionary *)params
{
    if ([url rangeOfString:@"?"].location != NSNotFound)
    {
        NSRange range = [url rangeOfString:@"?"];
        NSString *parameterString = [url substringFromIndex:range.location + 1];
        if ([parameterString rangeOfString:@"&"].location != NSNotFound)
        {
            NSArray *paramsArr = [parameterString componentsSeparatedByString:@"&"];
            for (int i = 0; i < paramsArr.count; i ++)
            {
                NSString *temporaryString = paramsArr[i];
                NSArray *temporaryArr = [temporaryString componentsSeparatedByString:@"="];
                NSString *keyStr = temporaryArr[0];
                NSString *valueStr = temporaryArr[1];
                params[keyStr] = valueStr;
//                NSLog(@"参数：%@=%@", keyStr, valueStr);
            }
            
        }
        else
        {
            NSArray *temporaryArr = [parameterString componentsSeparatedByString:@"="];
            NSString *keyStr = temporaryArr[0];
            NSString *valueStr = temporaryArr[1];
            params[keyStr] = valueStr;
//            NSLog(@"参数：%@=%@", keyStr, valueStr);
        }
    }
    
    return params;
}


@end
