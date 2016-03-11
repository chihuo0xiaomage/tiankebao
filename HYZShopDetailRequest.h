//
//  HYZShopDetailRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZShopDetailModel.h"

@protocol HYZShopDetailRequestDelegate <NSObject>

- (void)shopDetailSentSuccess:(NSString *)successString;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZShopDetailRequest : NSObject

@property (nonatomic, assign) id <HYZShopDetailRequestDelegate> delegate;

- (void)shopDetailSentRequest:(NSString *)urlString;

@end
