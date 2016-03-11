//
//  HYZLinkMoreCardRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZLinkModel.h"

#import "HYZLinkMoreCardModel.h"

@protocol HYZLinkMoreCardRequestDelegate <NSObject>

- (void)checkoutRequestSuccess:(NSString *)cardNumberString password:(NSString *)passwordString;

- (void)checkoutRequestFaild:(NSString *)faildString;

- (void)requestFaild:(NSString *)faildString;

- (void)linkSuccess:(NSString *)successString;

@end

@interface HYZLinkMoreCardRequest : NSObject

@property (nonatomic, assign) id <HYZLinkMoreCardRequestDelegate>   delegate;

- (void)opitionThisVaildCard:(NSString *)cardNumber password:(NSString *)passwordString token:(NSString *)tokenString;

- (void)linkCardRequest:(NSString *)urlString;

@end
