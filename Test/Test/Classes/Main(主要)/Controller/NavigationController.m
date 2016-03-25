//
//  NavigationController.m
//  QRToken Enterprise
//
//  Created by wk on 15/11/9.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

+ (void)initialize{
    
    // 设置整个项目的所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key:NS***AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super.navigationController setNavigationBarHidden:YES];
    
//    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
//        
//        /* 自动显示和隐藏tabBar */
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//        /* 设置导航栏上面的内容 */
//        // 设置左边的返回按钮
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highLightedImage:@"navigationbar_back_highlighted"];
//        
//        // 设置右边的更多按钮
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highLightedImage:@"navigationbar_more_highlighted"];
//        
//    }
    
    [super pushViewController:viewController animated:animated];
    
}


- (void)back {
#warning 这里要用self，不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController是nil的
    [self popViewControllerAnimated:YES];
}

- (void)more {
    
    [self popToRootViewControllerAnimated:YES];
}




@end
