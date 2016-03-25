//
//  RSAViewController.m
//  Text
//
//  Created by wk on 15/12/30.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "RSAViewController.h"
#import "CreateKey.h"
#import "NSString+Base64.h"
#import <AFNetworking.h>

@interface RSAViewController ()

@end

@implementation RSAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

/**
 * 生成RSA公钥和私钥
 */
    CreateKey *key = [[CreateKey alloc] init];
    [key CreatePublicKeyAndPrivateKey];
    NSString *PrivateKey = [key SelectSHA256PrivateKey];
    NSString *PublicKey = [key SelectPublicKey];
    
    NSLog(@"PublicKey == %@", PublicKey);
    NSLog(@"PrivateKey == %@", PrivateKey);
    

/**
 *  APP向核桃服务器发送公钥:
 *  方式： HTTP  POST
 *   /upload_pubkey/
 *      参数名             说明          备注
 *   1	walnut_userid     核桃用户ID
 *   2	pubkey            公钥          Base64
 */
    // APP向核桃服务器发送公钥
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"walnut_userid"] = @"wangkun";
    params[@"pubkey"] = @"123456";
    
    NSString *url = @"http://bank.stonete.com/checkauth";
    NSLog(@"地址: %@", url);
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", nil];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject: %@", responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error);
    }];
    


    
    
    
    
/** 
 * 签名规则:
 * 用私钥对name+uuid 签名
 * 签名结果用base64编码
 */
    NSString *name = @"核桃安全";
    NSString *uuid = @"92d64b78-6e74-4c86-b9b1-07bdf083d823";
    NSString *mids = [NSString stringWithFormat:@"%@%@",name,uuid];
    NSString *base64Mids = [key CreateMids:mids];
    
    NSLog(@"base64Mids === %@", base64Mids);
    
    
/**
 *  APP向回调地址发送请求格式:
 *  方式： HTTP  POST
 *      参数名             说明                        备注
 *   1	walnutid          walnut_userid的SHA256       HEX格式,全部小写
 *   2	uuid              UUID
 *   3	pubkeyhash        当前用户公钥SHA256            HEX格式,全部小写
 *   4	sign              签名结果                     Base64格式
 */
    
    
    
    
    
    
    
    // APP向回调地址发送请求
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"walnutid"] = @"wangkun";
//    params[@"uuid"] = @"92d64b78-6e74-4c86-b9b1-07bdf083d823";
//    params[@"pubkeyhash"] = @"wangkun";
//    params[@"sign"] = @"123456";
//    
//    NSString *url = @"http://bank.stonete.com/checkauth";
//    NSLog(@"地址: %@", url);
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", nil];
//    
//    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"responseObject: %@", responseObject);
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"Error: %@", error);
//    }];
    
    
    
    
    
    
    
//    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
//    NSString *defaultsPublicKey = [defaults objectForKey:@"myPublic"];
//    NSLog(@"defaultsPublicKey == %@", defaultsPublicKey);
    
    
    
//    /** base64编码 */
//    NSString *string = @"10101101 10111010 01110110";
//    NSString *base64String = [string base64EncodedString];
//    NSLog(@"base64String === %@", base64String);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
