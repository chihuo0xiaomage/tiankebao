//
//  HYZGetCardRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZGetCardModel.h"

@protocol HYZGetCardRequestDelegate <NSObject>

- (void)getUserCardSuccess:(NSArray *)cardArray;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZGetCardRequest : NSObject

@property (nonatomic, assign) id <HYZGetCardRequestDelegate> delegate;

- (void)getCardRequest:(NSString *)urlString;

@end
