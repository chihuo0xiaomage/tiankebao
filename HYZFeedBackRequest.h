//
//  HYZFeedBackRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZFeedBackModel.h"

@protocol HYZFeedBackRequestDelegate <NSObject>

- (void)sendSuccess:(NSString *)successString;

- (void)sendFaild:(NSString *)faildString;

@end

@interface HYZFeedBackRequest : NSObject

@property (nonatomic, assign) id <HYZFeedBackRequestDelegate> delegate;

- (void)sendFeedBackMessage:(NSString *)urlString;

@end
