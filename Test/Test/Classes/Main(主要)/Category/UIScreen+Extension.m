//
//  UIScreen+Extension.m
//  UIScreen
//
//  Created by wk on 15/12/22.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "UIScreen+Extension.h"

@implementation UIScreen (Extension)


+ (CGRect)screenBounds
{
    UIScreen *screen = [UIScreen mainScreen];
    CGRect screenRect;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
    {
//        screenRect = CGRectMake(screen.bounds.origin.x, screen.bounds.origin.y, screen.bounds.size.height, screen.bounds.size.width);
        screenRect = CGRectMake(0, 0, screen.bounds.size.height, screen.bounds.size.width);
    }
    else
    {
        screenRect = screen.bounds;
    }
    return screenRect;
}


@end
