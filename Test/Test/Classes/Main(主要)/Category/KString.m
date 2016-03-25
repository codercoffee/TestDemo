//
//  KString.m
//  NSString
//
//  Created by wk on 15/12/22.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "KString.h"

@implementation KString


+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font andMaxW:(CGFloat)maxW {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font {

    return [KString kSizeOfText:text withFont:font andMaxW:MAXFLOAT];
}



+ (CGSize)kSizeOfText:(NSString *)text withFont:(UIFont *)font andSize:(CGSize)size andLineSpace:(CGFloat)lineSpace andColor:(UIColor *)color
{
    CGSize resSize = CGSizeZero;
    NSMutableAttributedString *attStr = [KString createAttributeStringWithText:text LineSpace:lineSpace andFont:font andColor:color];
    resSize = [attStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return  resSize;
}
+ (NSMutableAttributedString *) createAttributeStringWithText:(NSString *) text LineSpace:(CGFloat) lineSpace andFont:(UIFont *) font andColor:(UIColor *) color
{
    if(nil == text)
        return nil;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    //设置字体颜色
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length)];
    //设置行距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;//行距
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    return attStr;
}


+ (NSString *)kInterceptOriginalString:(NSString *)originalString withSpecifiedString:(NSString *)specifiedString {
    
    NSRange range = [originalString rangeOfString:specifiedString];
    if (range.location != NSNotFound) {
        
        //        NSLog(@"Location:%i,Leigth:%i",range.location,range.length);
        return [originalString substringFromIndex:range.location + 1];
    } else {
        
        NSLog(@"该字符串中不包含: %@",specifiedString);
        return originalString;
    }
    
}


@end
