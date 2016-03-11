//
//  HYZGoodMessageRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZGoodMessageModel.h"

#import "SBJsonParser.h"

@protocol HYZGoodMessageRequestDelegate <NSObject>

- (void)getGoodMessageSuccess:(NSArray *)messageArray;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZGoodMessageRequest : NSObject

@property (nonatomic, assign) id <HYZGoodMessageRequestDelegate>  delegate;

- (void)requestGoodMessage:(NSString *)urlString;

@end
