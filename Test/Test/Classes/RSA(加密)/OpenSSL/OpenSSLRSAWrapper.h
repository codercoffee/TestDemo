//
//  OpenSSLRSAWrapper.h
//  Text
//
//  Created by wk on 15/12/30.
//  Copyright © 2015年 wk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenSSL/rsa.h>
#import <OpenSSL/pem.h>

typedef enum {
    KeyTypePublic,
    KeyTypePrivate
}KeyType;

typedef enum {
    RSA_PADDING_TYPE_NONE       = RSA_NO_PADDING,
    RSA_PADDING_TYPE_PKCS1      = RSA_PKCS1_PADDING,
    RSA_PADDING_TYPE_SSLV23     = RSA_SSLV23_PADDING
}RSA_PADDING_TYPE;

@interface OpenSSLRSAWrapper : NSObject
{
    RSA *_rsa;
}

/**
 Thanks to Berin with this property at link:
 http://blog.wingsofhermes.org/?p=42
 
 @property publicKeyBase64
 @discussion This property is presented by the local file.And `exportRSAKeys` should be called before get this.
 @return public key base64 encoded string.
 */
@property (nonatomic,strong) NSString *publicKeyBase64;

/**
 @property privateKeyBase64
 @discussion This property is presented by the local file.And `exportRSAKeys` should be called before get this.
 @return private key base64 encoded string.
 */
@property (nonatomic,strong) NSString *privateKeyBase64;

/**
 Creates and initializes an `OpenSSLRSAWrapper` object.
 
 *@return The newly-initialized OpenSSLRSAWrapper
 */
+ (id)shareInstance;

/**
 Generate rsa key pair by the key size.
 
 @param keySize RSA key bits . The value could be `512`,`1024`,`2048` and so on.
 Normal is `1024`.
 */
- (BOOL)generateRSAKeyPairWithKeySize:(NSInteger)keySize;

/**
 Export the public key and the private key to local file.So that we can import the keys.
 
 @discussion The method `generateRSAKeyPairWithKeySize:` should be called before this method.
 @return Success or not.
 */
- (BOOL)exportRSAKeys;

/**
 Import rsa key pairs from local file with type.
 
 @param type `KeyTypePublic` or `KeyTypePrivate` is present.
 @discussion If the method `generateRSAKeyPairWithKeySize:` wasn't called before and also the method `exportRSAKeys`,
 This method will never success.
 @return Success or not.
 */
- (BOOL)importRSAKeyWithType:(KeyType)type;

/**
 RSA encrypt the plain text with private or public key.
 
 @param keyType `KeyTypePublic` or `KeyTypePrivate` is present.
 @param text  The string that will be encrypted.
 @return The enrypted data.
 */
- (NSData*)encryptRSAKeyWithType:(KeyType)keyType plainText:(NSString*)text;

/**
 RSA decrypt the data that encrypted.
 
 @param keyType `KeyTypePublic` or `KeyTypePrivate` is present.
 @param data  The data that encrypted.
 @return The plain text.
 */
- (NSString*)decryptRSAKeyWithType:(KeyType)keyType data:(NSData*)data;


@end
