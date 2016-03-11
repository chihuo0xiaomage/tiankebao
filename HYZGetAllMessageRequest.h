//
//  HYZGetAllMessageRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZGetAllMessageModel.h"

@protocol HYZGetAllMessageRequestDelegate <NSObject>

- (void)getUserMessageSuccess:(NSArray *)messageArray;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZGetAllMessageRequest : NSObject

@property (nonatomic, assign) id <HYZGetAllMessageRequestDelegate>   delegate;

- (void)getAllMessageRequest:(NSString *)urlString;

@end
