//
//  AppDelegate.m
//  Test
//
//  Created by wk on 16/3/25.
//  Copyright © 2016年 wk. All rights reserved.
//

#import "AppDelegate.h"
#import "TextViewController.h"
#import "RSAViewController.h"
#import "NavigationController.h"
#import "LoginConfirmViewController.h"
#import "RefreshViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // 创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 创建根视图控制器
    //    LoginConfirmViewController *loginConfirmVC = [[LoginConfirmViewController alloc] init];
    //    TextViewController *textVC = [[TextViewController alloc] init];
    //    RSAViewController *rsaVC = [[RSAViewController alloc] init];
    
    RefreshViewController *refreshVC = [[RefreshViewController alloc] init];
    NavigationController *navigationC = [[NavigationController alloc] initWithRootViewController:refreshVC];
    self.window.rootViewController = navigationC;
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    // 设置状态栏的字体颜色为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    
    
    
    
    
    
    
    
    
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
