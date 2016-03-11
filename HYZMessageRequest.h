//
//  HYZMessageRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZUserMessgeModel.h"

#import "HYZNewMessageModel.h"

@protocol HYZMessageRequestDelegate <NSObject>

- (void)getUserCardMessageSuccess:(NSArray *)messageArray userName:(NSString *)aString;

- (void)requestFaild:(NSString *)faildString;

- (void)getMessageSuccess:(NSArray *)messageArray;

@end

@interface HYZMessageRequest : NSObject

@property (nonatomic, assign) id <HYZMessageRequestDelegate>   delegate;

- (void)messageRequest:(NSString *)urlString;

- (void)UserCardMessageRequest:(NSString *)urlStr userName:(NSString *)aString;

@end
