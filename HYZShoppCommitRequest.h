//
//  HYZShoppCommitRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZShoppCommitModel.h"

@protocol HYZShoppCommitRequestDelegate <NSObject>

- (void)commitSuccess:(NSString *)successString barCode:(NSString *)barCode;

- (void)commitFaild:(NSString *)faildString;

@end

@interface HYZShoppCommitRequest : NSObject

@property (nonatomic, assign) id <HYZShoppCommitRequestDelegate> delegate;

- (void)commitShopMessageRequest:(NSString *)urlString barCode:(NSString *)barCode;

@end
