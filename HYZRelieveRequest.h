//
//  HYZRelieveRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZRelieveModel.h"

@protocol HYZRelieveRequestDelegate <NSObject>

- (void)relieveRequestSuccess:(NSString *)successString;

- (void)relieveRequestFaild:(NSString *)faildString;

@end

@interface HYZRelieveRequest : NSObject

@property (nonatomic, assign) id <HYZRelieveRequestDelegate>  delegate;

- (void)relieveTheCardRequest:(NSString *)urlString;

@end
