//
//  QRScanViewController.m
//  二维码扫描
//
//  Created by wk on 15/12/22.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "QRScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRView.h"
#import "KString.h"
#import "UIView+Extension.h"
#import "UIScreen+Extension.h"
#import "CreateKey.h"
#import "OpenSSLRSAWrapper.h"
#import "NSString+Base64.h"
#import "NSData+Base64.h"
#import <AFNetworking.h>
#import "KAFN.h"

// 屏幕宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// RGB颜色
#define COLOR(R ,G ,B ,A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]

//各种view按手机屏幕大小缩放时，用到的基准宽和高
#define ScaleWidth(width)  (SCREEN_WIDTH / 375 * width)
#define ScaleHeight(height)  (SCREEN_HEIGHT / 667 * height)

#define APPURL  @"http://192.168.1.174:8905"

@interface QRScanViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureDevice *device;
    AVCaptureDeviceInput *input;
    AVCaptureMetadataOutput *output;
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *preview;

}

@property (nonatomic, strong) QRView *qrView;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation QRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认配置
    [self defaultConfig];
    // 配置界面
    [self configUI];
    // 扫描区域布局
    [self updateLayout];
    
    
    // 顶部图片
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    [topImageView setImage:[UIImage imageNamed:@"topnav"]];
    [self.view addSubview:topImageView];
    topImageView.userInteractionEnabled = YES;
    
    // 返回按钮
    UIButton *backButton = [[UIButton alloc] init];
    backButton.frame = CGRectMake(5, 32, 23, 23);
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    // 顶部标题
    UILabel *titlelabel = [[UILabel alloc] init];
    titlelabel.text = @"扫一扫";
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.font = [UIFont systemFontOfSize:20];
    CGSize titleSize = [KString kSizeOfText:titlelabel.text withFont:titlelabel.font];
    CGFloat titleLabelX = (SCREEN_WIDTH - titleSize.width) / 2;
    titlelabel.frame = CGRectMake(titleLabelX, 30, titleSize.width, titleSize.height);
    [self.view addSubview:titlelabel];
    
    // 提示
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"请扫描二维码";
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.font = [UIFont systemFontOfSize:17];
    CGSize promptSize = [KString kSizeOfText:promptLabel.text withFont:promptLabel.font];
    CGFloat promptLabelX = (SCREEN_WIDTH - promptSize.width) / 2;
    CGFloat promptLabelY = ScaleHeight(130);
    promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptSize.width, promptSize.height);
    [self.view addSubview:promptLabel];
    
}



/**
 *  默认配置
 */
- (void)defaultConfig {
    
    #if !(TARGET_IPHONE_SIMULATOR)
    // 1. 实例化拍摄设备
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2. 设置输入设备
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3. 设置元数据输出
    output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 4. 添加拍摄会话
    session = [[AVCaptureSession alloc] init];
    if ([session canAddInput:input])
    {
        [session addInput:input];
    }
    
    if ([session canAddOutput:output])
    {
        [session addOutput:output];
    }
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    #endif
    
    // 5. 视频预览图层
    preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    preview.videoGravity =AVLayerVideoGravityResize;
    preview.frame = [UIScreen screenBounds];
    [self.view.layer insertSublayer:preview atIndex:0];
    
    // 6. 启动会话
    [session startRunning];
    
    
}



/**
 *  配置界面
 */
- (void)configUI {
    
    [self.view addSubview:self.qrView];
    
}

/**
 *  扫描区域布局
 */
- (void)updateLayout {
    
    
    _qrView.center = CGPointMake([UIScreen screenBounds].size.width / 2, [UIScreen screenBounds].size.height / 2);
    
    //修正扫描区域
    CGRect cropRect = CGRectMake((SCREEN_WIDTH - self.qrView.transparentArea.width) / 2,
                                 (SCREEN_HEIGHT - self.qrView.transparentArea.height) / 2,
                                 self.qrView.transparentArea.width,
                                 self.qrView.transparentArea.height);
    
    [output setRectOfInterest:CGRectMake(cropRect.origin.y / SCREEN_HEIGHT,
                                          cropRect.origin.x / SCREEN_WIDTH,
                                          cropRect.size.height / SCREEN_HEIGHT,
                                          cropRect.size.width / SCREEN_WIDTH)];
    
    
}


/**
 *  执行扫描完之后的代码，stringValue是扫描结果
 */
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [session stopRunning];
        // 正在处理
        [self addMaskView];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    KLog(@"stringValue:%@", stringValue);
    
    
    if ([stringValue rangeOfString:@"name:"].location != NSNotFound && [stringValue rangeOfString:@"#uuid:"].location != NSNotFound && [stringValue rangeOfString:@"#url:"].location != NSNotFound) {
        
        // 截取页面二维码中字符串
        NSArray *arr = [stringValue componentsSeparatedByString:@"#"];
        NSLog(@"arr ==== %@",arr);
        
        // 截取@":"之后的字符串
        NSString *nameStr = [KString kInterceptOriginalString:arr[0] withSpecifiedString:@":"];
        NSLog(@"nameStr ==== %@",nameStr);
        
        NSString *uuidStr = [KString kInterceptOriginalString:arr[1] withSpecifiedString:@":"];
        NSLog(@"uuidStr ==== %@",uuidStr);
        
        NSString *urlStr = [KString kInterceptOriginalString:arr[2] withSpecifiedString:@":"];
        NSLog(@"bindUrlStr ==== %@",urlStr);
        
        
        /**
         * 签名规则:
         * 用私钥对name+uuid 签名
         * 签名结果用base64编码
         */
        NSString *name = nameStr;
        NSString *uuid = uuidStr;
        NSString *mids = [NSString stringWithFormat:@"%@%@",name,uuid];
        
        CreateKey *key = [[CreateKey alloc] init];
        
        NSString * temp             = [key sha512:mids];
        OpenSSLRSAWrapper * wrapper = [OpenSSLRSAWrapper shareInstance];
        NSData * encrypData         = [wrapper encryptRSAKeyWithType: KeyTypePrivate plainText:temp];
        NSString *sign = [encrypData base64EncodedString];
        
//            NSString *sign = [key CreateMids:mids];
        
        NSLog(@"sign === %@", sign);
        
        NSLog(@"uuid === %@", uuidStr);
        
        NSString *walnutid = [key sha256:self.walnutidStr];
        
        NSString *pubkeyhash1 = [self.publicKeyStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *pubkeyhash2 = [pubkeyhash1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSLog(@"pubkeyhash2 === %@", pubkeyhash2);
        
        
        
        NSString *pubkeyhash = [key sha256:pubkeyhash2];
        
        
        
        NSLog(@"walnutid === %@", walnutid);
        NSLog(@"pubkeyhash === %@", pubkeyhash);
        
        
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
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"walnutid"] = walnutid;
        params[@"uuid"] = uuidStr;
        params[@"pubkeyhash"] = pubkeyhash;
        params[@"sign"] = sign;
        
        NSString *url = urlStr;
        NSLog(@"地址: %@", url);
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
        
        [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"responseObject: %@", responseObject);
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"Error: %@", error);
        }];

        

        
        
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请扫描正确二维码!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }

    
    
    
    

    
    
    
    
    
    
    
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_maskView removeFromSuperview];
//        [session startRunning];
//    });
    
    
    
    
    
}


// 返回按钮点击方法
- (void)backButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Getter and Setter
-(QRView *)qrView {
    
    if (!_qrView) {
        
        CGRect screenRect = [UIScreen screenBounds];
        _qrView = [[QRView alloc] initWithFrame:screenRect];
        _qrView.transparentArea = CGSizeMake(200, 200);
        
        _qrView.backgroundColor = [UIColor clearColor];
    }
    return _qrView;
}


/** 正在处理... */
- (void)addMaskView {
    
    // 蒙版
    _maskView = [[UIView alloc] init];
    _maskView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0.7;
    [self.view addSubview:self.maskView];
    // 菊花
    UIActivityIndicatorView *activityV = [[UIActivityIndicatorView alloc] init];
    activityV.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityV.frame = CGRectMake((SCREEN_WIDTH - activityV.width) / 2, SCREEN_HEIGHT / 2 - 20 - 64, activityV.width, activityV.height);
    [_maskView addSubview:activityV];
    [activityV startAnimating];
    // 提示
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"正在处理...";
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.font = [UIFont systemFontOfSize:15];
    CGSize promptSize = [KString kSizeOfText:promptLabel.text withFont:promptLabel.font];
    CGFloat promptLabelX = (SCREEN_WIDTH - promptSize.width) / 2;
    CGFloat promptLabelY = SCREEN_HEIGHT / 2 + 20 - 64;
    promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptSize.width, promptSize.height);
    [_maskView addSubview:promptLabel];

}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (![session isRunning]) {
        
        [self defaultConfig];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [preview removeFromSuperlayer];
    [session stopRunning];
}


@end
