//
//  HYZSaveConsumeRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZSaveConsumeModel.h"

@protocol HYZSaveConsumeRequestDelegate <NSObject>

- (void)requestSuccess:(NSString *)successString barCode:(NSString *)barCode;

- (void)requestError:(NSString *)errorString;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZSaveConsumeRequest : NSObject

@property (nonatomic, assign) id <HYZSaveConsumeRequestDelegate>  delegate;

- (void)commitConsumeMessageRequest:(NSString *)urlSring barCode:(NSString *)barCode;

@end
