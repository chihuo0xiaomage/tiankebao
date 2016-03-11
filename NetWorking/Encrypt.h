//
//  Encrypt.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encrypt : NSObject

+ (CGFloat)timeInterval;
+ (NSString*)generate:(NSString *)urlStr;
+ (NSString *)md5HexDigest:(NSString*)password;
@end
