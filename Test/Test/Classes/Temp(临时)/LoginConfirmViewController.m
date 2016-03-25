//
//  LoginConfirmViewController.m
//  Text
//
//  Created by wk on 16/1/6.
//  Copyright © 2016年 wk. All rights reserved.
//

#import "LoginConfirmViewController.h"
#import "KAFN.h"
#import "KString.h"

// 屏幕宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// RGB颜色
#define COLOR(R ,G ,B ,A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]

//各种view按手机屏幕大小缩放时，用到的基准宽和高
#define ScaleWidth(width)  (SCREEN_WIDTH / 375 * width)
#define ScaleHeight(height)  (SCREEN_HEIGHT / 667 * height)

@interface LoginConfirmViewController ()

@end

@implementation LoginConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 隐藏导航栏
    [super.navigationController setNavigationBarHidden:YES];
    
    // 配置界面
    [self configUI];
    
}

- (void)configUI {
    
    // 背景图片
    UIImageView *backView = [[UIImageView alloc] init];
    backView.frame = [UIScreen mainScreen].bounds;
    [backView setImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:backView];
    
    // logo图片
    UIImageView *logoView = [[UIImageView alloc] init];
    CGFloat logoImageX = (SCREEN_WIDTH - ScaleWidth(149)) / 2;
    CGFloat logoImageY = ScaleHeight(155);
    logoView.frame = CGRectMake(logoImageX, logoImageY, ScaleWidth(149), ScaleHeight(92));
    [logoView setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:logoView];
    
    // 登录系统
    UILabel *systemLabel = [[UILabel alloc] init];
    systemLabel.text = [NSString stringWithFormat:@"%@登录确认", @"核桃安全"];
    systemLabel.textColor = [UIColor whiteColor];
    systemLabel.font = [UIFont systemFontOfSize:20];
    CGSize systemSize = [KString kSizeOfText:systemLabel.text withFont:systemLabel.font];
    CGFloat systemLabelX = (SCREEN_WIDTH - systemSize.width) / 2;
    CGFloat systemLabelY = ScaleHeight(308);
    systemLabel.frame = CGRectMake(systemLabelX, systemLabelY, systemSize.width, systemSize.height);
    [self.view addSubview:systemLabel];
    
    // 暗纹图片
    UIImageView *anwemView = [[UIImageView alloc] init];
    anwemView.frame = CGRectMake(0, ScaleHeight(518.5), SCREEN_WIDTH, ScaleHeight(148.5));
    [anwemView setImage:[UIImage imageNamed:@"anwen"]];
    [self.view addSubview:anwemView];
    
    // 确认按钮
    UIButton *confirmButton = [[UIButton alloc] init];
    CGFloat confirmBtnX = (SCREEN_WIDTH - ScaleWidth(255)) / 2;
    CGFloat confirmBtnY = ScaleHeight(496);
    confirmButton.frame = CGRectMake(confirmBtnX, confirmBtnY, ScaleWidth(255), ScaleHeight(50));
    [confirmButton setImage:[UIImage imageNamed:@"确--认"] forState:UIControlStateNormal];
//    [confirmButton setImage:[UIImage imageNamed:@"确--认"] forState:UIControlStateHighlighted];
    [confirmButton addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    
    // 取消按钮
    UIButton *cancleButton = [[UIButton alloc] init];
    CGFloat cancleBtnX = (SCREEN_WIDTH - ScaleWidth(255)) / 2;
    CGFloat cancleBtnY = ScaleHeight(562);
    cancleButton.frame = CGRectMake(cancleBtnX, cancleBtnY, ScaleWidth(255), ScaleHeight(50));
    [cancleButton setImage:[UIImage imageNamed:@"取--消"] forState:UIControlStateNormal];
//    [cancleButton setImage:[UIImage imageNamed:@"取--消"] forState:UIControlStateHighlighted];
    [cancleButton addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleButton];
    
}

- (void)confirmBtnClick {
    
    
}

- (void)cancleBtnClick {
    
    
}


@end
