//
//  QRScanViewController.h
//  二维码扫描
//
//  Created by wk on 15/12/22.
//  Copyright © 2015年 wk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRScanViewController : UIViewController

@property (nonatomic, strong) NSString *publicKeyStr;

@property (nonatomic, strong) NSString *privateKeyStr;

@property (nonatomic, strong) NSString *walnutidStr;

@end
