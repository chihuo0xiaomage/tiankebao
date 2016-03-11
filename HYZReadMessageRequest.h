//
//  HYZReadMessageRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZReadMessageModel.h"

@protocol HYZReadMessageRequestDelegate <NSObject>

- (void)readMessageSuccess:(NSString *)successString codeString:(NSString *)code;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZReadMessageRequest : NSObject

@property (nonatomic, assign) id <HYZReadMessageRequestDelegate>   delegate;

- (void)readMessageRequest:(NSString *)urlString codeString:(NSString *)code;

@end
