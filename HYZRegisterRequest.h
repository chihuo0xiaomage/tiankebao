//
//  HYZRegisterRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZRegisterModel.h"

@protocol HYZRegisterRequestDelegate <NSObject>

- (void)registerSuccessString:(NSString *)successString;

- (void)requestFaildString:(NSString *)faildString;

@end

@interface HYZRegisterRequest : NSObject

@property (nonatomic, assign) id <HYZRegisterRequestDelegate>  delegate;

- (void)registerRequest:(NSString *)urlSting;

@end
