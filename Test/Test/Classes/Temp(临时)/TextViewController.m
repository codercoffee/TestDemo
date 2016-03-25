//
//  TextViewController.m
//  Text
//
//  Created by wk on 15/12/23.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "TextViewController.h"
#import <AFNetworking.h>
#import <FMDB.h>
#import <MBProgressHUD.h>
#import "QRScanViewController.h"
#import "KString.h"
#import "CreateKey.h"
#import "OpenSSLRSAWrapper.h"
#import "NSString+Base64.h"
#import "NSData+Base64.h"

// 屏幕宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
 
// 偏好设置
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kFileManager  [NSFileManager defaultManager]

// RGB颜色
#define COLOR(R ,G ,B ,A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]

// 随机色
#define RandomColor COLOR(arc4random() % 256, arc4random() % 256, arc4random() % 256, 1)

//各种view按手机屏幕大小缩放时，用到的基准宽和高
#define ScaleWidth(width)  (SCREEN_WIDTH / 375 * width)
#define ScaleHeight(height)  (SCREEN_HEIGHT / 667 * height)

#define APPURL  @"http://192.168.1.174:8905/upload_pubkey/"

@interface TextViewController ()
{
    NSString *PublicKey;
    NSString *PrivateKey;
    NSString * walnut_userid;
}


@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];
    // 设置背景色
    self.view.backgroundColor = COLOR(228, 236, 254, 1);
    
    
    // 扫描登录按钮
    UIButton *scanLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    scanLoginButton.backgroundColor = COLOR(12, 90, 217, 1);
    //设置矩形四个圆角半径
    [scanLoginButton.layer setMasksToBounds:YES];
    [scanLoginButton.layer setCornerRadius:10.0];
    CGFloat scanLoginBtnX = (SCREEN_WIDTH - ScaleWidth(300)) / 2;
    CGFloat scanLoginBtnY = ScaleHeight(390);
    scanLoginButton.frame = CGRectMake(scanLoginBtnX, scanLoginBtnY, ScaleWidth(300), ScaleHeight(50));
    [scanLoginButton addTarget:self action:@selector(scanLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanLoginButton];
    // 扫描登录
    UILabel *scanLoginLabel = [[UILabel alloc] init];
    scanLoginLabel.text = @"扫描登录";
    scanLoginLabel.textColor = [UIColor whiteColor];
    scanLoginLabel.font = [UIFont boldSystemFontOfSize:17];
    CGSize scanLoginSize = [KString kSizeOfText:scanLoginLabel.text withFont:scanLoginLabel.font];
    CGFloat scanLoginLabelX = (ScaleWidth(300) - scanLoginSize.width) / 2;
    CGFloat scanLoginLabelY = (ScaleHeight(50) - scanLoginSize.height) / 2;
    scanLoginLabel.frame = CGRectMake(scanLoginLabelX, scanLoginLabelY, scanLoginSize.width, scanLoginSize.height);
    [scanLoginButton addSubview:scanLoginLabel];
    
    
/**
 * 生成RSA公钥和私钥
 */
    CreateKey *key = [[CreateKey alloc] init];
    [key CreatePublicKeyAndPrivateKey];
    PrivateKey = [key SelectSHA256PrivateKey];
    PublicKey = [key SelectPublicKey];
    
    NSString *defaultsPublicKey = [kUserDefaults objectForKey:@"myPublic"];
    NSLog(@"PublicKey == %@", defaultsPublicKey);
    NSString *defaultsPrivateKey = [kUserDefaults objectForKey:@"myPrivate"];
    NSLog(@"PrivateKey == %@", defaultsPrivateKey);
    
    
/**
 *  创建walnut_userid
 */
    walnut_userid = [self CreateUUID];
    [kUserDefaults setObject:walnut_userid forKey:@"walnut_userid"];
    
    NSString *defaultsWalnut_userid = [kUserDefaults objectForKey:@"walnut_userid"];
    NSLog(@"walnut_userid == %@", defaultsWalnut_userid);
    
    
    
    
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
    params[@"walnut_userid"] = walnut_userid;
    params[@"pubkey"] = PublicKey;
    
    NSString *url = @"http://www.walnutsec.com/login";
    NSLog(@"地址: %@", url);
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    
    [manager POST:APPURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject: %@", responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error);
    }];

    
    

    
    
    
    
    
    
}


- (NSString *)CreateUUID
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}




- (void)scanLoginBtnClick {
    
    QRScanViewController *qrScanVC = [[QRScanViewController alloc] init];
    qrScanVC.publicKeyStr = PublicKey;
    qrScanVC.privateKeyStr = PrivateKey;
    qrScanVC.walnutidStr = walnut_userid;
    [self.navigationController pushViewController:qrScanVC animated:YES];
    
}



@end
