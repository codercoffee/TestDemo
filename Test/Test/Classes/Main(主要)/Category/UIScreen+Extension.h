//
//  UIScreen+Extension.h
//  UIScreen
//
//  Created by wk on 15/12/22.
//  Copyright © 2015年 wk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Extension)

/**
 *  修正iOS8之前的版本，屏幕旋转时坐标系不变,返回修正之后的屏幕bounds
 *
 *  @return 修正之后的屏幕大小bounds（CGRect）
 */
+ (CGRect)screenBounds;

@end
