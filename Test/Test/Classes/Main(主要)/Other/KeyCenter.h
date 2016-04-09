//
//  KeyCenter.h
//  StonePass
//
//  Created by 虞政凯 on 15/6/19.
//  Copyright (c) 2015年 虞政凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyCenter : NSObject


+(NSString *)createLongKey;

+(void)createShortKey:(NSString *)key;

+(NSString *)createMasterKey;

+(NSString *)createOldMasterKey;

+(NSString *)createOldLongKeyMasterKey;

+(NSString *)createCommunicationKey:(NSString *)sortKey;

+(NSString *)resetCommunicationKey:(NSString *)sortKey;

+(NSString *)checkKeyLongKey:(NSString *)longkey WithsortKey:(NSString *)sortkey;

+ (NSString*)sha256:(NSString *)str;

@end
