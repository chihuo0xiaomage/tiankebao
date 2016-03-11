//
//  Encrypt.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Encrypt.h"
#include <CommonCrypto/CommonDigest.h>
@implementation Encrypt

+ (CGFloat)timeInterval
{
    NSDate * date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970];
    return time * 1000;
}
+ (NSString*)generate:(NSString *)urlStr
{
    if (urlStr.length == 0) {
        return nil;
    }
    NSString * keyValuesStr = @"";
    NSArray * keyValuesArray = [urlStr componentsSeparatedByString:@"&"];
    keyValuesArray = [keyValuesArray sortedArrayUsingSelector:@selector(compare:)];
    for (NSString * str in keyValuesArray) {
        NSArray * array = [str componentsSeparatedByString:@"="];
        for (NSString * str1 in array) {
            keyValuesStr = [NSString stringWithFormat:@"%@%@", keyValuesStr, str1];
            
        }
    }
    NSString * straa = [NSString stringWithFormat: @"abcdeabcdeabcdeabcdeabcde%@abcdeabcdeabcdeabcdeabcde", keyValuesStr];
        //NSString * straa = @"abcdeabcdeabcdeabcdeabcdeappKey00001clientmformatjsonlocalezh_CNmethodwop.user.verifyuserName2081180200100128012userPwd96e79218965eb72c92a549dd5a330112v1.0abcdeabcdeabcdeabcdeabcde";
    const char *cstr = [straa cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:straa.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
//    NSLog(@"[output uppercaseString] = %@", [output uppercaseString]);
    return [output uppercaseString];
}
+ (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        {
        [hash appendFormat:@"%02X", result[i]];
        }
    NSString *mdfiveString = [hash lowercaseString];
    
    NSLog(@"Encryption Result = %@",mdfiveString);
    return mdfiveString;
}

@end
