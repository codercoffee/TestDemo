//
//  KColor.m
//  StonePass
//
//  Created by wk on 16/4/9.
//  Copyright © 2016年 虞政凯. All rights reserved.
//

#import "KColor.h"

@implementation KColor

+ (UIColor *)kColorWithHexString:(NSString *)stringToConvert
{
    //从字符串中去除空格和换行
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return nil;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return nil;
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


+ (NSString *)kRandomColorToHexString
{
    NSMutableString * mColors = [NSMutableString stringWithCapacity:0];
    NSString * R = [NSString stringWithFormat:@"%02x",arc4random()%256];
    NSString * G = [NSString stringWithFormat:@"%02x",arc4random()%256];
    NSString * B = [NSString stringWithFormat:@"%02x",arc4random()%256];
    [mColors appendFormat:@"%@%@%@",R,G,B];
    return mColors;
}


@end
