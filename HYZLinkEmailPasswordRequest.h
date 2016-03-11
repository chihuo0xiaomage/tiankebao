//
//  HYZLinkEmailPasswordRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZLinkEmailPasswordModel.h"

@protocol HYZLinkEmailPasswordRequestDelegate <NSObject>

- (void)linkSuccess:(NSString *)successString;

- (void)linkError:(NSString *)errorString;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZLinkEmailPasswordRequest : NSObject

@property (nonatomic, assign) id <HYZLinkEmailPasswordRequestDelegate> delegate;

- (void)sentEmailPasswordRequest:(NSString *)urlString;

@end
