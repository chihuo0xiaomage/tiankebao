//
//  HYZCommitTopUpRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZCommitTopUpModel.h"

@protocol HYZCommitTopUpRequestDelegete <NSObject>

- (void)commitTopUpMessageSuccess:(NSString *)messageString;

- (void)commitTopUpMessagefalse:(NSString *)messageString;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZCommitTopUpRequest : NSObject

@property (nonatomic, assign) id <HYZCommitTopUpRequestDelegete>  delegate;

- (void)commitChongZhiMessageRequest:(NSString *)urlString;

@end
