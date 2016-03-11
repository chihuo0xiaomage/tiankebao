//
//  HYZGetCardTokenRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HYZGetCardTokenModel.h"

#import "JSONHTTPClient.h"

@protocol HYZGetCardTokenRequestDelegate <NSObject>

- (void)getCardTokenSuccess:(NSString *)token;

- (void)getCardTokenFaild:(NSString *)faildString;

@end

@interface HYZGetCardTokenRequest : NSObject

@property (nonatomic, assign) id <HYZGetCardTokenRequestDelegate> delegate;

- (void)getCardToken:(NSString *)cardNumberString;

@end
