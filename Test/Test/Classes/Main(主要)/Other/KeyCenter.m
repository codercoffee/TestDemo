//
//  KeyCenter.m
//  StonePass
//
//  Created by 虞政凯 on 15/6/19.
//  Copyright (c) 2015年 虞政凯. All rights reserved.
//

#import "KeyCenter.h"
#import "NSString+Base64.h"
#import <commoncrypto/CommonDigest.h>
@implementation KeyCenter

+ (NSString *)createLongKey {
    
    NSMutableString * mstr = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i < 64; i++) {
        [mstr appendFormat:@"%c",89+arc4random()%33];
    }
    return [mstr base64EncodedString];
}

+ (void)createShortKey:(NSString *)key {
    
}
//主密钥
+ (NSString *)createMasterKey {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * longkey = [defaults objectForKey:@"LONGKEY"];
    NSString * sortKey = [defaults objectForKey:@"PASSWORD"];
    
    return [NSString stringWithFormat:@"%@%@", longkey, sortKey];
}

+ (NSString *)createOldMasterKey {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * longkey = [defaults objectForKey:@"LONGKEY"];
    NSString * sortKey = [defaults objectForKey:@"OLDPASSWORD"];
    
    return [NSString stringWithFormat:@"%@%@", longkey, sortKey];
}

+ (NSString *)createOldLongKeyMasterKey {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * longkey = [defaults objectForKey:@"OLDLONGKEY"];
    NSString * sortKey = [defaults objectForKey:@"PASSWORD"];
    
    return [NSString stringWithFormat:@"%@%@", longkey, sortKey];
}

//通信密钥
+ (NSString *)createCommunicationKey:(NSString *)sortKey {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * longkey = [defaults objectForKey:@"LONGKEY"];
    NSString * communication = [NSString stringWithFormat:@"%@%@", longkey, sortKey];
    NSString *result = [self sha256:communication];
    
    return result;
}

//重置密钥后的通信密钥
+ (NSString *)resetCommunicationKey:(NSString *)sortKey {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * longkey = [defaults objectForKey:@"OLDLONGKEY"];
    NSString * communication = [NSString stringWithFormat:@"%@%@", longkey, sortKey];
    
    return [self sha256:communication];
}

+ (NSString *)checkKeyLongKey:(NSString *)longkey
                  WithsortKey:(NSString *)sortkey {
    
    NSString * tempstring = [NSString stringWithFormat:@"%@%@", longkey, sortkey];
    
    return [self sha256:tempstring];
}

+ (NSString *)sha512:(NSString *)str {
    
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (uint32_t)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString*)sha256:(NSString *)str {
    
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH];

    CC_SHA256(data.bytes, (uint32_t)data.length, digest);

    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end
