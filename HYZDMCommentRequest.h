//
//  HYZDMCommentRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZCommentMessageModel.h"

@protocol HYZDMCommentRequestDelegate <NSObject>

- (void)commentSuccess:(NSString *)successString;

- (void)requestFaild:(NSString *)faildString;

- (void)serveCommentSuccess:(NSString *)successtring;

@end

@interface HYZDMCommentRequest : NSObject

@property (nonatomic, assign) id <HYZDMCommentRequestDelegate>   delegate;

- (void)commentUserMessageRequest:(NSString *)urlString;

- (void)serveCommentRequest:(NSString *)urlString;

@end
