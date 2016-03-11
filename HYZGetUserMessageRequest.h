//
//  HYZGetUserMessageRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZGetUerMessageModel.h"

@protocol HYZGetUserMessageRequestDelegate <NSObject>

- (void)getMessage:(NSString *)message openToken:(NSString *)token password:(NSString *)password userName:(NSString *)username;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZGetUserMessageRequest : NSObject

@property (nonatomic, assign) id <HYZGetUserMessageRequestDelegate> delegate;

- (void)getUserMessageRequest:(NSString *)urlString;

@end
