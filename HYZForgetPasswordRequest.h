//
//  HYZForgetPasswordRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZRegisterModel.h"

@protocol HYZForgetPasswordRequestDelegate <NSObject>

- (void)requestSuccess:(NSString *)successString;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZForgetPasswordRequest : NSObject

@property (nonatomic, assign) id <HYZForgetPasswordRequestDelegate> delegate;

- (void)forgotUserPasswordRequest:(NSString *)urlString;

@end
