//
//  CreateKey.m
//  QRCode
//
//  Created by wk on 15/12/30.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "CreateKey.h"
#import "OpenSSLRSAWrapper.h"
#import <commoncrypto/CommonDigest.h>
#import "NSData+Base64.h"

@implementation CreateKey

-(void)CreatePublicKeyAndPrivateKey
{
    OpenSSLRSAWrapper * wrapper = [OpenSSLRSAWrapper shareInstance];
    
    if ([wrapper importRSAKeyWithType:KeyTypePublic] && [wrapper importRSAKeyWithType:KeyTypePrivate])
    {
        
    }
    else
    {
        if([wrapper generateRSAKeyPairWithKeySize:2048])
        {
            [wrapper exportRSAKeys];
        }
    }
}
-(NSString *)CreateMids:(NSString *)string
{
    NSString * temp             = [self sha256:string];
    OpenSSLRSAWrapper * wrapper = [OpenSSLRSAWrapper shareInstance];
    NSData * encrypData         = [wrapper encryptRSAKeyWithType: KeyTypePrivate plainText:temp];
    return [encrypData base64EncodedString];
}

-(NSString * )SelectSHA256PrivateKey
{
    OpenSSLRSAWrapper * wrapper = [OpenSSLRSAWrapper shareInstance];
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    [defaults setObject:wrapper.privateKeyBase64 forKey:@"myPrivate"];
    return [self sha256:wrapper.privateKeyBase64];
}

-(NSString *)SelectPublicKey
{
    OpenSSLRSAWrapper * wrapper = [OpenSSLRSAWrapper shareInstance];
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    [defaults setValue:wrapper.publicKeyBase64 forKey:@"myPublic"];
    return wrapper.publicKeyBase64;
}

-(void)UpdatePublicKeyAndPrivateKey
{
    OpenSSLRSAWrapper * wrapper = [OpenSSLRSAWrapper shareInstance];
    if([wrapper generateRSAKeyPairWithKeySize:2048])
    {
        [wrapper exportRSAKeys];
    }
}
- (NSString*)sha256:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (uint32_t)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

-(NSString *)sha512:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (uint32_t)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

-(NSString *)md5HexDigest:(NSString*)input
{
    const char * str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (uint32_t)strlen(str), result);
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}



@end
