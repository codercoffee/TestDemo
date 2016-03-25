//
//  CreateKey.h
//  QRCode
//
//  Created by wk on 15/12/30.
//  Copyright © 2015年 wk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateKey : NSObject

-(void)CreatePublicKeyAndPrivateKey;

-(NSString * )SelectSHA256PrivateKey;

-(NSString *)SelectPublicKey;

-(NSString *)CreateMids:(NSString *)string;

-(void)UpdatePublicKeyAndPrivateKey;

- (NSString*)sha256:(NSString *)str;

-(NSString *)sha512:(NSString *)str;

@end
