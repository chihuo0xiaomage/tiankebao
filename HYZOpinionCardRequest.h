//
//  HYZOpinionCardRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZOpinionCardModel.h"

@protocol HYZOpinionCardRequestDelegate <NSObject>

- (void)opinionSuccess:(NSString *)messageString;

- (void)opinionFalse:(NSString *)falseString;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZOpinionCardRequest : NSObject

@property (nonatomic, assign) id <HYZOpinionCardRequestDelegate> delegate;

- (void)opinionCardRequest:(NSString *)urlString;

@end
