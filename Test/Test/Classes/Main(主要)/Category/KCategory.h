//
//  KCategory.h
//  KCategory
//
/*

#import "KCategory.h"

*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "KString.h"
#import "KColor.h"
#import "KAFN.h"
#import "NSString+MD5.h"
#import "UIScreen+Extension.h"

/** 打印输出 */
#ifdef DEBUG  // 调试阶段
#define KLog(...) NSLog(__VA_ARGS__)
#else // 发布阶段
#define KLog(...)
#endif

// 屏幕宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// RGB颜色
#define kCOLOR(R ,G ,B ,A) [UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:A]
// 随机色
#define kRandomColor kCOLOR(arc4random() % 256, arc4random() % 256, arc4random() % 256, 1)

// 各种view按手机屏幕大小缩放时，用到的基准宽和高
#define kScaleWidth(width)  (SCREEN_WIDTH / 375 * width)
#define kScaleHeight(height)  (SCREEN_HEIGHT / 667 * height)

// 偏好设置
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kFileManager  [NSFileManager defaultManager]

// 适配6.0
#ifdef __IPHONE_6_0
# define kALIGN_CENTER NSTextAlignmentCenter
#else
# define kALIGN_CENTER UITextAlignmentCenter
#endif

#ifdef __IPHONE_6_0
# define kALIGN_LEFT NSTextAlignmentLeft
#else
# define kALIGN_LEFT UITextAlignmentLeft
#endif





