//
//  HYZLinkEmailRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZLinkEmailModel.h"

@protocol HYZLinkEmailRequestDelegate <NSObject>

- (void)linkEmailSuccess:(NSString *)successString;

- (void)linkEmailError:(NSString *)errorString;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZLinkEmailRequest : NSObject

@property (nonatomic, assign) id <HYZLinkEmailRequestDelegate>  delegate;

- (void)AddEmailLinkRequest:(NSString *)urlString;

@end
