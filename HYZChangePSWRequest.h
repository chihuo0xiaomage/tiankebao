//
//  HYZChangePSWRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZChangePSWModel.h"

@protocol HYZChangePSWRequestDelegate <NSObject>

- (void)changePasswordSuccess:(NSString *)successString;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZChangePSWRequest : NSObject

@property (nonatomic, assign) id <HYZChangePSWRequestDelegate>    delegate;

- (void)changePasswordRequest:(NSString *)urlString;

@end
